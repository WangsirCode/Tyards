//
//  AboutViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/8.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutVIewModel.h"
#import "MDABizManager.h"
#import "StateVC.h"
#import "ServiceVC.h"
@interface AboutViewController ()<UITextViewDelegate>
//@property (strong,nonatomic)AboutVIewModel* viewModel;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (nonatomic,strong)UIBarButtonItem* backItem;
//@property (nonatomic,strong)UILabel* titleLabel;
//@property (nonatomic,strong)UIImageView* imageView;
//@property (nonatomic,strong)UILabel* firstPa;
//@property (nonatomic,strong)UILabel* secPa;
//@property (nonatomic,strong)UILabel* sevieceLabel;
//@property (nonatomic,strong)UILabel* mianzeLable;
//@property (nonatomic,strong)UILabel* infoLabel;
@end
@implementation AboutViewController
#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setUpView];
//    [self bindModel];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.title=@"关于";
    self.img.layer.cornerRadius =10;
    self.img.layer.masksToBounds=YES;
}

-(UIBarButtonItem *)backItem
{
    if (!_backItem) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"返回icon"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 25, 20);
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
    return _backItem;
}

- (IBAction)bottomOneAction:(id)sender {
    StateVC *vc =[[StateVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)bottomTwoAction:(id)sender {
    ServiceVC *vc= [[ServiceVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}





























//#pragma mark- setupView
//
//- (void)setUpView
//{
//    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
//    [self addSubViews];
//    [self makeConstraits];
//}
//- (void)addSubViews
//{
//    self.navigationItem.leftBarButtonItem = self.backItem;
//    [self.view sd_addSubviews:@[self.imageView,self.firstPa,self.titleLabel,self.sevieceLabel,self.mianzeLable,self.infoLabel]];
//}
//- (void)makeConstraits
//{
//    CGFloat scale = self.view.scale;
////    self.imageView.sd_layout
////    .centerXEqualToView(self.view)
////    .topSpaceToView(self.view,24*scale)
////    .heightIs(82*scale)
////    .widthEqualToHeight();
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.top.equalTo(self.view.mas_top).offset(24*scale);
//        make.height.equalTo(@(82*scale));
//        make.width.equalTo(@(82*scale));
//    }];
////    self.titleLabel.sd_layout
////    .rightEqualToView(self.view)
////    .leftEqualToView(self.view)
////    .topSpaceToView(self.imageView,14*scale)
////    .heightIs(30*scale);
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.and.left.equalTo(self.view);
//        make.top.equalTo(self.imageView.mas_bottom).offset(14*scale);
//    }];
////    self.firstPa.sd_layout
////    .topSpaceToView(self.titleLabel,28*scale)
////    .leftSpaceToView(self.view,12*scale)
////    .rightSpaceToView(self.view,12*scale)
////    .autoHeightRatio(0);
//    [self.view updateLayout];
//    self.infoLabel.sd_layout
//    .rightEqualToView(self.view)
//    .leftEqualToView(self.view)
//    .bottomSpaceToView(self.view,10)
//    .autoHeightRatio(0);
//    
//    self.mianzeLable.sd_layout
//    .rightEqualToView(self.view)
//    .leftEqualToView(self.view)
//    .bottomSpaceToView(self.infoLabel,15*scale)
//    .autoHeightRatio(0);
//    
//    self.sevieceLabel.sd_layout
//    .rightEqualToView(self.view)
//    .leftEqualToView(self.view)
//    .bottomSpaceToView(self.mianzeLable,12*scale)
//    .autoHeightRatio(0);
//    [self.firstPa mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(28*scale);
//        make.left.equalTo(self.view).offset(12*scale);
//        make.right.equalTo(self.view).offset(-12*scale);
//    }];
//}
//
//- (void)bindModel
//{
//    self.navigationItem.title = @"关于";
//}
//
//#pragma mark -viewModelSet
//
//- (void)setRouterParameters:(NSDictionary *)routerParameters
//{
//    self.viewModel = [[AboutVIewModel alloc] initWithDictionary: routerParameters];
//}
//#pragma mark- getter
//- (UIImageView *)imageView
//{
//    if(!_imageView)
//    {
//        _imageView = [[UIImageView alloc] init];
//        _imageView.image = [UIImage imageNamed:@"logo"];
//    }
//    return _imageView;
//}
//- (UILabel *)titleLabel
//{
//    if (!_titleLabel) {
//        _titleLabel = [UILabel new];
//        _titleLabel.text = @"十二码";
//        _titleLabel.font = [UIFont systemFontOfSize:28];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _titleLabel;
//}
//
//- (UILabel *)firstPa
//{
//    if (!_firstPa) {
//        _firstPa = [UILabel new];
//        NSString* fisrt = @"十二码致力于成为最好的高校校园足球宣传与服务平台，以专注、创新的态度来为校园里热爱足球运动的小伙伴服务。十二码的使命：更好的校园足球，更好的绿茵青春";
//        NSString* sec = @"APP特色：";
//        NSString* third = @"足球帮，致力于提供最专业的足球资讯、直播、社交、数据平台；随时随地了解国内外足球资讯，第一手掌握赛事赛程，了解开赛时间      ";
//        NSMutableString* text = [NSMutableString stringWithString:fisrt];
//        [text appendString:sec];
//        [text appendString:third];
//        NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:fisrt];
//        NSMutableParagraphStyle * paragraph1 = [[NSMutableParagraphStyle alloc]init];
//        [paragraph1 setLineSpacing:6];//设置行间距
//        [paragraph1 setAlignment:NSTextAlignmentLeft];
//        [str addAttribute:NSParagraphStyleAttributeName value:paragraph1 range:NSMakeRange(0, fisrt.length)];
//        [str replaceCharactersInRange:NSMakeRange(fisrt.length, 0) withString:@"\n"];
//        
//        NSMutableAttributedString * str2 = [[NSMutableAttributedString alloc]initWithString:sec];
//        NSMutableParagraphStyle * paragraph2 = [[NSMutableParagraphStyle alloc]init];
//        [paragraph2 setLineSpacing:6];//设置行间距
//        [paragraph2 setAlignment:NSTextAlignmentLeft];
//        [paragraph2 setParagraphSpacingBefore:20];
//        [str2 replaceCharactersInRange:NSMakeRange(sec.length, 0) withString:@"\n"];
//        [str2 addAttribute:NSParagraphStyleAttributeName value:paragraph2 range:NSMakeRange(0, sec.length)];
//        
//        NSMutableAttributedString * str3 = [[NSMutableAttributedString alloc]initWithString:third];
//        NSMutableParagraphStyle * paragraph3 = [[NSMutableParagraphStyle alloc]init];
//        [paragraph3 setLineSpacing:6];//设置行间距
//        [paragraph3 setAlignment:NSTextAlignmentLeft];
//        [str3 replaceCharactersInRange:NSMakeRange(third.length, 0) withString:@"\n"];
//        [str3 addAttribute:NSParagraphStyleAttributeName value:paragraph3 range:NSMakeRange(0, third.length)];
//        
//        
//        [str appendAttributedString:str2];
//        [str appendAttributedString:str3];
//
//        _firstPa.attributedText = str;
//        _firstPa.font = [UIFont systemFontOfSize:18];
//        _firstPa.numberOfLines = 0;
//        _firstPa.textColor = [UIColor colorWithHexString:@"#999999"];
//    }
//    return _firstPa;
//}
//
//-(UILabel *)sevieceLabel
//{
//    if (!_sevieceLabel) {
//        _sevieceLabel = [UILabel new];
//        _sevieceLabel.text = @"《服务条款》";
//        _sevieceLabel.textColor = [UIColor MyColor];
//        _sevieceLabel.font = [UIFont systemFontOfSize:13];
//        _sevieceLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _sevieceLabel;
//}
//-(UILabel *)mianzeLable
//{
//    if (!_mianzeLable) {
//        _mianzeLable = [UILabel new];
//        _mianzeLable.text = @"《免责声明》";
//        _mianzeLable.textColor = [UIColor MyColor];
//        _mianzeLable.font = [UIFont systemFontOfSize:13];
//        _mianzeLable.textAlignment = NSTextAlignmentCenter;
//    }
//    return _mianzeLable;
//}
//-(UILabel *)infoLabel
//{
//    if (!_infoLabel) {
//        _infoLabel = [UILabel new];
//        _infoLabel.text = @"当前版本:V1.0 更新时间:2016.9.1";
//        _infoLabel.textColor = [UIColor colorWithHexString:@"#999999"];
//        _infoLabel.font = [UIFont systemFontOfSize:13];
//        _infoLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _infoLabel;
//}
@end
