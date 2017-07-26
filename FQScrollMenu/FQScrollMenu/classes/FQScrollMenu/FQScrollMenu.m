//
//  FQScrollMenu.m
//  FQScrollMenu
//
//  Created by lx on 17/7/21.
//  Copyright © 2017年 honhot. All rights reserved.
//  菜单的View

#import "FQScrollMenu.h"
#import "UIView+AutoLayout.h"

@interface FQButtonColorState : NSObject
@property(nonatomic, strong) UIColor *color;
@property(nonatomic, assign) UIControlState state;
@end
@implementation FQButtonColorState
+ (instancetype)buttonColorStateWithColor:(UIColor *)color state:(UIControlState)state
{
    FQButtonColorState *buttonColorState = [[FQButtonColorState alloc] init];
    buttonColorState.color = color;
    buttonColorState.state = state;
    return buttonColorState;
}
@end

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface FQScrollMenu ()<UIScrollViewDelegate>
//滚动视图头部
@property(nonatomic, weak) UIScrollView *headScrollView;
//菜单视图的父类
@property (nonatomic, weak, readwrite) UIViewController *superViewController;
//滚动试图的宽度
@property (nonatomic, assign) NSInteger scrollViewContentSizeW;
//头部样式
@property(nonatomic, assign) FQScrollMenuHeaderStyle headerStyle;
//上一次滚动到的Item
@property (nonatomic, weak) FQMenuButton *lastItem;
//上一次滚动到的视图
@property (nonatomic, weak) UIView *lastView;
//底部高度，没有：传递0  有：传递要减去的值
@property (nonatomic, assign) CGFloat bottomHeight;
//初始化选中的菜单的下标
@property (nonatomic, assign) NSInteger defaultSelectedIndex;
//每个按钮的宽度
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *itemDict;
//按钮累积的宽度1,1+2,1+2+3....
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *totalDict;
//上分割线
@property(nonatomic, weak) UIView *topLineView;
//下分割线
@property(nonatomic, weak) UIView *bottomLineView;
//设置按钮字体的大小
@property(nonatomic, strong) UIFont *titlLabelFont;
//按钮状态颜色对象
@property(nonatomic, strong) NSMutableArray<FQButtonColorState *> *buttonColorStateList;
@end

@implementation FQScrollMenu

