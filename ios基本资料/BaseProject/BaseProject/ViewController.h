//
//  ViewController.h
//  E_Scheduling
//
//  Created by feiwei on 16/4/6.
//  Copyright © 2016年 feiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol btnClickDelegate <NSObject>

- (void)btnhaveClicked;

@end
@interface ViewController : UIViewController

@property (nonatomic,weak)id<btnClickDelegate> clickDelegate;
@end

