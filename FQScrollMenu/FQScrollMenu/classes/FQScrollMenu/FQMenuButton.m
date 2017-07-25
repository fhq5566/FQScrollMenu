//
//  FQMenuButton
//  FQScrollMenu
//
//  Created by lx on 17/7/21.
//  Copyright © 2017年 hq. All rights reserved.
//  菜单的按钮，可继承

#import "FQMenuButton.h"

@implementation FQMenuButton

#pragma mark - 创建按钮
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.adjLayout = YES;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon showVC:(UIViewController *)showVC
{
    if (self = [super init]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        self.adjLayout = NO;
        _showVC = showVC;
        [self addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - 设置事件
- (void)menuButtonClick:(FQMenuButton *)menuButton
{
    if (self.handlerBlock) {
        self.handlerBlock(menuButton);
    }
}

@end