#pragma mark - 懒加载
- (UIScrollView *)headScrollView
{
    if (_headScrollView == nil) {
        [self setupLineView];
        
        UIScrollView *headScrollView = [[UIScrollView alloc] init];
        headScrollView.showsHorizontalScrollIndicator = NO;
        headScrollView.showsVerticalScrollIndicator = NO;
        headScrollView.bounces = NO;
        [self addSubview:headScrollView];
        _headScrollView = headScrollView;
        
        //添加约束
        [headScrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.topLineView];
        [headScrollView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bottomLineView];
        [headScrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [headScrollView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    }
    return _headScrollView;
}

- (UIScrollView *)contentScrollView
{
    if (_contentScrollView == nil) {
        UIView *superView = self.superViewController.view;
        UIScrollView *contentScrollView = [[UIScrollView alloc] init];
        contentScrollView.delegate = self;
        contentScrollView.bounces = NO;
        //开启分页拖动
        contentScrollView.pagingEnabled = YES;
        contentScrollView.showsHorizontalScrollIndicator = NO;
        CGRect frame = contentScrollView.frame;
        frame.size = superView.frame.size;
        contentScrollView.frame = frame;
        contentScrollView.contentSize = CGSizeMake(self.scrollViewContentSizeW * contentScrollView.bounds.size.width, contentScrollView.bounds.size.height);
        [superView addSubview:contentScrollView];
        _contentScrollView = contentScrollView;
        
        //添加约束
        [_contentScrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.scrollHeader ? superView : self.headScrollView];
        [_contentScrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [_contentScrollView autoSetDimensionsToSize:CGSizeMake(superView.frame.size.width,superView.frame.size.height)];
    }
    return _contentScrollView;
}

- (NSMutableDictionary<NSNumber *, NSNumber *> *)itemDict
{
    if (_itemDict == nil) {
        _itemDict = [NSMutableDictionary<NSNumber *, NSNumber *> dictionary];
    }
    return _itemDict;
}

- (NSMutableDictionary<NSNumber *, NSNumber *> *)totalDict
{
    if (_totalDict == nil) {
        _totalDict = [NSMutableDictionary<NSNumber *, NSNumber *> dictionary];
    }
    return _totalDict;
}

- (UIView *)topLineView
{
    if (_topLineView == nil) {
        self.topLineView = [self addLineView];
    }
    return _topLineView;
}

- (UIView *)bottomLineView
{
    if (_bottomLineView == nil) {
        self.bottomLineView = [self addLineView];
    }
    return _bottomLineView;
}

- (NSMutableArray<FQButtonColorState *> *)buttonColorStateList
{
    if (_buttonColorStateList == nil) {
        _buttonColorStateList = [NSMutableArray<FQButtonColorState *> array];
    }
    return _buttonColorStateList;
}

#pragma mark - 创建YQFilterView
- (instancetype)initWithStyle:(FQScrollMenuHeaderStyle)style selectedIndex:(NSInteger)selectedIndex bottomHeight:(CGFloat)bottomHeight superVC:(UIViewController *)superVC
{
    if (self = [super init]) {
        self.headerStyle = style;
        self.bottomHeight = bottomHeight;
        self.superViewController = superVC;
        self.defaultSelectedIndex = selectedIndex;
    }
    return self;
}

#pragma mark - 设置UI
- (void)setupLineView
{
    //添加分割线约束
    [self.topLineView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.topLineView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.topLineView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.topLineView autoSetDimension:ALDimensionHeight toSize:0.5];
    
    [self.bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.bottomLineView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.bottomLineView autoSetDimension:ALDimensionHeight toSize:0.5];
}

- (__kindof UIView *)addLineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:(224 / 255.0f) green:(224 / 255.0f) blue:(224 / 255.0f) alpha:1.0];
    [self addSubview:lineView];
    return lineView;
}

- (void)setupTpLViewWithHidden:(BOOL)tpHidden btLView:(BOOL)btHidden
{
    self.topLineView.hidden = tpHidden;
    self.bottomLineView.hidden = btHidden;
}

- (void)setTitleLabelFont:(UIFont *)font
{
    self.titlLabelFont = font;
}

- (void)setTitleColor:(UIColor *)titleColor forState:(UIControlState)state
{
    FQButtonColorState *buttonColorState = [FQButtonColorState buttonColorStateWithColor:titleColor state:state];
    [self.buttonColorStateList addObject:buttonColorState];;
}

- (void)setMenuButtons:(NSArray<FQMenuButton *> *)menuButtons
{
    _menuButtons = menuButtons;
    
    if (!menuButtons || menuButtons.count == 0) return;
    
    CGFloat width = SCREEN_WIDTH / menuButtons.count;
    
    FQMenuButton *lastButton = nil;
    CGFloat totalWidth = 0;
    for (NSInteger i = 0; i < menuButtons.count; i++) {
        FQMenuButton *button = menuButtons[i];
        if (self.titlLabelFont) {
            button.titleLabel.font = self.titlLabelFont;
        }
        if (self.buttonColorStateList.count != 0) {
            
            for (FQButtonColorState *buttonColorState in self.buttonColorStateList) {
                [button setTitleColor:buttonColorState.color forState:buttonColorState.state];
            }
        }
        [self.headScrollView addSubview:button];
        
        CGFloat buttonW = self.headerStyle == FQScrollMenuHeaderStyleSplitEqually ? width : button.frame.size.width;
        totalWidth += buttonW;
        
        self.itemDict[@(i+1)] = @(buttonW);
        self.totalDict[@(i+1)] = @(totalWidth);
        
        //添加分割线约束
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:button.superview];
        [button autoSetDimension:ALDimensionWidth toSize:buttonW];
        if (lastButton) {
            [button autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:lastButton];
        }else{
            [button autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:button.superview];
        }
        [button autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:button.superview];
        if (i == menuButtons.count - 1) {
            [button autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:button.superview];
        }
        lastButton = button;
    }
    self.headScrollView.contentSize = CGSizeMake(totalWidth, self.headScrollView.frame.size.height);
    [self setOptionMenus];
}

