//
//  CommentCell.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/1.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "CommentCell.h"
#import "MDABizManager.h"
@implementation CommentCell
{
    UIImageView *_view0;
    UILabel *_view1;
    UILabel *_view2;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    UIImageView *view0 = [UIImageView new];
    _view0 = view0;
    
    UILabel *view1 = [UILabel new];
    view1.textColor = [UIColor blackColor];
    view1.font = [UIFont systemFontOfSize:16*self.scale];
    _view1 = view1;
    
    UILabel *view2 = [UILabel new];
    view2.textColor = [UIColor grayColor];
    view2.font = [UIFont systemFontOfSize:16*self.scale];
    view2.numberOfLines = 0;
    _view2 = view2;
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = [UIColor colorWithHexString:@"#C8C8C8"];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView sd_addSubviews:@[view0, view1, view2,_timeLabel]];
    
    _view0.sd_layout
    .widthIs(40)
    .heightIs(40)
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10);
    
    _view1.sd_layout
    .topSpaceToView(self.contentView,20)
    .leftSpaceToView(_view0, 10)
    .heightRatioToView(_view0, 0.4);
    
    _view2.sd_layout
    .topSpaceToView(_view1, 10)
    .rightSpaceToView(self.contentView, 10)
    .leftEqualToView(_view1)
    .autoHeightRatio(0);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_view1,13)
    .topSpaceToView(self.contentView,20)
    .rightEqualToView(self.contentView)
    .autoHeightRatio(0);
    
    UIImageView* commentImageView = [UIImageView new];
    commentImageView.image = [UIImage imageNamed:@"icon_msg"];
    [self.contentView addSubview:commentImageView];
    commentImageView.sd_layout
    .topSpaceToView(self.contentView,20*self.scale)
    .heightIs(15*self.scale)
    .rightEqualToView(_view2)
    .widthIs(20*self.scale);
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self doComment];
    }];
    [commentImageView addGestureRecognizer:tap];
    commentImageView.userInteractionEnabled = YES;
    _view0.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    [_view1 setSingleLineAutoResizeWithMaxWidth:200];
    self.contentView.clipsToBounds = YES;
}
- (void)setModel:(Comments*)model
{
    _model = model;

    if (self.model.comment.creator.avatar) {
        NSURL* url = [[NSURL alloc] initWithString:self.model.comment.creator.avatar];
        [_view0 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"] options:SDWebImageRefreshCached];
    }
    else
    {
        _view0.image = [UIImage imageNamed:@"zhanwei.jpg"];
    }
    _view1.text = self.model.comment.creator.nickname;
    _view2.text = self.model.comment.content;
    _timeLabel.text = [self.model getDate];
    if (self.model.comment.replies.count > 0) {
        _commentView = [[CommentView alloc] initWithReplies:self.model.comment.replies];
        [self.contentView addSubview:self.commentView];
        self.commentView.delegate = self;
        _commentView.sd_layout
        .topSpaceToView(_view2,10)
        .leftEqualToView(_view2)
        .rightEqualToView(_view2);
        [self setupAutoHeightWithBottomView:_commentView bottomMargin:10];
    }
    else
    {
        [self setupAutoHeightWithBottomView:_view2 bottomMargin:10];
    }
}
- (void)didClickButton:(NSInteger)commentId remindId:(NSInteger)remindId name:(NSString *)name
{
    [self.delegate didReplyComment:self.model.comment.id targetId:commentId remindId:remindId name:name];
}
- (void)doComment
{
    [self.delegate didClickComment:self.model.comment.id targetName:self.model.comment.creator.nickname];
}
@end
