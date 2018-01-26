//
//  ViewController.m
//  TESTImage
//
//  Created by shenzhenshihua on 2018/1/26.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "ViewController.h"
#import "RandomData.h"
#import "MainCollection.h"

#define Screen_Frame     [[UIScreen mainScreen] bounds]
#define Screen_Width     [[UIScreen mainScreen] bounds].size.width
#define Screen_Height    [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()
@property(nonatomic,strong)MainCollection *mainCollection;
@property(nonatomic,assign)NSInteger currntDif;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCollection];
    
    [self initResult];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)initCollection {
    _currntDif=2;
    NSArray *arr = [[RandomData shareRandomData] randomWithDiff:2];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (Screen_Width-20)/2;
    layout.itemSize = CGSizeMake(width, width);
    CGFloat minWidth = 2;
    layout.minimumLineSpacing = minWidth;
    layout.minimumInteritemSpacing = minWidth;
    MainCollection * collection = [[MainCollection alloc] initWithFrame:CGRectMake(0, 40, Screen_Width, Screen_Width) collectionViewLayout:layout];
    [collection initCollcetion:arr];
    _mainCollection = collection;
    [self.view addSubview:collection];
}

- (void)initResult {
    __weak typeof (self) ws = self;
    [[RandomData shareRandomData] setResultBlock:^(BOOL ispass) {
        if (ispass) {
            if (_currntDif == 10) {
                [ws alertView:@"警告" des:@"大神请收下我的膝盖!"];
            } else {
                [ws nextDif];
            }
        } else {
            //失败
            [ws alertView:@"警告" des:@"GameOver!"];
        }
    }];
}
- (void)alertView:(NSString *)title des:(NSString *)desp {
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:title message:desp preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _currntDif = 1;
        [self nextDif];
    }];
    
    [alertCon addAction:alertAction];
    [self presentViewController:alertCon animated:YES completion:nil];
}

- (void)nextDif {
    [_mainCollection resetAngle];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _currntDif++;
        NSArray *arr = [[RandomData shareRandomData] randomWithDiff:_currntDif];
        [_mainCollection difficulty:_currntDif dataSource:arr];
    });

}



- (IBAction)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            {
                
            }
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
