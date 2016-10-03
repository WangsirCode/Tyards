//
//  NoticeGameviewCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "NoticeGameviewCell.h"

@implementation NoticeGameviewCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.view];
        self.contentView.backgroundColor = [UIColor BackGroundColor];
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left).offset(10*self.view.scale);
            make.right.equalTo(self.contentView.mas_right).offset(-10*self.view.scale);
            make.height.equalTo(@(156*self.scale));
        }];
        [RACObserve(self, model) subscribeNext:^(id x) {
            if (self.model) {
                self.view.titleLabel.text = self.model.tournament.name;
                NSMutableString* info = [NSMutableString new];
                if (self.model.group.name) {
                    [info appendString:self.model.group.name];
                    [info appendString:@"  "];
                }
                if (self.model.round.name) {
                    [info appendString:self.model.round.name];
                }
                self.view.status = [self.model getStatus1];
                if (self.view.status == 2) {
                    self.view.homeScoreLabel.text = @"-";
                    self.view.awaySocreLabel.text = @"-";
                }
                else
                {
                    self.view.homeScoreLabel.text = [NSString stringWithFormat: @"%ld", (long)self.model.homeScore];
                    self.view.awaySocreLabel.text = [NSString stringWithFormat: @"%ld", (long)self.model.awayScore];
                }
                self.view.homeTitleLabel.text = self.model.home.name;
                self.view.awayTitleLabel.text = self.model.away.name;
                self.view.homeLabel.text = self.model.stadium.name;
                self.view.timeLabel.text = [self.model getDate];
                UIImage *image = [UIImage imageNamed:@"zhanwei.jpg"];
                NSURL *homeurl;
                if (self.model.home.logo.url) {
                    homeurl = [[NSURL alloc] initWithString:self.model.home.logo.url];
                    [self.view.homeImageview sd_setImageWithURL:homeurl placeholderImage:image options:SDWebImageRefreshCached];
                }
                else
                {
                    self.view.homeImageview.image = image;
                }
                NSURL *awayurl;
                if (self.model.away.logo.url) {
                    awayurl = [[NSURL alloc] initWithString:self.model.away.logo.url];
                    [self.view.awayImgaeview sd_setImageWithURL:awayurl placeholderImage:image options:SDWebImageRefreshCached];
                }
                else
                {
                    self.view.awayImgaeview.image = image;
                }
                self.view.location = 1;
                self.selectionStyle = UITableViewCellSelectionStyleNone;
                if (self.model.latestNews.detail) {
                    UIView* view = [UIView new];
                    view.backgroundColor = [UIColor whiteColor];
                    view.layer.borderColor = [UIColor BackGroundColor].CGColor;
                    view.layer.borderWidth = 0.8;
                    [self.contentView addSubview:view];
                    view.sd_layout
                    .topSpaceToView(self.view,0)
                    .leftSpaceToView(self.contentView,10*self.scale)
                    .rightSpaceToView(self.contentView,10*self.scale)
                    .heightIs(40*self.scale);
                    UIImageView* imageview = [UIImageView new];
                    imageview.image = [UIImage imageNamed:@"volume"];
                    [view addSubview:imageview];
                    imageview.sd_layout
                    .leftSpaceToView(view,16*self.scale)
                    .centerYEqualToView(view)
                    .heightIs(13*self.scale)
                    .widthEqualToHeight();
                    UILabel* label = [UILabel new];
                    label.text = self.model.latestNews.detail;
                    label.font = [UIFont systemFontOfSize:13*self.scale];
                    [view addSubview:label];
                    label.sd_layout
                    .centerYEqualToView(view)
                    .leftSpaceToView(imageview,8*self.scale)
                    .widthIs(300)
                    .heightIs(30*self.scale);
                    
                }
            }
        }];
    }
    
    return self;
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.view];
        self.contentView.backgroundColor = [UIColor BackGroundColor];
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left).offset(10*self.view.scale);
            make.right.equalTo(self.contentView.mas_right).offset(-10*self.view.scale);
            make.height.equalTo(@(156*self.scale));
        }];
        [RACObserve(self, model) subscribeNext:^(id x) {
            if (self.model) {
                self.view.titleLabel.text = self.model.tournament.name;
                NSMutableString* info = [NSMutableString new];
                if (self.model.group.name) {
                    [info appendString:self.model.group.name];
                    [info appendString:@"  "];
                }
                if (self.model.round.name) {
                    [info appendString:self.model.round.name];
                }
                self.view.roundLabel.text = info;
                self.view.status = [self.model getStatus1];
                if (self.view.status == 2) {
                    self.view.homeScoreLabel.text = @"-";
                    self.view.awaySocreLabel.text = @"-";
                }
                else
                {
                    self.view.homeScoreLabel.text = [NSString stringWithFormat: @"%ld", (long)self.model.homeScore];
                    self.view.awaySocreLabel.text = [NSString stringWithFormat: @"%ld", (long)self.model.awayScore];
                }
                self.view.homeTitleLabel.text = self.model.home.name;
                self.view.awayTitleLabel.text = self.model.away.name;
                self.view.homeLabel.text = self.model.stadium.name;
                self.view.timeLabel.text = [self.model getDate];
                UIImage *image = [UIImage imageNamed:@"zhanwei.jpg"];
                NSURL *homeurl;
                if (self.model.home.logo.url) {
                    homeurl = [[NSURL alloc] initWithString:self.model.home.logo.url];
                    [self.view.homeImageview sd_setImageWithURL:homeurl placeholderImage:image options:SDWebImageRefreshCached];
                }
                else
                {
                    self.view.homeImageview.image = image;
                }
                NSURL *awayurl;
                if (self.model.away.logo.url) {
                    awayurl = [[NSURL alloc] initWithString:self.model.away.logo.url];
                    [self.view.awayImgaeview sd_setImageWithURL:awayurl placeholderImage:image options:SDWebImageRefreshCached];
                }
                else
                {
                    self.view.awayImgaeview.image = image;
                }
                self.view.location = 1;
                self.selectionStyle = UITableViewCellSelectionStyleNone;
                if (self.model.latestNews.detail) {
                    UIView* view = [UIView new];
                    view.backgroundColor = [UIColor whiteColor];
                    view.layer.borderColor = [UIColor BackGroundColor].CGColor;
                    view.layer.borderWidth = 0.8;
                    [self.contentView addSubview:view];
                    view.sd_layout
                    .topSpaceToView(self.view,0)
                    .leftSpaceToView(self.contentView,10*self.scale)
                    .rightSpaceToView(self.contentView,10*self.scale)
                    .heightIs(40*self.scale);
                    UIImageView* imageview = [UIImageView new];
                    imageview.image = [UIImage imageNamed:@"volume"];
                    [view addSubview:imageview];
                    imageview.sd_layout
                    .leftSpaceToView(view,16*self.scale)
                    .centerYEqualToView(view)
                    .heightIs(13*self.scale)
                    .widthEqualToHeight();
                    UILabel* label = [UILabel new];
                    label.text = self.model.latestNews.detail;
                    label.font = [UIFont systemFontOfSize:13*self.scale];
                    [view addSubview:label];
                    label.sd_layout
                    .centerYEqualToView(view)
                    .leftSpaceToView(imageview,8*self.scale)
                    .widthIs(300)
                    .heightIs(30*self.scale);

                }
            }
        }];
    }
    
    return self;
}

-(NoticeCellView *)view
{
    if (!_view) {
        _view = [[NoticeCellView alloc] initWithFrame:self.contentView.frame];
    }
    return _view;
}
@end
