//
//  FQBtmLineButton.m
//  FQScrollMenu
//
//  Created by 冯华强 on 17/7/24.
//  Copyright © 2017年 hq. All rights reserved.
//  下划线Button

#import "FQBtmLineButton.h"

@implementation NSArray (FQBtmLineButtonExtension)
- (void)setupLineH:(CGFloat)lineH lineBackgroundColor:(UIColor *)lineBackgroundColor
{
    for (FQBtmLineButton *btmLineButton in self) {
        btmLineButton.lineH = lineH;
        btmLineButton.lineBackgroundColor = lineBackgroundColor;
    }
}
@end

@interface FQBtmLineButton ()
//下划线View
@property (nonatomic, weak) UIView *lineView;
@end

@implementation FQBtmLineButton

#pragma mark - 系统回调
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置UI
        [self setupUI];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    //设置内容自动适应
    [self sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.titleLabel.font;
    CGSize maxSize = CGSizeMake(self.frame.size.width, MAXFLOAT);
    
    CGSize size = [self.currentTitle boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    CGFloat lineW = size.width + 15;
    CGFloat x = (self.frame.size.width - lineW) * 0.5;
    self.lineView.frame = CGRectMake(x, self.frame.size.height - self.lineH, lineW, self.lineH);
}

#pragma mark - 设置UI
- (__kindof UIView *)addLineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.hidden = YES;
    [self addSubview:lineView];
    return lineView;
}

- (void)setupUI
{
    self.lineView = [self addLineView];
}

- (void)setLineH:(CGFloat)lineH
{
    _lineH = lineH;
    
    //设置内容自动适应
    [self sizeToFit];
}

- (void)setLineBackgroundColor:(UIColor *)lineBackgroundColor
{
    _lineBackgroundColor = lineBackgroundColor;
    
    self.lineView.backgroundColor = lineBackgroundColor;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    self.lineView.hidden = !selected;
}

@end
