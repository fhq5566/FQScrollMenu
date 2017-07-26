//
//  FQBtmLineButton.h
//  FQScrollMenu
//
//  Created by 冯华强 on 17/7/24.
//  Copyright © 2017年 hq. All rights reserved.
//  下划线Button

#import "FQTitleButton.h"

@interface NSArray<FQBtmLineButton> (FQBtmLineButtonExtension)
//给数组设置高度和颜色
- (void)setupLineH:(CGFloat)lineH lineBackgroundColor:(UIColor *)lineBackgroundColor;
@end

@interface FQBtmLineButton : FQTitleButton

//分割线的高度
@property (nonatomic, assign) CGFloat lineH;
//分割线的颜色
@property (nonatomic, strong) UIColor *lineBackgroundColor;

@end
