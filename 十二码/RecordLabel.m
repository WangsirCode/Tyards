//
//  RecordLabel.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/9.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "RecordLabel.h"

@implementation RecordLabel
- (instancetype)initWithMark:(NSInteger)mark
{
    self = [super init];
    if (self) {
        self.mark = mark;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self makeConstraits];
        [self bindModel];
    }
    return self;
}
- (void)makeConstraits
{
    [self sd_addSubviews:@[self.markView,self.statusLable,self.percentageLabel]];
    self.markView.sd_layout
    .leftSpaceToView(self,12*self.scale)
    .topSpaceToView(self,10*self.scale)
    .heightIs(16*self.scale)
    .widthEqualToHeight();
    
    self.markView.sd_cornerRadiusFromWidthRatio = @0.5;
    
    self.statusLable.sd_layout
    .topSpaceToView(self,10*self.scale)
    .leftSpaceToView(self.markView,8*self.scale)
    .rightEqualToView(self)
    .heightIs(18);
    
    self.percentageLabel.sd_layout
    .topSpaceToView(self.statusLable,8*self.scale)
    .leftSpaceToView(self.markView,8*self.scale)
    .rightEqualToView(self)
    .autoHeightRatio(0);
}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        if (self.model) {
            NSMutableString* text;
           
        NSInteger total = self.model.wins + self.model.loses + self.model.draws;
        NSMutableString* percentage;
        if(total == 0)
        {
            percentage = [NSMutableString stringWithString:@"0%"];
        }
        else
        {
            switch (self.mark) {
                case 1:
                    text = [NSMutableString stringWithFormat:@"胜   %ld",(long)self.model.wins];
                    percentage = [NSMutableString stringWithFormat:@"%ld",self.model.wins / total * 100];
                    [percentage appendString:@"%"];
                    break;
                case 2:
                    text = [NSMutableString stringWithFormat:@"平   %ld",(long)self.model.draws];
                    percentage = [NSMutableString stringWithFormat:@"%ld",self.model.draws / total * 100];
                    [percentage appendString:@"%"];
                    break;
                case 3:
                    text = [NSMutableString stringWithFormat:@"负   %ld",(long)self.model.loses];
                    percentage = [NSMutableString stringWithFormat:@"%ld",self.model.loses / total * 100];
                    [percentage appendString:@"%"];
                    break;
                default:
                    break;
            }
            
            
        }
            switch (self.mark) {
                case 1:
                    text = [NSMutableString stringWithFormat:@"胜   %ld",(long)self.model.wins];
                    break;
                case 2:
                    text = [NSMutableString stringWithFormat:@"平   %ld",(long)self.model.draws];
                    break;
                case 3:
                    text = [NSMutableString stringWithFormat:@"负   %ld",(long)self.model.loses];
                    break;
                default:
                    break;
            }
            self.percentageLabel.text = percentage;
            self.statusLable.text = text;
        }
    }];
}
- (UIImageView *)markView
{
    if (!_markView) {
        _markView = [[UIImageView alloc] init];
        switch (self.mark) {
            case 1:
                _markView.backgroundColor = [UIColor colorWithHexString:@"76D186"];
                break;
            case 2:
                _markView.backgroundColor = [UIColor colorWithHexString:@"DAF1B4"];
                break;
            case 3:
                _markView.backgroundColor = [UIColor colorWithRed:156/255.0 green:222/255.0 blue:154/255.0 alpha:1];
                break;
            default:
                break;
        }
    }
    return _markView;
}
-  (UILabel *)statusLable
{
    if (!_statusLable) {
        _statusLable = [UILabel new];
        _statusLable.font = [UIFont systemFontOfSize:14];
        _statusLable.textColor = [UIColor colorWithHexString:@"#104D3F"];
    }
    return _statusLable;
}
- (UILabel *)percentageLabel
{
    if (!_percentageLabel) {
        _percentageLabel = [UILabel new];
        _percentageLabel.font = [UIFont systemFontOfSize:12];
        _percentageLabel.textColor = [UIColor colorWithHexString:@"#A1B2BA"];
    }
    return _percentageLabel;
}

@end
