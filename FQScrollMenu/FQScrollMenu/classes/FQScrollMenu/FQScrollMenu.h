//
//  FQScrollMenu.h
//  FQScrollMenu
//
//  Created by lx on 17/7/21.
//  Copyright © 2017年 honhot. All rights reserved.
//  菜单的View

#import "FQMenuButton.h"

typedef enum{
    FQScrollMenuHeaderStyleSplitEqually,  //平分
    FQScrollMenuHeaderStyleScroll         //按钮大小可滚动
}FQScrollMenuHeaderStyle;  //头部样式

@class FQScrollMenu;
@protocol FQScrollMenuDelegate <NSObject>

//filterButton点击事件，需要跟进事件去处理事情的实现该代理
- (void)scrollMenu:(FQScrollMenu *)scrollMenu buttonHandler:(FQMenuButton *)handler;
@end

@interface FQScrollMenu : UIView

/**
 * 创建YQFilterView
 * @param style  头部样式
 * @param selectedIndex  选中button的下标
 * @param bottomHeight 底部高度，没有：传递0  有：传递要减去的值
 * @param superVC 当前控制器
 */
- (instancetype)initWithStyle:(FQScrollMenuHeaderStyle)style selectedIndex:(NSInteger)selectedIndex bottomHeight:(CGFloat)bottomHeight superVC:(UIViewController *)superVC;

//滚动后，时候隐藏头部，默认是否
@property (nonatomic, assign, getter=isScrollHeader) BOOL scrollHeader;
//代理
@property (nonatomic, weak) id<FQScrollMenuDelegate> delegate;
//控制上下分割线的显示和隐藏
- (void)setupTpLViewWithHidden:(BOOL)tpHidden btLView:(BOOL)btHidden;
//统一设置所有按钮的字体大小
- (void)setTitleLabelFont:(UIFont *)font;
//统一设置所有按钮状态下的颜色
- (void)setTitleColor:(UIColor *)titleColor forState:(UIControlState)state;


//以下属性请再[self.view addSubView:FQScrollMenu]后添加====================
//1添加buttons
@property (nonatomic, strong) NSArray<FQMenuButton *> *menuButtons;
//2滚动视图内容(添加buttons后可以设置内容视图是否可以滚动)
@property(nonatomic, weak) UIScrollView *contentScrollView;
//3设置选中的菜单的下标
@property (nonatomic, assign) NSInteger selectedIndex;

@end