- (void)setOptionMenus
{
    //设置默认的切换方法和滚动视图的切换方法
    for (int i = 0; i < self.menuButtons.count; i++) {
        
        FQMenuButton *item = self.menuButtons[i];
        item.tag = i + 1;
        item.handlerBlock = ^(FQMenuButton *menuButton){
            [self performSelector:@selector(showScrollViewControllerWithItem:) withObject:menuButton afterDelay:0];
            if ([self.delegate respondsToSelector:@selector(scrollMenu:buttonHandler:)]) {
                [self.delegate scrollMenu:self buttonHandler:menuButton];
            }
        };
    }
    //设置选中的位置
    self.selectedIndex = self.defaultSelectedIndex;
    FQMenuButton *item = self.menuButtons[self.selectedIndex];
    self.lastView = item.showVC.view;
    self.lastItem = item;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    if (selectedIndex < 0 || selectedIndex >= self.menuButtons.count) {
        _selectedIndex = 0;
    }
    FQMenuButton *item = self.menuButtons[_selectedIndex];
    [self showScrollViewControllerWithItem:item];
}

#pragma mark - 内部方法
- (NSInteger)scrollViewContentSizeW
{
    if (_scrollViewContentSizeW == 0) {
        NSInteger scrollViewContentSizeW = 0;
        for (NSInteger i = 0; i < self.menuButtons.count; i++) {
            FQMenuButton *item = self.menuButtons[i];
            if (item.showVC) scrollViewContentSizeW++;
        }
        _scrollViewContentSizeW = scrollViewContentSizeW;
    }
    return _scrollViewContentSizeW;
}

/**
 *  切换item,并更换线条的位置
 *  @param item 当前点击的item
 */
- (void)changeItem:(FQMenuButton *)item
{
    self.lastItem.selected = NO;
    item.selected = YES;
    NSInteger index = (item.tag - 1);
    CGFloat currentW = [self.totalDict[@(index)] floatValue];
    CGFloat x = currentW - SCREEN_WIDTH * 0.5 + item.frame.size.width * 0.5;
    if (x < 0) x = 0;
    if ([self.totalDict[@(self.menuButtons.count)] floatValue] - SCREEN_WIDTH <= x) {
        x = [self.totalDict[@(self.menuButtons.count)] floatValue] - SCREEN_WIDTH;
    }
    [self.headScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
    self.lastItem = item;
}

/**
 *  移动ScrollView
 *  @param item 当前点击的Item
 */
- (void)showScrollViewControllerWithItem:(FQMenuButton *)item
{
    if (self.lastItem == item) return; //同一个Item，则不做处理
    
    [self setupChildViewControllerWithItem:item];
    
    UIViewController *showViewController = item.showVC;
    NSInteger index = (item.tag - 1);
    //取消隐藏
    showViewController.view.hidden = NO;
    
    CGFloat x = SCREEN_WIDTH * index;
    //改变下划线位置
    [self changeItem:item];
    if (!showViewController) return;
    [self.contentScrollView setContentOffset:CGPointMake(x, 0) animated:NO];
}

/**
 *  添加要显示的视图
 */
- (void)setupChildViewControllerWithItem:(FQMenuButton *)item
{
    UIViewController *viewController = item.showVC;
    if (viewController == nil) return;
    
    if([self.superViewController.childViewControllers containsObject:viewController])return;
    
    //添加到子控制器中
    //    viewController.view.backgroundColor = item.backgroundColor;
    [self.superViewController addChildViewController:viewController];
    
    CGFloat left = (item.tag - 1) * SCREEN_WIDTH;
    [self contentScrollView];
    [self.contentScrollView addSubview:viewController.view];
    
    //添加约束
    if (self.isScrollHeader) {
        [viewController.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.superViewController.view];
    }else{
        [viewController.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self];

    }
    [viewController.view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:left];
    [viewController.view autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.superViewController.view];
    
    [viewController.view autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.superViewController.view withOffset:-self.bottomHeight];
}

#pragma mark - <UIScrollViewDelegate>
/** 滚动视图停下 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPage = self.contentScrollView.bounds.origin.x / self.contentScrollView.bounds.size.width;
    FQMenuButton *item = [self viewWithTag:currentPage + 1];
    [self showScrollViewControllerWithItem:item];
}

@end
