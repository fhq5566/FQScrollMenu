# FQScrollMenu
    * 头部支持可滚动和不可滚动，支持平分和按钮大小宽度  
    * 内容支持可滚动和不可滚动  
    * 父`FQMenuButton`支持继承，提供了两个子类(`FQTitleButton`，`FQBtmLineButton`)
    * FQMenuButton支持有图标，支持自定义操作。   
` 下划线效果图：`                                    `文字和图标效果图：`
<br>
 ![image](https://github.com/fhq5566/FQIMG/blob/master/FQScrollMenu/FQScrollMenuGif1.gif)
 ![image](https://github.com/fhq5566/FQIMG/blob/master/FQScrollMenu/FQScrollMenuGif2.gif)
<br><br> 
`示例代码：`
```Objective-C
 - (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray<FQMenuButton *> *buttons = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        YQViewController *vc1 = [[YQViewController alloc] init];
        NSInteger index = (i + 1);
        vc1.content = [NSString stringWithFormat:@"我是VC %ld" , index];
        
        NSString *buttonText = [NSString stringWithFormat:@"操作%ld", index];
        FQBtmLineButton *titleButton1 = [[FQBtmLineButton alloc] initWithTitle:buttonText icon:@"order_arrow2_btn" showVC:vc1];
        //正常颜色和选中颜色
        [titleButton1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleButton1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        //如果需要更改高度和颜色，
        titleButton1.lineH = 2;
        titleButton1.lineBackgroundColor = [UIColor redColor];
        titleButton1.titleLabel.font = [UIFont systemFontOfSize:14];
        [buttons addObject:titleButton1];
    }
    //还有数组修改方法哦- (void)setupLineH:(CGFloat)lineH lineBackgroundColor:(UIColor *)lineBackgroundColor;
//    [buttons setupLineH:2 lineBackgroundColor:[UIColor redColor]];
    
    FQScrollMenu *scrollMenu = [[FQScrollMenu alloc] initWithStyle:FQScrollMenuHeaderStyleScroll selectedIndex:3 bottomHeight:0 superVC:self];
    scrollMenu.delegate = self;
    [self.view addSubview:scrollMenu];
    scrollMenu.menuButtons = buttons;
    scrollMenu.contentScrollView.scrollEnabled = YES;  //内容是否可滚动
//    scrollMenu.selectedIndex = 5;  //选中下标
    
    [scrollMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
}
