//
//  SEMInitialViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMInitialViewController.h"
#import "HRTRouter.h"
@interface SEMInitialViewController ()

@end

@implementation SEMInitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = self.view.frame.size.width;
    
    [self setMaximumRightDrawerWidth:width - 80.0];
    [self setMaximumLeftDrawerWidth:width - 80.0];
    self.showsShadow = NO;
    
    self.leftDrawerViewController = [HRTRouter objectForURL: @"Me"];
    self.centerViewController = [HRTRouter objectForURL: @"tab"];
}

- (void)loadView
{
    [super loadView];
    
    [self setStatusBarViewBackgroundColor:[UIColor clearColor]];
    [self setOpenDrawerGestureModeMask: MMOpenDrawerGestureModeAll];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
