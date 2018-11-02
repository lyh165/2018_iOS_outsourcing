//
//  LYH_MyViewController.m
//  BaseProject
//
//  Created by lee on 2018/11/2.
//  Copyright © 2018年 feiwei. All rights reserved.
//

#import "LYH_MyViewController.h"

@interface LYH_MyViewController ()

@end

@implementation LYH_MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"我的"
           titleColor:[UIColor whiteColor]
             NavColor:[UIColor redColor]
         fontWithName:@"Helvetica-Bold"
             fontSize:17];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
