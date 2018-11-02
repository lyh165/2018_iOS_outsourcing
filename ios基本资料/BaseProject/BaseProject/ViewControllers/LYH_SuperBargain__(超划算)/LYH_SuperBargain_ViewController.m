//
//  LYH_SuperBargain_ViewController.m
//  BaseProject
//
//  Created by lee on 2018/11/2.
//  Copyright © 2018年 feiwei. All rights reserved.
//

#import "LYH_SuperBargain_ViewController.h"

@interface LYH_SuperBargain_ViewController ()

@end

@implementation LYH_SuperBargain_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTitle:@"超划算"
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
