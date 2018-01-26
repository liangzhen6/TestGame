//
//  RandomData.m
//  TESTImage
//
//  Created by shenzhenshihua on 2018/1/26.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "RandomData.h"
#import "DataModel.h"
@interface RandomData ()
@property(nonatomic,assign)NSInteger diff;
@property(nonatomic,strong)NSMutableArray * selectArrM;
@end
static RandomData *_random = nil;
@implementation RandomData
+ (id)shareRandomData {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_random == nil) {
            _random = [[RandomData alloc] init];
        }
    });
    return _random;
}

- (void)selectModel:(DataModel *)model resblock:(ResultBlock)block {
    if (model.choose) {
        [self.selectArrM addObject:model];
        NSInteger seletNums = _diff<3?1:_diff;
        if (self.selectArrM.count == seletNums) {
            if (block) {
                block(YES);
            }
            //选中的个数与 随机的个数相等，证明通关
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.resultBlock) {
                    self.resultBlock(YES);
                }
            });
        }
    } else {
        //选错了，Game Over
        if (self.resultBlock) {
            self.resultBlock(NO);
        }
    }
}




- (NSArray *)randomWithDiff:(NSInteger)diff {
    [self.selectArrM removeAllObjects];
    _diff = diff;
    NSMutableArray * _dataArrM = [[NSMutableArray alloc] init];
    NSInteger seletNums = diff<3?1:diff;
    NSInteger countNum = diff * diff;
    
    NSMutableArray * randomSelectArrM = [self creatRandomCount:seletNums maxNum:countNum];
    
    NSMutableArray * randomDataArrM = [self creatRandomCount:countNum maxNum:countNum];
    for (NSInteger i = 0 ; i < randomDataArrM.count; i++) {
        DataModel * model = [self creatModel:randomDataArrM[i]];
        [_dataArrM addObject:model];
    }
    for (NSString *key in randomSelectArrM) {
        DataModel * model = _dataArrM[key.integerValue];
        model.choose = YES;
    }
    NSLog(@"%@",_dataArrM);
    return [_dataArrM copy];
}
#pragma mark ------tools---------

- (NSMutableArray *)creatRandomCount:(NSInteger)count maxNum:(NSInteger)max {
    NSMutableArray *dataM = [[NSMutableArray alloc] init];
    while (dataM.count < count) {
        NSString * numS = [self creatNum:max];
        if ([self chickNumSame:numS allData:dataM]) {
            [dataM addObject:numS];
        }
    }
    return dataM;
}

- (NSString *)creatNum:(NSInteger)cunt {
//    srandom((unsigned)time(0));
//    int i = random()%(int)cunt;
    int i = arc4random()%(int)cunt;
    NSString * str = [NSString stringWithFormat:@"%d",i];
    NSLog(@"%@",str);
    return str;
}
- (DataModel *)creatModel:(NSString *)num {
    DataModel * model = [[DataModel alloc] init];
    model.title = num;
    model.fontSize = 20;
    model.choose = NO;
    return model;
}

- (BOOL)chickNumSame:(NSString *)numS allData:(NSMutableArray *)allData{
    for (NSString * strNum in allData) {
        if ([numS isEqualToString:strNum]) {
            return NO;
        }
    }
    return YES;
}

- (NSMutableArray *)selectArrM {
    if (_selectArrM == nil) {
        _selectArrM = [[NSMutableArray alloc] init];
    }
    return _selectArrM;
}

@end
