//
//  DataModel.m
//  TESTImage
//
//  Created by shenzhenshihua on 2018/1/26.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

- (NSString *)description {
    return [NSString stringWithFormat:@"%@--%d--%ld",_title,_choose,(long)_fontSize];
}

@end
