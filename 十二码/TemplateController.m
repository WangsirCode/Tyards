//
//  TemplateController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/10.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TemplateController.h"
#import "AlbumDetailController.h"
#import "MDABizManager.h"
#import "AlbumDetailViewModel.h"
#import "PhotoDetailCell.h"
#import "PictureShowController.h"
@interface TemplateController ()
@property (nonatomic,strong) UIBarButtonItem      *backItem;
@property (nonatomic,strong) MBProgressHUD        *hud;
@property (nonatomic,strong) SEMViewModel* viewModel;
@end
@implementation TemplateController
- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.viewModel = [[AlbumDetailViewModel alloc] initWithDictionary:dictionary];
    }
    return self;
}
#pragma mark -lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    
    // Do any additional setup after loading the view.
}

#pragma viewsetup
- (void)setupView
{
    self.hud.labelText = @"加载中";
    self.view.backgroundColor = [UIColor BackGroundColor];
    [self addSubviews];
    [self makeConstraits];
    
}

- (void)addSubviews
{
    self.navigationItem.leftBarButtonItem = self.backItem;
}
- (void)makeConstraits
{

}
- (void)bindModel
{
    [RACObserve(self.viewModel, shouldReloadData) subscribeNext:^(id x) {
        if (self.viewModel.shouldReloadData == YES) {
            [self.hud hide:YES];
        }
    }];
}



#pragma mark- getter

-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame     = CGRectMake(0, 0, 20, 15);
        _backItem        = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
    return _backItem;
}
-(MBProgressHUD *)hud
{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _hud;
}
@end
