//
//  LDDB.m
//
//  Created by Milker on 2021/8/8.
//

#import "LDDB.h"
#import <WCDB/WCDB.h>


// Models
// END

@implementation LDDB {
    WCTDatabase *database;
}

+ (LDDB *)shared {
    static LDDB *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LDDB alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    [self initDB];
    return self;
}

+ (NSString *)rootPath {
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [rootPath stringByAppendingPathComponent:@"database"];
    return path;
}

+ (NSString *)dbPath {
    return [[self rootPath] stringByAppendingPathComponent:@"db.sqlite"];
}

- (void)initDB {
    NSString *dbPath = [LDDB dbPath];

//    Error Monitor
    [WCTStatistics SetGlobalErrorReport:^(WCTError *error) {
        NSLog(@"dberror %@", error);
    }];

    database = [[WCTDatabase alloc] initWithPath:dbPath];
}

#pragma mark - crud

//+ (BOOL)upgradeWithMods:(NSArray<BFCModModel *> *)mods {
//    if ([self isInited]) {
//        return YES;
//    }
//    __block BOOL isOK = YES;
//
//    [mods.copy enumerateObjectsUsingBlock:^(BFCModModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        if (model.pool.length == 0 ||
//            model.mod.length == 0 ||
//            model.ver.length == 0 ||
//            model.fileName.length == 0) {
//            return;
//        }
//
//        BFCModDBModel *dbModel = [BFCModWCDB modelToDBModel:model];
//        dbModel.isAutoIncrement = YES;
//        isOK = [[BFCModWCDB shared]->database insertObject:dbModel into:kModTableName];
//    }];
//
//    return isOK;
//}
//
//+ (BOOL)saveModel:(BFCModModel *)model {
//    BFCModModel *oldModel = [self queryModelWithPool:model.pool mod:model.mod];
//    if (nil == oldModel) {
//        return [self createModel:model];
//    } else {
//        return [self updateModel:model];
//    }
//    return NO;
//}
//
//+ (BOOL)createModel:(BFCModModel *)model {
//    BFCModDBModel *dbModel = [self modelToDBModel:model];
//    dbModel.isAutoIncrement = YES;
//    BOOL res = [[BFCModWCDB shared]->database insertObject:dbModel into:kModTableName];
//    return res;
//}
//
//+ (BOOL)updateModel:(BFCModModel *)model {
//    BFCModDBModel *dbModel = [self modelToDBModel:model];
//    BOOL res = [[BFCModWCDB shared]->database updateRowsInTable:kModTableName
//                                                   onProperties:{BFCModDBModel.version,BFCModDBModel.force_idx,BFCModDBModel.expired,BFCModDBModel.data}
//                                                     withObject:dbModel
//                                                          where:BFCModDBModel.pool.is(model.pool) & BFCModDBModel.mod.is(model.mod)];
//    return res;
//}
//
//// 删除记录
//+ (BOOL)deleteModel:(BFCModModel *)model {
//    BOOL res = [[BFCModWCDB shared]->database deleteObjectsFromTable:kModTableName
//                                                               where:BFCModDBModel.pool.is(model.pool) & BFCModDBModel.mod.is(model.mod)];
//    return res;
//}
//
//+ (BOOL)setExpiredWithModel:(BFCModModel *)model {
//    BOOL res = [[BFCModWCDB shared]->database updateRowsInTable:kModTableName
//                                                     onProperty:BFCModDBModel.expired
//                                                      withValue:@(1)
//                                                          where:BFCModDBModel.pool.is(model.pool) & BFCModDBModel.mod.is(model.mod)];
//    return res;
//}
//
//+ (BOOL)deleteExpiredModels {
//    BOOL res = [[BFCModWCDB shared]->database deleteObjectsFromTable:kModTableName
//                                                               where:BFCModDBModel.expired.is(1)];
//    return res;
//}
//
//// 所有有效记录
//+ (NSArray<BFCModModel *> *)allModels {
//    __block NSMutableArray *items = [NSMutableArray new];
//    NSArray<BFCModDBModel *> *res = [[BFCModWCDB shared]->database getAllObjectsOfClass:BFCModDBModel.class fromTable:kModTableName];
//    [res enumerateObjectsUsingBlock:^(BFCModDBModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [items addObject:[self dbModelToModel:obj]];
//    }];
//    return items;
//}
//
//// 查询，必须传递完整的Mod path , 即： pool/mod_name
//+ (BFCModModel *)queryModelWithPool:(NSString *)pool mod:(NSString *)mod {
//    NSArray<BFCModDBModel *> *res = [[BFCModWCDB shared]->database getObjectsOfClass:BFCModDBModel.class
//                                                                           fromTable:kModTableName
//                                                                               where:BFCModDBModel.pool.is(pool) & BFCModDBModel.mod.is(mod)];
//    if (res.count > 0) {
//        return [self dbModelToModel:res.firstObject];
//    }
//    return nil;
//}

@end
