//
//  UIView+FQExtension.m
//  XCY
//
//  Created by XCY
//  Copyright (c) 2015年 HQ. All rights reserved.
//

#import "UIView+FQExtension.h"

@implementation UIView (FQExtension)

- (void)setX:(float)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (float)x
{
    return self.frame.origin.x;
}

- (void)setY:(float)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (float)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(float)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (float)centerX
{
    return self.center.x;
}

- (void)setCenterY:(float)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (float)centerY
{
    return self.center.y;
}

- (void)setWidth:(float)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (float)width
{
    return self.frame.size.width;
}

- (void)setHeight:(float)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (float)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}
@end
