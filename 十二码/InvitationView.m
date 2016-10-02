//
//  InvitationView.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/29.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "InvitationView.h"

@implementation InvitationView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeConstraits];
        [self bindModel];
    }
    return self;
}
- (void)makeConstraits
{
    [self sd_addSubviews:@[self.leftImageView,self.titleLable,self.nameLabel,self.placeLabel,self.dateLabel,self.messageLabel,self.typeLabel,self.breakLine,self.contactBotton]];
    self.leftImageView.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self);
    
    self.titleLable.sd_layout
    .topSpaceToView(self,16*self.scale)
    .leftSpaceToView(self,25*self.scale)
    .widthIs(200*self.scale)
    .autoHeightRatio(0);
    
    self.typeLabel.sd_layout
    .topSpaceToView(self,8)
    .rightSpaceToView(self,8)
    .heightIs(16*self.scale)
    .widthIs(70*self.scale);
    
    NSArray* array = @[@"icon_C",@"icon_location",@"icon_clock",@"icon_msg"];
    self.messageLabel.numberOfLines = 2;
    NSArray<UILabel*>* labels = @[self.nameLabel,self.placeLabel,self.dateLabel,self.messageLabel];
    for (int i = 0; i< 4; i++) {
        UIImageView* view = [UIImageView new];
        view.image = [UIImage imageNamed:array[i]];
        [self addSubview:view];
        view.sd_layout
        .topSpaceToView(self.titleLable,(16+i*24)*self.scale)
        .leftSpaceToView(self,24*self.scale)
        .heightIs(14*self.scale)
        .widthIs(10*self.scale);
        labels[i].sd_layout
        .topSpaceToView(self.titleLable,(16+i*24)*self.scale)
        .leftSpaceToView(view,10)
        .rightSpaceToView(self,10)
        .autoHeightRatio(0)
        .maxHeightIs(35*self.scale);
    }
    self.breakLine.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self.contactBotton,0)
    .heightIs(2);
    self.contactBotton.sd_layout
    .bottomEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(49*self.scale);
    UIImageView* imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"icon_phone"];
    [self addSubview:imageView];
    imageView.sd_layout
    .topSpaceToView(self.breakLine,15*self.scale)
    .heightIs(20*self.scale)
    .widthIs(20*self.scale)
    .leftSpaceToView(self,110*self.scale);
}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        if (self.model) {
            self.titleLable.text = self.model.title;
            self.nameLabel.text = [NSString stringWithFormat:@"%@       %@",self.model.linkman,self.model.contact];
            self.placeLabel.text = self.model.stadium.name;
            self.dateLabel.text = [self.model getDate];
            self.messageLabel.text = self.model.desc;
            if ([self.model.type isEqualToString:@"FIVE"]) {
                self.typeLabel.text = @"5人场";
                self.typeLabel.backgroundColor = [UIColor colorWithHexString:@"#7ED97C"];
            }
            else if([self.model.type isEqualToString:@"SIX"])
            {
                self.typeLabel.text = @"6人场";
                self.typeLabel.backgroundColor = [UIColor colorWithHexString:@"#FFC057"];
            }
            else if([self.model.type isEqualToString:@"SEVEN"])
            {
                self.typeLabel.text = @"7人场";
                self.typeLabel.backgroundColor = [UIColor colorWithHexString:@"#89DAC7"];
            }
            else if([self.model.type isEqualToString:@"EIGHT"])
            {
                self.typeLabel.text = @"8人场";
                self.typeLabel.backgroundColor = [UIColor colorWithHexString:@"#8CB8EF"];
            }
            else if([self.model.type isEqualToString:@"NINE"])
            {
                self.typeLabel.text = @"9人场";
                self.typeLabel.backgroundColor = [UIColor colorWithHexString:@"#AEAEF5"];
            }
            else if([self.model.type isEqualToString:@"ELEVEN"])
            {
                self.typeLabel.text = @"11人场";
                self.typeLabel.backgroundColor = [UIColor colorWithHexString:@"#40BC57"];
            }
        }
    }];
}
- (UIImageView*)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
        _leftImageView.image = [UIImage imageNamed:@"bg_combined_shape"];
    }
    return _leftImageView;
}
- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [UILabel new];
    }
    return _titleLable;
}
- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.textColor = [UIColor whiteColor];
    }
    return _typeLabel;
}
- (UIButton *)contactBotton
{
    if (!_contactBotton) {
        _contactBotton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contactBotton setTitle:@"联系队长" forState:UIControlStateNormal];
        [_contactBotton setTitleColor:[UIColor MyColor] forState:UIControlStateNormal];
        [[_contactBotton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",self.model.contact]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
        }];
    }
    return _contactBotton;
}
- (UIView *)breakLine
{
    if (!_breakLine) {
        _breakLine = [UIView new];
        _breakLine.backgroundColor = [UIColor colorWithHexString:@"#D8E9F0"];
    }
    return _breakLine;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#555555"];
    }
    return _nameLabel;
}

-(UILabel *)placeLabel
{
    if (!_placeLabel) {
        _placeLabel = [UILabel new];
        _placeLabel.textColor = [UIColor colorWithHexString:@"#CACACA"];
        _placeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _placeLabel;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textColor = [UIColor colorWithHexString:@"CACACA"];
        _dateLabel.font = [UIFont systemFontOfSize:13];
    }
    return _dateLabel;
}
-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.textColor = [UIColor colorWithHexString:@"#CACACA"];
        _messageLabel.font = [UIFont systemFontOfSize:13];
        [[UITextView  appearance] setTintColor:[UIColor MyColor]];
    }
    return _messageLabel;
}

@end
