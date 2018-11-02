//
//  ViewController.m
//  E_Scheduling
//
//  Created by feiwei on 16/4/6.
//  Copyright © 2016年 feiwei. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    [self loadImageView];
}
- (void)loadImageView{
    NSArray *picArr = @[@"loading1",@"loading2",@"loading3"];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width*(int)picArr.count, self.view.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    for (int i=0; i<(int)picArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageView.image = [UIImage imageNamed:[picArr objectAtIndex:i]];
        [scrollView addSubview:imageView];
        if (i == (int)picArr.count-1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((self.view.frame.size.width-150)/2, self.view.frame.size.height-70, 150, 40);
            [button setTitle:@"开始体验" forState:UIControlStateNormal];
            button.layer.cornerRadius = 5;
            button.backgroundColor = [UIColor colorWithRed:90/255.0 green:192/255.0 blue:242/255.0 alpha:1];
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:button];
        }
    }
    
    //添加视图
    [self.view addSubview:scrollView];
}

- (void)btnClick:(UIButton *)button{
    if ([self.clickDelegate respondsToSelector:@selector(btnhaveClicked)]) {
        [self.clickDelegate btnhaveClicked];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
