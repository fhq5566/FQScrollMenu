//
//  ViewController.m
//  FQScrollMenu
//
//  Created by lx on 17/7/21.
//  Copyright © 2017年 hq. All rights reserved.
//

#import "ViewController.h"
#import "FQScrollMenu.h"
#import "FQTitleButton.h"
#import "FQBtmLineButton.h"
#import "Masonry.h"
#import "YQViewController.h"

@interface ViewController ()<FQScrollMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray<FQMenuButton *> *buttons = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        YQViewController *vc1 = [[YQViewController alloc] init];
        NSInteger index = (i + 1);
        vc1.content = [NSString stringWithFormat:@"我是VC %ld" , index];
        
        NSString *buttonText = @"";
        if (i == 2) {
            buttonText = [NSString stringWithFormat:@"操作操作%ld", index];
        }else if(i == 5){
            buttonText = [NSString stringWithFormat:@"操作作%ld", index];
        }else if(i == 8){
            buttonText = [NSString stringWithFormat:@"操作操作操作%ld", index];
        }else{
            buttonText = [NSString stringWithFormat:@"操作%ld", index];
        }
        //@"order_arrow2_btn"
        FQBtmLineButton *titleButton1 = [[FQBtmLineButton alloc] initWithTitle:buttonText icon:@"order_arrow2_btn" showVC:vc1];
        [titleButton1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleButton1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleButton1.lineH = 2;
        titleButton1.lineBackgroundColor = [UIColor redColor];
        titleButton1.titleLabel.font = [UIFont systemFontOfSize:14];
        [buttons addObject:titleButton1];
    }
    
    FQScrollMenu *scrollMenu = [[FQScrollMenu alloc] initWithStyle:FQScrollMenuHeaderStyleScroll selectedIndex:3 bottomHeight:0 superVC:self];
    scrollMenu.delegate = self;
    [self.view addSubview:scrollMenu];
    scrollMenu.menuButtons = buttons;
    scrollMenu.contentScrollView.scrollEnabled = YES;
    
//    scrollMenu.selectedIndex = 5;
    
    [scrollMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)scrollMenu:(FQScrollMenu *)scrollMenu buttonHandler:(FQMenuButton *)handler
{
    NSLog(@"当前视图%ld是否已加载%@", handler.tag, handler.showVC.isViewLoaded == YES ? @"是" : @"否");
}
@end
