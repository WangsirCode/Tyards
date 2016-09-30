//
//  HomeCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/23.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "HomeCell.h"
#import "Masonry.h"
#import "MDABizManager.h"
@implementation HomeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
        [self makeConstraits];
        [self bindModel];
    }
    return self;
}


#pragma mark - viewsetup
- (void)addSubviews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.newsImage];
    [self.contentView addSubview:self.bottomview];
}

- (void)makeConstraits
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    [self.newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20*scale);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20*scale);
        make.left.equalTo(self.contentView.mas_left).offset(10*scale);
        make.width.equalTo(self.contentView.mas_width).dividedBy(3.7);
    }];
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView,20*self.scale)
    .leftSpaceToView(self.newsImage,10*self.scale)
    .rightSpaceToView(self.contentView,10*self.scale)
    .autoHeightRatio(0)
    .maxHeightIs(60*self.scale);
    [self.bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(120*self.scale);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.newsImage.mas_bottom);
        make.height.equalTo(@(20*self.scale));
    }];
    
}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        if (self.model) {
            NSMutableAttributedString* attr = [[NSMutableAttributedString alloc] initWithString:self.model.title];
            NSRange range = NSMakeRange(0, self.model.title.length);
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14*self.scale] range:range];
            NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];

            [attr addAttribute:NSParagraphStyleAttributeName value:style range:range];
            self.titleLabel.attributedText = attr;
            
            self.bottomview.commentLabel.text = [@(self.model.commentCount) stringValue];;
            self.bottomview.inifoLabel.text = [self.model getInfo];
            if (self.model.thumbnail.url)
            {
                NSURL* url = [[NSURL alloc] initWithString:self.model.thumbnail.url];
                [self.newsImage sd_setImageWithURL:url
                                  placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]
                                           options:SDWebImageRefreshCached];
            }
            else
            {
                self.newsImage.image = [UIImage imageNamed:@"zhanwei.jpg"];
            }
            self.bottomview.viewLabel.text = [@(self.model.viewed) stringValue];
            if ([self.model.type isEqualToString:@"TOPIC"]) {
                UILabel *label = [UILabel new];
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:9*self.scale];
                label.text = @"话题";
                label.backgroundColor = [UIColor orangeColor];
                [self.contentView addSubview:label];
                label.textAlignment = NSTextAlignmentCenter;
                label.sd_layout
                .rightEqualToView(self.titleLabel)
                .bottomEqualToView(self.titleLabel)
                .widthIs(26*self.scale)
                .heightIs(14*self.scale);
            }

        }
    }];
}
#pragma mark -getter
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.alpha = 0.87;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView* )newsImage
{
    if (!_newsImage){
        _newsImage = [[UIImageView alloc] init];
        _newsImage.contentMode = UIViewContentModeScaleAspectFill;
        _newsImage.clipsToBounds = YES;
    }
    return _newsImage;
}
- (BottomView*)bottomview
{
    if (!_bottomview) {
        _bottomview = [[BottomView alloc] init];
    }
    return _bottomview;
}
@end
