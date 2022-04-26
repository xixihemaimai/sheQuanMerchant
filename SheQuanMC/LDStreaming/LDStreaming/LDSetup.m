//
//  LDSetup.m
//  LDStreaming
//
//  Created by 千亦 on 2021/7/15.
//  Copyright © 2021 liaodian. All rights reserved.
//

#import "LDSetup.h"
#import <LDStreaming/LDStreaming.h>

#import <CocoaLumberjack/DDLog.h>

@implementation LDSetup

+ (void)setup {
    [self setupCommon];
    [self setupStreaming];
}

+ (void)setupCommon {
    
}

+ (void)setupStreaming {
    LDConfig *config = [LDConfig shared];
    config.host = @"27.154.225.198";
    config.port = 28996;
    
    config.keepliveInterval = 2;
    
    {
        config.accessToken = @"fd82f19eb2f7433369766ede5d789644051bcb3f4cdc2c378b287f728ebe258e737e93b9c42ca47a953388d29dc3e8ed";
        config.versionId = @"1.0.0";
        config.appId = @"ios";
        config.appVer = @"11.2.0";
        config.deviceId = @"89644051bcb3f4cdc2c378b287f728ebe2";
        config.sign = @"ebe258e737e93b9c42ca47a953388";
    }
    
    [LDClient setup];
}

@end
