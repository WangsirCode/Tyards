//
//  PolicyShowController.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/19.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "PolicyShowController.h"
#import "MDABizManager.h"
@interface PolicyShowController ()
@property (nonatomic,strong) NSString* text;
@property (nonatomic,strong) UIWebView* webView;
@property (nonatomic,strong) UIBarButtonItem    * backItem;
@end

@implementation PolicyShowController

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.text = dictionary[@"text"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.backItem;
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:self.text baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    return _webView;
}
-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 20, 15);
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
    return _backItem;
}
@end
