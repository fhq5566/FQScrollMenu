//
//  YQViewController.m
//  FQScrollMenu
//
//  Created by lx on 17/7/21.
//  Copyright © 2017年 hq. All rights reserved.
//

#import "YQViewController.h"

@interface YQViewController ()

@end
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation YQViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    NSLog(@"%@", @"已加载...........");
}

- (void)setupUI
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    label.text = self.content;
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];

    //FQScrollMenu不想依赖Masonry，所以没有加入，使用Masonry可以使用以下代码
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.right.and.bottom.mas_equalTo(0);
//    }];
}


@end
