//
//  CommentView.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/1.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "CommentView.h"
#import "MDABizManager.h"
@implementation CommentView
- (instancetype)initWithReplies:(NSArray *)replies
{
    self = [super init];
    if (self) {
        self.replys = replies;
        [self setUpView];
    }
    return self;
}
- (void)setUpView
{
    NSUserDefaults* data = [NSUserDefaults standardUserDefaults];
    CGFloat scale = [data floatForKey:@"scale"];
    self.labels = [[NSMutableArray alloc] init];
    self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    if (self.replys.count > 0) {
        [self.replys enumerateObjectsUsingBlock:^(Reply * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Reply* reply = self.replys[idx];
            NSString* filstName;
            NSString* secName;
            NSMutableString* string = [[NSMutableString alloc] init];
            [string appendString:reply.creator.nickname];
            filstName = reply.creator.nickname;
            if (reply.remind) {
                [string appendString:@"回复"];
                [string appendString:reply.remind.nickname];
                secName = reply.remind.nickname;
            }
            [string appendString:@":  "];
            [string appendString:reply.content];
            UILabel* label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 0;
            [self addSubview:label];
            [self.labels appendObject:label];
            [label setSingleLineAutoResizeWithMaxWidth:280*scale];
            
            //设置富文本
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
            NSRange fisrtarange = [string rangeOfString:filstName];
            NSRange range = NSMakeRange(filstName.length, string.length - filstName.length);
            NSRange secrange;
            if (secName) {
                secrange = [string rangeOfString:secName options:nil range:range];
                [AttributedStr addAttribute:NSForegroundColorAttributeName
                 
                                      value:[UIColor colorWithHexString:@"#1EA11F"]
                 
                                      range:secrange];
            }
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor colorWithHexString:@"#1EA11F"]
             
                                  range:fisrtarange];
            label.attributedText = AttributedStr;
            
            //设置约束
            if (idx == 0) {
                label.sd_layout
                .topSpaceToView(self,10*scale)
                .leftSpaceToView(self,10*scale)
                .autoHeightRatio(0);
            }
            else
            {
                UILabel* upLabel = self.labels[idx - 1];
                label.sd_layout
                .topSpaceToView(upLabel,8*scale)
                .leftSpaceToView(self,10*scale)
                .autoHeightRatio(0);
            }
        }];
        [ self setupAutoHeightWithBottomView:self.labels.lastObject bottomMargin:10*scale ];
    }
    else
    {
        self.height = 0;
    }
    

}
@end
