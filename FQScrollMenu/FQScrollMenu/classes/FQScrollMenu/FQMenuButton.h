//
//  FQMenuButton.h
//  FQScrollMenu
//
//  Created by lx on 17/7/21.
//  Copyright © 2017年 hq. All rights reserved.
//  1.菜单的按钮，可继承
//  2.获取是否已选中请用button的selected

#import <UIKit/UIKit.h>

@class FQMenuButton;
typedef void (^HandlerBlock)(FQMenuButton *menuButton);
@interface FQMenuButton : UIButton

/**
 * 创建FQScrollMenu
 * @param title 标题
 * @param icon  图标
 * @param showVC 该item切换的控制器
 */
- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon showVC:(UIViewController *)showVC;

//是否调整布局
@property(nonatomic, assign, getter=isAdjLayout) BOOL adjLayout;

//实现该block后，点击事件会传递
@property(nonatomic, copy) HandlerBlock handlerBlock;

//显示的VC
@property(nonatomic, strong, readonly) UIViewController *showVC;

//提供给需要标识的枚举等其它操作的下标,tag已经使用，如果需要请使用这个或者自定义集成该FQMenuButton
@property(nonatomic, assign) NSInteger index;

@end
