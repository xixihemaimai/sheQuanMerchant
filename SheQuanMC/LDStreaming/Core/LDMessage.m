//
//  LDMessage.m
//  LDStreaming
//
//  Created by 千亦 on 2021/7/13.
//

#import "LDMessage.h"
#import <LDMessage/ProtobufPacket.pbobjc.h>
#import "LDConfig.h"
#import "LDAckIdGenerater.h"

@implementation LDStreamingRequest {
    DLMMessageHeader *_header;
    DLMPacketInfo *msg;
}

+ (DLMMessageHeader *)createHeader {
    DLMMessageHeader *header = [DLMMessageHeader new];
    header.accessToken = LDConfig.shared.accessToken;
    header.versionId = LDConfig.shared.versionId;
    header.nonce = [self gs_getCurrentTimeToMilliSecond];
    header.ts = [self gs_getCurrentTimeToMilliSecond];
    header.appId = LDConfig.shared.appId;
    header.appVer = LDConfig.shared.appVer;
    header.deviceId = LDConfig.shared.deviceId;
    header.sign = LDConfig.shared.sign;
    return header;
}

+ (long long)gs_getCurrentTimeToMilliSecond {
    double currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
    long long iTime = (long long)currentTime;
    return iTime;
}

- (void)setResponse:(LDResponseCallback)response  {
    _response = response;
    _ackId = [LDAckIdGenerater generateId];
}

- (NSData *)data {
    msg = [DLMPacketInfo new];
    msg.header = _header = [LDStreamingRequest createHeader];
    msg.eventType = self.eventType;
    if (self.body) {
        msg.data_p = self.body.data;
    }
    if (self.response) {
        msg.ackId = _ackId;
    }
    return msg.data;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n=====\nreq:\n%@\nheader:\n%@\n body:\n%@\n=====\n", msg, _header, self.body];
}

- (void)errorWithTimeout {
    [self errorWithNetWork:@"Timeout"];
}
- (void)errorWithNetError {
    [self errorWithNetWork:@"NetError"];
}

- (void)errorWithNetWork:(NSString *)msg {
    if (self.isFinished) {
        return;
    }
    self.isFinished = YES;
    if (!self.response) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        DLMPacketInfo *pkg = [DLMPacketInfo new];
        pkg.eventType = -1;
        pkg.status = -1;
        pkg.msg = msg;
        self.response(pkg);
    });
}

@end


@implementation LDStreamingResponse


@end


@implementation LDMessage


#pragma mark - utils

@end
