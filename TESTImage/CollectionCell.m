//
//  CollectionCell.m
//  TESTImage
//
//  Created by shenzhenshihua on 2018/1/26.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "CollectionCell.h"
#import "DataModel.h"
@interface CollectionCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property(nonatomic,assign)NSInteger times;
@end
@implementation CollectionCell

- (void)setModel:(DataModel *)model {
    _model = model;
    _title.text = model.title;
    _title.font = [UIFont boldSystemFontOfSize:model.fontSize];
    _times = 0;
    if (model.choose) {
        _title.textColor = [UIColor greenColor];
    } else {
        _title.textColor = [UIColor blackColor];
    }
//    _backView.layer.transform = CATransform3DIdentity;
}
- (void)turnOver {
//    [[RandomData shareRandomData] selectModel:_model];
//    if (!self.model.choose) {
//        _title.textColor = [UIColor redColor];
//    }
    _times++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _iconImage.hidden = !_iconImage.hidden;
        _title.hidden = !_title.hidden;

    });
    
    [UIView animateWithDuration:0.5 animations:^{
        _backView.layer.transform = CATransform3DMakeRotation(M_PI*_times, 0, 1, 0);
    } completion:^(BOOL finished) {
        if (_times==2) {
            _backView.layer.transform = CATransform3DIdentity;
            _times = 0;
        }
    }];
    
}
- (void)resetAngle {
    if (_times==1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _iconImage.hidden = !_iconImage.hidden;
            _title.hidden = !_title.hidden;
            
        });
        [UIView animateWithDuration:0.5 animations:^{
            _backView.layer.transform = CATransform3DIdentity;
        }];
        _times = 0;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _title.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    
    // Initialization code
}

@end
