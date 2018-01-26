//
//  RandomData.h
//  TESTImage
//
//  Created by shenzhenshihua on 2018/1/26.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DataModel;
typedef void(^ResultBlock) (BOOL ispass);
@interface RandomData : NSObject
@property(nonatomic,copy)ResultBlock resultBlock;
+ (id)shareRandomData;

- (NSArray *)randomWithDiff:(NSInteger)diff;

- (void)selectModel:(DataModel *)model resblock:(ResultBlock)block;

@end
