//
//  MainCollection.m
//  TESTImage
//
//  Created by shenzhenshihua on 2018/1/26.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "MainCollection.h"
#import "DataModel.h"
#import "CollectionCell.h"
#import "RandomData.h"

#define Screen_Frame     [[UIScreen mainScreen] bounds]
#define Screen_Width     [[UIScreen mainScreen] bounds].size.width
#define Screen_Height    [[UIScreen mainScreen] bounds].size.height

@interface MainCollection ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,copy)NSArray *dataSou;
@end
static NSString *const CollectionCellId = @"CollectionCell";
@implementation MainCollection
//- (id)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        NSArray *arr = [[RandomData randomData] randomWithDiff:2];
//        [self difficulty:2 dataSource:arr];
//    }
//    return self;
//}
- (void)initCollcetion:(NSArray *)dataSource {
    self.backgroundColor = [UIColor grayColor];
    self.dataSource = self;
    self.delegate = self;
    self.dataSou = dataSource;
    self.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
    UINib * nib = [UINib nibWithNibName:CollectionCellId bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:CollectionCellId];
//    [self reloadSections:[NSIndexSet indexSetWithIndex:0]];
    [self reloadData];
    
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self handleInit];
    });
}
- (void)difficulty:(NSInteger)diff dataSource:(NSArray *)dataSource {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (Screen_Width-20)/diff;
    layout.itemSize = CGSizeMake(width, width);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    CGFloat edge = (20 - (diff-1)*2)/2;
    self.contentInset = UIEdgeInsetsMake(edge, edge, edge, edge);

    self.dataSource = self;
    self.delegate = self;
    self.dataSou = dataSource;
    [self reloadData];

    self.collectionViewLayout = layout;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self handleInit];
    });

}
- (void)handleInit {
    [self turnOverAll];
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self resetAngle];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
        });
    });
}
- (void)resetAngle {
    NSArray * arrs = [self visibleCells];
    for (CollectionCell *cell in arrs) {
        [cell resetAngle];
    }
}
- (void)turnOverAll {
    NSArray * arrs = [self visibleCells];
    for (CollectionCell *cell in arrs) {
        [cell turnOver];
    }
}

#pragma mark ---UICollectionViewDataSource,UICollectionViewDelegate---
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSou.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellId forIndexPath:indexPath];
    cell.model = self.dataSou[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell * cell = (CollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell turnOver];
    
    [[RandomData shareRandomData] selectModel:self.dataSou[indexPath.item] resblock:^(BOOL ispass) {
        if (ispass) {
            self.userInteractionEnabled = NO;
        }
    }];

//    [collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
