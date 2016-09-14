//
//  NewsCommentView.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/13.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "NewsCommentView.h"

@implementation NewsCommentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor BackGroundColor];
        self.count = 0;
        [self bindModel];
        [self setupView];
    }
    return self;
}
- (void)setupView
{
    
}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        if (self.model) {
            NSMutableArray<UILabel*> *labels = [NSMutableArray new];
            [self.model enumerateObjectsUsingBlock:^(Comments * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UILabel* label = [UILabel new];
                [self addSubview:label];
                NSString* firstName = obj.comment.creator.nickname;
                NSString* secName = self.targetName;
                NSString* content = obj.comment.content;
                NSMutableString* string = [NSMutableString new];
                [string appendString:firstName];
                [string appendString:@" 回复 "];
                [string appendString:secName];
                [string appendString:@" : "];
                [string appendString:content];
                NSMutableAttributedString* attri = [[NSMutableAttributedString alloc] initWithString:string];
                [attri addAttribute:NSForegroundColorAttributeName value:[UIColor MyColor] range:NSMakeRange(0, firstName.length)];
                [attri addAttribute:NSForegroundColorAttributeName value:[UIColor MyColor] range:NSMakeRange(firstName.length+4, secName.length)];
                label.attributedText = attri;
                if (self.count == 0) {
                    label.sd_layout
                    .topSpaceToView(self,5)
                    .leftSpaceToView(self,3)
                    .rightEqualToView(self)
                    .autoHeightRatio(0);
                }
                else
                {
                    label.sd_layout
                    .topSpaceToView(labels[self.count - 1],0)
                    .leftSpaceToView(self,3)
                    .rightEqualToView(self)
                    .autoHeightRatio(0);
                }
                self.count += 1;
                [labels addObject:label];
                if (obj.comment.replies.count > 0) {
                    for (int i = 0; i < obj.comment.replies.count; i ++) {
                        UILabel* label = [UILabel new];
                        [self addSubview:label];
                        NSString* firstName = obj.comment.replies[i].creator.nickname;
                        NSString* secName = obj.comment.replies[i].remind.nickname;
                        NSString* content = obj.comment.replies[i].content;
                        NSMutableString* string = [NSMutableString new];
                        [string appendString:firstName];
                        [string appendString:@" 回复 "];
                        [string appendString:secName];
                        [string appendString:@" : "];
                        [string appendString:content];
                        NSMutableAttributedString* attri = [[NSMutableAttributedString alloc] initWithString:string];
                        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor MyColor] range:NSMakeRange(0, firstName.length)];
                        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor MyColor] range:NSMakeRange(firstName.length+4, secName.length)];
                        label.attributedText = attri;
                        label.sd_layout
                        .topSpaceToView(labels[self.count - 1],5)
                        .leftSpaceToView(self,3)
                        .rightEqualToView(self)
                        .autoHeightRatio(0);
                        self.count += 1;
                        [labels addObject:label];
                        if (idx == (self.model.count - 1) && i == (obj.comment.replies.count - 1)) {
                            
                            [self setupAutoHeightWithBottomView:labels[self.count - 1] bottomMargin:10];
                            self.count = 0;
                        }
                    }
                    
                }
                else
                {
                    if (idx == self.model.count - 1) {
                       
                        [self setupAutoHeightWithBottomView:labels[self.count - 1] bottomMargin:10];
                        self.count = 0;
                    }
                }
            }];
        }
    }];
}
@end
