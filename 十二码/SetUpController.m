//
//  SetUpController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/8.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SetUpController.h"
#import "MDABizManager.h"
#import "SetUpViewModel.h"
#import "FeedBackController.h"
#import "ShareView.h"
#import "SEMLoginViewController.h"
#import "AboutViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"

@interface SetUpController ()<UITableViewDelegate,UITableViewDataSource,ShareViewDelegate>
@property (strong,nonatomic)SetUpViewModel* viewModel;
@property (nonatomic,strong)UITableView* tableView;
@property (nonatomic,strong)UIBarButtonItem* backItem;
@property (nonatomic,strong)ShareView* shareView;
@property (nonatomic,strong)UIView* maskView;
@end

@implementation SetUpController
#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    [self bindModel];
    // Do any additional setup after loading the view.
}
#pragma mark- setupView

- (void)setUpView
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    [self addSubViews];
    [self makeConstraits];
}
- (void)addSubViews
{
    self.navigationItem.leftBarButtonItem = self.backItem;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.shareView];
}
- (void)makeConstraits
{
    CGFloat height;
    height = self.view.scale * 48 * 3 + 24;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.equalTo(@(height));
    }];
}

- (void)bindModel
{
    self.navigationItem.title = @"设置";
}
#pragma mark-ShareViewDelegate
- (void)didSelectedShareView:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    switch (index) {
        case 0:
        {
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:@"www.baidu.com"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"十二码" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }

            break;
        case 1:
        {
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:@"www.baidu.com"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"十二码" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
        case 2:
        {
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:@"www.baidu.com"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"十二码" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
        case 3:
        {
            [UMSocialData defaultData].extConfig.wechatSessionData.url = @"www.baidu.com";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:@"www.baidu.com"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"十二码" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
        case 4:
            [self hideMaskView];
            break;
        default:
            break;
    }
}

#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SetUpViewModel alloc] initWithDictionary: routerParameters];
}
#pragma mark- tableviewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* text;
    NSString* detailText;
    text = self.viewModel.itemName[indexPath.section][indexPath.row];
    if (indexPath.section == 2) {
        if (!self.viewModel.isLogined) {
            text = @"登录";
        }
    }
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"setcell"];
    if ([text isEqualToString:@"切换账号"]) {
        [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell.contentView);
        }];
    }
    if ([text isEqualToString:@"登录"]) {
        [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell.contentView);
        }];
    }
//    if ([text isEqualToString:@"检查更新"]) {
//        detailText = self.viewModel.version;
//        cell.detailTextLabel.text = detailText;
//        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#CACACA"];
//    }
    if ([text isEqualToString:@"意见反馈"]) {
        detailText = @"尽情来吐槽吧";
        cell.detailTextLabel.text = detailText;
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#CACACA"];
    }
    if ([text isEqualToString:@"清除缓存"]) {
        detailText = self.viewModel.fileSize;
        cell.detailTextLabel.text = detailText;
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#CACACA"];
    }

    cell.textLabel.text = text;
    cell.textLabel.font = [UIFont systemFontOfSize:16*self.view.scale];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14*self.view.scale];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    if([text isEqualToString:@"推荐好友"])
//    {
//        UIImageView* image = [[UIImageView alloc] init];
//        image.image = [UIImage imageNamed:@"upload_L"];
//        [cell.contentView addSubview:image];
//        [image mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(cell.contentView.mas_centerY);
//            make.right.equalTo(cell.contentView.mas_right).offset(10);
//        }];
//    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48 * self.view.scale;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString* text = cell.textLabel.text;
    if ([text isEqualToString:@"清除缓存"]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:@"确定要清除缓存吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction* done = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.viewModel clearCache];
            [self.tableView reloadData];
        }];
        [alert addAction:cancel];
        [alert addAction:done];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([text isEqualToString:@"意见反馈"])
    {
        FeedBackController* controller = [HRTRouter objectForURL:@"feedBack" withUserInfo:@{}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([text isEqualToString:@"推荐好友"])
    {
        CALayer* imageLayer = self.shareView.layer;
        self.maskView.hidden = NO;
        CGPoint fromPoint = imageLayer.position;
        CGPoint toPoint = CGPointMake(0, self.view.height - 200*self.view.scale);
        // 创建不断改变CALayer的position属性的属性动画
        CABasicAnimation* anim = [CABasicAnimation
                                  animationWithKeyPath:@"position"];
        // 设置动画开始的属性值
        anim.fromValue = [NSValue valueWithCGPoint:fromPoint];
        // 设置动画结束的属性值
        anim.toValue = [NSValue valueWithCGPoint:toPoint];
        anim.duration = 0.3;
        imageLayer.position = toPoint;
        anim.removedOnCompletion = YES;
        // 为imageLayer添加动画
        [imageLayer addAnimation:anim forKey:nil];
    }
    if ([text isEqualToString:@"切换账号"]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"切换账号之前需要退出当前登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction* done = [UIAlertAction actionWithTitle:@"确认退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [DataArchive removeUserFile:@"token"];
            [DataArchive removeUserFile:@"userinfo"];
            [DataArchive removeUserFile:@"headimage"];
            [DataArchive removeUserFile:@"UserInfo"];
            SEMLoginViewController* login = [HRTRouter objectForURL:@"login" withUserInfo:@{}];
            [self presentViewController:login animated:YES completion:nil];
        }];
        [alert addAction:cancel];
        [alert addAction:done];
        [self presentViewController:alert animated:YES completion:nil];
    }
    if ([text isEqualToString:@"关于"]) {
        AboutViewController* controller = [HRTRouter objectForURL:@"about" withUserInfo:@{}];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    if ([text isEqualToString:@"登录"]) {
        SEMLoginViewController* login = [HRTRouter objectForURL:@"login" withUserInfo:@{}];
        [self presentViewController:login animated:YES completion:nil];
    }
//    if ([text isEqualToString:@"检查更新"]) {
//        [XHToast showCenterWithText:@"已是最新版本"];
//    }
}
- (void)hideMaskView
{
    _maskView.hidden = YES;
    CALayer* imageLayer = self.shareView.layer;
    CGPoint fromPoint = imageLayer.position;
    CGPoint toPoint = CGPointMake(0, self.view.height);
    // 创建不断改变CALayer的position属性的属性动画
    CABasicAnimation* anim = [CABasicAnimation
                              animationWithKeyPath:@"position"];
    // 设置动画开始的属性值
    anim.fromValue = [NSValue valueWithCGPoint:fromPoint];
    // 设置动画结束的属性值
    anim.toValue = [NSValue valueWithCGPoint:toPoint];
    anim.duration = 0.3;
    imageLayer.position = toPoint;
    anim.removedOnCompletion = YES;
    // 为imageLayer添加动画
    [imageLayer addAnimation:anim forKey:nil];
}
#pragma  mark -Getter
-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 20, 15);
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
            [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:NO completion:^(BOOL finished) {
                
            }];
        }];
        
    }
    return _backItem;
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc ] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (ShareView *)shareView
{
    if (!_shareView) {
        _shareView = [[ShareView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width, 200*self.view.scale)];
        _shareView.layer.anchorPoint = CGPointMake(0, 0);
        _shareView.frame = CGRectMake(0, self.view.height, self.view.width, 200*self.view.scale);
        _shareView.delegate = self;
        _shareView.layer.anchorPoint = CGPointMake(0, 0);
        NSLog(@"%@",_shareView.description);
    }
    return _shareView;
}
- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0.5;
        _maskView.hidden = YES;
        
        //添加点击之后的手势
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMaskView)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}
@end
