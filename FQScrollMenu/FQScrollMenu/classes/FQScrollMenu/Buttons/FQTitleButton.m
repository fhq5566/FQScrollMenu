//
//  FQTitleButton.m
//  FQScrollMenu
//
//  Created by lx on 17/2/8.
//  Copyright © 2017年 honhot. All rights reserved.
//  标题+图片的按钮

#import "FQTitleButton.h"
#import "UIView+FQExtension.h"

@implementation FQTitleButton

#pragma mark - 系统回调
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置UI
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    //设置UI
    [self setupUI];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.titleLabel.text && self.titleLabel.text.length != 0) {
        self.titleLabel.x = (self.width - self.titleLabel.width - self.imageView.width) * 0.5;
        self.imageView.x = self.titleLabel.width + self.titleLabel.x + 3;
        if (self.isAdjLayout) {
            //设置内容自动适应
            [self sizeToFit];
        }
    }
}

//self.imageView.x = self.titleLabel.width + 5;
- (void)setFrame:(CGRect)frame
{
    if (self.titleLabel.text && self.titleLabel.text.length != 0) {
        frame.size.width += 15;
        frame.size.height += 5;
    }
    [super setFrame:frame];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    //设置内容自动适应
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    //设置内容自动适应
    [self sizeToFit];
}

#pragma mark - 设置UI
- (void)setupUI
{
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self sizeToFit];
}

@end
