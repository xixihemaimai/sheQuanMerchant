//
//  LDStreamBuffer.m
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import "LDStreamBuffer.h"
#import <LDMessage/ProtobufPacket.pbobjc.h>

#define PER_ALLOC_SIZE 8192

@interface LDStreamBuffer ()

@property (nonatomic,strong) NSMutableData* streamData;

@property (nonatomic,strong) NSMutableArray<NSData*>* netPacketArray;

@property (nonatomic,strong) dispatch_queue_t processPacketQueue ;

@property (nonatomic,strong) NSMutableArray<NSData*>* localPacketArray;

@end

@implementation LDStreamBuffer

#pragma mark - *** Properties ***

- (NSMutableArray<NSData*>*)netPacketArray {
    if (!_netPacketArray) {
        _netPacketArray = [[NSMutableArray alloc] initWithCapacity:PER_ALLOC_SIZE];
    }
    return _netPacketArray;
}

- (NSMutableArray<NSData*>*)localPacketArray {
    if (!_localPacketArray) {
        _localPacketArray = [[NSMutableArray alloc] init];
    }
    return _localPacketArray;
}

- (NSMutableData*)streamData {
    if (!_streamData) {
        _streamData = [[NSMutableData alloc] initWithCapacity:PER_ALLOC_SIZE];
    }
    return _streamData;
}

- (dispatch_queue_t)processPacketQueue {
    if (!_processPacketQueue) {
        _processPacketQueue = dispatch_queue_create("com.queue.processPacket", DISPATCH_QUEUE_SERIAL);;
    }
    return _processPacketQueue;
}

#pragma mark - *** Api ***

- (NSData*)readSliceData:(NSInteger)lenght offset:(NSInteger) offset {
    //NSMutableData* packetData = [[NSMutableData alloc] init];
    return nil;
}

- (void)appendData:(NSData*)data {
    __weak LDStreamBuffer* weakSelf = self;
    dispatch_async(self.processPacketQueue, ^{
        [weakSelf.streamData appendData:data];
        [weakSelf processPacket];
    });
    
}

- (void)processPacket{
    __weak LDStreamBuffer* weakSelf = self;

    NSInteger readOffset = 0;
    NSInteger streamDataLength = weakSelf.streamData.length;
    int8_t* streamBuffer = weakSelf.streamData.mutableBytes;
    while (readOffset < streamDataLength) {
        @autoreleasepool {
            NSInteger offset = 0;
            int8_t* buffer = streamBuffer + readOffset;
            NSInteger remainLenght = streamDataLength - readOffset;
            NSInteger packetLen = [weakSelf parseBufferHeader:buffer len:remainLenght offset:&offset];
            if(0 == packetLen) {
                return;
            }
            if(remainLenght >= packetLen + offset) {
                NSData* data = [weakSelf.streamData subdataWithRange:NSMakeRange(readOffset+offset + 1, packetLen)];
                readOffset += packetLen + offset + 1;
                NSError* error;
                DLMPacketInfo *message = [DLMPacketInfo parseFromData:data error:&error];
                if (error) {
                    if ([self.delegate respondsToSelector:@selector(didReadError:)]) {
                        [self.delegate didReadError:error];
                    }
                } else {
                    if ([self.delegate respondsToSelector:@selector(didReadPackage:)]) {
                        [self.delegate didReadPackage:message];
                    }
                }
            } else {
                //
                NSData* data = [weakSelf.streamData subdataWithRange:NSMakeRange(readOffset, remainLenght)];
                [weakSelf.streamData replaceBytesInRange:NSMakeRange(0, data.length) withBytes:data.bytes];
                weakSelf.streamData.length = data.length;
                break;
            }
        }
    }
    
    if(readOffset == streamDataLength) {
        if (readOffset > PER_ALLOC_SIZE) {
            weakSelf.streamData = [[NSMutableData alloc] initWithCapacity:PER_ALLOC_SIZE];
        }
        else{
            weakSelf.streamData.length = 0;
  
        }
    }
}


- (NSInteger)parseBufferHeader:(int8_t*)buffer len:(NSInteger)length offset:(NSInteger*)offset{
    if (length <= 0) {
        return 0;
    }
   // int8_t* buffer = (int8_t*)data.bytes;
    *offset = 0;
    int8_t tmp = buffer[*offset];
    if (tmp >= 0) {
        return tmp;
    } else {
        int result = tmp & 127;
        (*offset) ++;
        if ((*offset) >= length) {
            return 0;
        }
        //判断流数据中是否还有数据
        if ((tmp = buffer[*offset]) >= 0) {
            result |= tmp << 7;
        } else {
            result |= (tmp & 127) << 7;
            //判断流数据中是否还有数据
            (*offset) ++;
            if ((*offset) >= length) {
                return 0;
            }
            if ((tmp = buffer[*offset]) >= 0) {
                result |= tmp << 14;
            } else {
                result |= (tmp & 127) << 14;
                //判断流数据中是否还有数据
                (*offset) ++;
                if ((*offset) >= length) {
                    return 0;
                }
                if ((tmp = buffer[*offset]) >= 0) {
                    result |= tmp << 21;
                } else {
                    result |= (tmp & 127) << 21;
                    //判断流数据中是否还有数据
                    (*offset) ++;
                    if ((*offset) >= length) {
                        return 0;
                    }
                    result |= (tmp = buffer[*offset]) << 28;
                    if (tmp < 0) {
                        assert(0);
                    }
                }
            }
        }
        return result;
    }
}

+ (NSInteger)computeByteSizeForInt32:(NSInteger) value{
    if ((value & (0xffffffff <<  7)) == 0) {
        return 1;
    }
    if ((value & (0xffffffff << 14)) == 0) {
        return 2;
    }
    if ((value & (0xffffffff << 21)) == 0) {
        return 3;
    }
    if ((value & (0xffffffff << 28)) == 0) {
        return 4;
    }
    return 5;
}

+ (NSData *)packData:(NSData *)data {
    NSInteger bodyLen = data.length;
    NSInteger headerLen = [self computeByteSizeForInt32:bodyLen];
    NSMutableData* sendData = [[NSMutableData alloc] initWithCapacity:data.length + headerLen];
    while (true) {
        if ((bodyLen & ~0x7F) == 0) {
            int8_t value = (int8_t)bodyLen;
            [sendData appendBytes:&value length:sizeof(value)];
            break;
        } else {
            int8_t value = (bodyLen & 0x7F) | 0x80;
            [sendData appendBytes:&value length:sizeof(value)];
            bodyLen >>= 7;
        }
    }
    [sendData appendData:data];
    return sendData;
//    return data;
}

@end
