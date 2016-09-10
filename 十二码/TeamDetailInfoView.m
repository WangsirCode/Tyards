//
//  TeamDetailInfoView.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TeamDetailInfoView.h"
#import "MDABizManager.h"
@implementation TeamDetailInfoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeConstrait];
        [self bindModel];
    }
    return self;
}
- (void)makeConstrait
{
    CGFloat scale = self.scale;
    [self sd_addSubviews:@[self.infoLabel,self.logoImageView,self.playerLabel,self.nameLabel,self.detailLabel,self.recordLabel,self.allButton,self.ovalView,self.winlabel,self.dragLabel,self.loseLabel,self.honorLabel]];
    [self.ovalView addSubview:self.recordImageView];
    self.infoLabel.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .rightEqualToView(self)
    .heightIs(44*self.scale);
    
    self.logoImageView.sd_layout
    .leftSpaceToView(self,12*scale)
    .topSpaceToView(self.infoLabel,12)
    .widthIs(50*scale)
    .heightIs(50*scale);
    self.logoImageView.sd_cornerRadiusFromHeightRatio = @(0.5);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.infoLabel,16*scale)
    .leftSpaceToView(self.logoImageView,14*scale)
    .rightEqualToView(self)
    .autoHeightRatio(0);
    
    self.playerLabel.sd_layout
    .leftSpaceToView(self.logoImageView,14*scale)
    .topSpaceToView(self.nameLabel,8*scale)
    .rightEqualToView(self)
    .autoHeightRatio(0);
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).offset(16*scale);
        make.left.equalTo(self.mas_left).offset(10*scale);
        make.right.equalTo(self.mas_right).offset(-10*scale);
    }];
    
    self.recordLabel.sd_layout
    .topSpaceToView(self.detailLabel,0)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(44*scale);
    
    self.allButton.sd_layout
    .topSpaceToView(self.recordLabel,0)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(44*scale);
    
    self.allButton.imageView.sd_layout
    .rightSpaceToView(self.allButton,12*scale)
    .centerYEqualToView(self.allButton)
    .heightIs(17.3*scale)
    .widthIs(19.4*scale);

    [self.allButton.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.allButton);
        make.height.equalTo(@(44*scale));
    }];
    self.ovalView.sd_layout
    .topSpaceToView(self.allButton,32*scale)
    .leftSpaceToView(self,10)
    .heightIs(160*self.scale)
    .widthEqualToHeight();
    
    self.recordImageView.sd_layout
    .centerXEqualToView(self.ovalView)
    .centerYEqualToView(self.ovalView)
    .widthIs(95*self.scale)
    .heightEqualToWidth();
    
    self.recordImageView.sd_cornerRadiusFromWidthRatio = @0.5;
    
    self.winlabel.sd_layout
    .topSpaceToView(self.allButton,20*scale)
    .widthIs(100*scale)
    .heightIs(55*scale)
    .leftSpaceToView(self.ovalView,48*scale);
    
    self.dragLabel.sd_layout
    .topSpaceToView(self.winlabel,8*scale)
    .widthIs(100*scale)
    .heightIs(55*scale)
    .leftSpaceToView(self.ovalView,48*scale);
    
    self.loseLabel.sd_layout
    .topSpaceToView(self.dragLabel,8*scale)
    .widthIs(100*scale)
    .heightIs(55*scale)
    .leftSpaceToView(self.ovalView,48*scale);
    
    self.honorLabel.sd_layout
    .topSpaceToView(self.loseLabel,5)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(44*scale);
    
    [self setupAutoHeightWithBottomView:self.honorLabel bottomMargin:10];

    
}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        if (self.model) {
            if (self.model.info.logo.url) {
                [self.logoImageView sd_setImageWithURL:[[NSURL alloc] initWithString:self.model.info.logo.url] placeholderImage:[UIImage placeholderImage]];
            }
            else
            {
                self.logoImageView.image = [UIImage placeholderImage];
            }
            if (self.model.info.name) {
                self.nameLabel.text = self.model.info.name;
            }
            else
            {
                self.nameLabel.text = @"";
            }
            
            //设置教练和队长信息
            NSMutableString* player = [NSMutableString stringWithString:@"主教练:"];
            if (self.model.info.coach.name) {
                [player appendString:self.model.info.coach.name];
            }
            [player appendString:@"    队长:"];
            if (self.model.info.captain) {
                [player appendString:self.model.info.captain];
            }
            self.playerLabel.text = player;
            
            if (self.model.info.desc) {
                NSString * htmlString = self.model.info.desc;
                NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:NSMakeRange(0, attrStr.length)];
                [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, attrStr.length)];
                NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
                [style setLineSpacing:7*self.scale];
                [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attrStr.length)];
                self.detailLabel.attributedText = attrStr;
            }
            self.ovalView.model = self.model.data;
            self.winlabel.model = self.model.data;
            self.dragLabel.model = self.model.data;
            self.loseLabel.model = self.model.data;
            if (self.model.data.honours) {
                for (int i = 0; i < self.model.data.honours.count; i++) {
                    Honours* model = self.model.data.honours[i];
                    UIView* view = [[UIView alloc] init];
                    view.layer.borderWidth = 0.5;
                    view.layer.borderColor = [UIColor BackGroundColor].CGColor;
                    [self addSubview:view];
                    view.sd_layout
                    .topSpaceToView(self.honorLabel,60*i*self.scale)
                    .leftEqualToView(self)
                    .rightEqualToView(self)
                    .heightIs(60*self.scale);
                    UIImageView* iamgeView = [UIImageView new];
                    if (model.logo.url) {
                        [iamgeView sd_setImageWithURL:[[NSURL alloc] initWithString:model.logo.url ] placeholderImage:[UIImage placeholderImage]];
                        
                    }
                    else
                    {
                        iamgeView.image = [UIImage placeholderImage];
                    }
                    iamgeView.sd_cornerRadiusFromWidthRatio = @0.5;
                    [view addSubview:iamgeView];
                    iamgeView.sd_layout
                    .centerYEqualToView(view)
                    .heightIs(40*self.scale)
                    .leftSpaceToView(view,10*self.scale)
                     .widthEqualToHeight();
                    UILabel* label = [UILabel new];
                    label.text = model.name;
                    [view addSubview:label];
                    label.sd_layout
                    .topSpaceToView(view,8*self.scale)
                    .leftSpaceToView(iamgeView,20*self.scale)
                    .heightIs(25*self.scale)
                    .widthIs(300);
                    label.font = [UIFont systemFontOfSize:18*self.scale];
                    UIImageView* plateImage = [UIImageView new];
                    plateImage.image = [UIImage imageNamed:@"赛事icon=灰"];
                    [view addSubview:plateImage];
                    plateImage.sd_layout
                    .topSpaceToView(label,10*self.scale)
                    .leftEqualToView(label)
                    .heightIs(15*self.scale)
                    .widthIs(10*self.scale);
                    UIImageView* timeImage = [UIImageView new];
                    timeImage.image = [UIImage imageNamed:@"约战-时间"];
                    [view addSubview:timeImage];
                    timeImage.sd_layout
                    .topSpaceToView(label,10*self.scale)
                    .leftSpaceToView(plateImage,20*self.scale)
                    .heightIs(15*self.scale)
                    .widthIs(15*self.scale);
                    UILabel* yearLabel = [UILabel new];
                    yearLabel.text = [@(model.year) stringValue];
                    [view addSubview:yearLabel];
                    yearLabel.sd_layout
                    .topEqualToView(plateImage)
                    .bottomEqualToView(plateImage)
                    .leftSpaceToView(timeImage,8*self.scale)
                    .widthIs(100);
                    yearLabel.font = [UIFont systemFontOfSize:14*self.scale];
                    yearLabel.textColor = [UIColor colorWithHexString:@"#CACACA"];
                    if (i == self.model.data.honours.count - 1) {
                        [self setupAutoHeightWithBottomView:view bottomMargin:10];
                    }
                }
            }
            else
            {
                [self setupAutoHeightWithBottomView:self.honorLabel bottomMargin:20];
            }
        }
    }];
}
- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [UILabel new];
        _infoLabel.text = @"   基本资料";
        _infoLabel.font = [UIFont systemFontOfSize:16];
        _infoLabel.textColor = [UIColor MyColor];
        _infoLabel.layer.borderColor = [UIColor BackGroundColor].CGColor;
        _infoLabel.layer.borderWidth = 1;
    }
    return _infoLabel;
}
- (UILabel *)recordLabel
{
    if (!_recordLabel) {
        _recordLabel = [UILabel new];
        _recordLabel.text = @"   球队战绩";
        _recordLabel.font = [UIFont systemFontOfSize:16];
        _recordLabel.textColor = [UIColor MyColor];
    }
    return _recordLabel;
}
- (UILabel *)honorLabel
{
    if (!_honorLabel) {
        _honorLabel = [UILabel new];
        _honorLabel.text = @"   球队荣誉";
        _honorLabel.font = [UIFont systemFontOfSize:16];
        _honorLabel.textColor = [UIColor MyColor];
        _honorLabel.layer.borderColor = [UIColor BackGroundColor].CGColor;
        _honorLabel.layer.borderWidth = 1;
    }
    return _honorLabel;
}
- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
//        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _logoImageView.clipsToBounds = YES;
    }
    return _logoImageView;
}
-(UILabel *)playerLabel
{
    if (!_playerLabel) {
        _playerLabel = [UILabel new];
        _playerLabel.font = [UIFont systemFontOfSize:12];
        _playerLabel.textColor = [UIColor colorWithHexString:@"#A1B2BA"];
    }
    return _playerLabel;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}
