//
//  CollectionCell.h
//  TESTImage
//
//  Created by shenzhenshihua on 2018/1/26.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataModel;
@interface CollectionCell : UICollectionViewCell
@property(nonatomic,strong)DataModel *model;
- (void)turnOver;
- (void)resetAngle;
@end
