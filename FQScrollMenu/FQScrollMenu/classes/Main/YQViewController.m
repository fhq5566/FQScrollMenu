//
//  YQViewController.m
//  FQScrollMenu
//
//  Created by lx on 17/7/21.
//  Copyright © 2017年 hq. All rights reserved.
//

#import "YQViewController.h"
#import "Masonry.h"

@interface YQViewController ()

@end

@implementation YQViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    NSLog(@"%@", @"已加载...........");
}

- (void)setupUI
{
    UILabel *label = [[UILabel alloc] init];
    label.text = self.content;
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.and.bottom.mas_equalTo(0);
    }];
}


@end
