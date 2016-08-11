//
//  TeamInfoView.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/6.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TeamInfoView.h"
#import "MDABizManager.h"
@implementation TeamInfoView
{
    UIImageView *_view0;
    UILabel *_view1;
    UILabel *_view2;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    return self;
}
- (void)setup
{
    UIImageView *view0 = [UIImageView new];
    view0.backgroundColor = [UIColor redColor];
    _view0 = view0;
    
    UILabel *view1 = [UILabel new];
    view1.textColor = [UIColor blackColor];
    view1.font = [UIFont systemFontOfSize:16];
    _view1 = view1;
    
    UILabel *view2 = [UILabel new];
    view2.textColor = [UIColor grayColor];
    view2.font = [UIFont systemFontOfSize:16];
    view2.numberOfLines = 0;
    _view2 = view2;

    [self sd_addSubviews:@[view0, view1, view2]];
    
    _view0.sd_layout
    .widthIs(40)
    .heightIs(40)
    .topSpaceToView(self, 10)
    .leftSpaceToView(self, 10);
    
    _view1.sd_layout
    .topSpaceToView(self,20)
    .leftSpaceToView(_view0, 10)
    .heightRatioToView(_view0, 0.4);
    
    _view2.sd_layout
    .topSpaceToView(_view1, 10)
    .rightSpaceToView(self, 10)
    .leftEqualToView(_view1)
    .autoHeightRatio(0);
    
    
    _view0.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    [_view1 setSingleLineAutoResizeWithMaxWidth:200];
    self.clipsToBounds = YES;
}
- (void)setModel:(Info*)model
{
    _model = model;
    
    if (self.model.cover.url) {
        NSURL* url = [[NSURL alloc] initWithString:self.model.cover.url];
        [_view0 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"] options:SDWebImageRefreshCached];
    }
    else
    {
        _view0.image = [UIImage imageNamed:@"zhanwei.jpg"];
    }
    _view1.text = self.model.name;
    NSData* data = [self.model.desc dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSAttributedString *html = [[NSAttributedString alloc]initWithData:data
                                                               options:options
                                                    documentAttributes:nil
                                                                 error:nil];
    _view2.attributedText = html;

    [self setupAutoHeightWithBottomView:_view2 bottomMargin:10];

}
@end