-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.textColor = [UIColor colorWithHexString:@"#111111"];
        _detailLabel.font = [UIFont systemFontOfSize:18];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}
- (UIButton *)allButton
{
    if (!_allButton) {
        _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _allButton.layer.borderWidth = 1;
        _allButton.layer.borderColor = [UIColor BackGroundColor].CGColor;
        [_allButton setImage:[UIImage imageNamed:@"calender_L"] forState:UIControlStateNormal];
        [_allButton setTitle:@"全部" forState:UIControlStateNormal];
        [_allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _allButton;
}
- (OvalView *)ovalView
{
    if (!_ovalView) {
        _ovalView = [[OvalView alloc] init];
        _ovalView.backgroundColor = [UIColor whiteColor];
    }
    return _ovalView;
}
- (UIImageView *)recordImageView
{
    if (!_recordImageView) {
        _recordImageView = [[UIImageView alloc] init];
        _recordImageView.image = [UIImage imageNamed:@"足球logo"];
    }
    return _recordImageView;
}
- (RecordLabel *)winlabel
{
    if (!_winlabel) {
        _winlabel = [[RecordLabel alloc] initWithMark:1];
    }
    return _winlabel;
}
- (RecordLabel *)loseLabel
{
    if (!_loseLabel) {
        _loseLabel = [[RecordLabel alloc] initWithMark:3];
    }
    return _loseLabel;
}
- (RecordLabel *)dragLabel
{
    if (!_dragLabel) {
        _dragLabel = [[RecordLabel alloc] initWithMark:2];
    }
    return _dragLabel;
}
@end
