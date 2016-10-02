//
//  SEMTabViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMTabViewController.h"
#import "HRTRouter.h"
#import "SEMHomeVIewController.h"
#import "SEMTeamViewController.h"

@implementation SEMTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = [NSArray arrayWithObjects:[HRTRouter objectForURL: @"Home?navigation=navigation"],[HRTRouter objectForURL: @"News?navigation=navigation"],[HRTRouter objectForURL: @"Team?navigation=navigation"],[HRTRouter objectForURL: @"Game?navigation=navigation"], nil];
}
@end
