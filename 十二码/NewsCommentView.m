//
//  NewsCommentView.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/13.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "NewsCommentView.h"
#import "MDABizManager.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width


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
                label.textAlignment = NSTextAlignmentLeft;
                label.numberOfLines = 0;
                [self addSubview:label];
                NSString* firstName = obj.comment.creator.nickname;
                NSString* secName = self.targetName;
                NSString* content = obj.comment.content;
                
                
                
                
                NSMutableAttributedString* string = [[NSMutableAttributedString alloc] init];
                [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",firstName] attributes:nil]];
                [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复"] attributes:nil]];
                [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",secName] attributes:nil]];
                [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@":  "] attributes:nil]];
                NSMutableAttributedString *text = [NSMutableAttributedString new];
                NSArray *array = [content componentsSeparatedByString:@"$"];
                for (NSString *string in array) {
                    if (string.length>0) {
                        if ([string hasPrefix:@"["]&&string.length>4) {
                            NSString *temp = [[string substringToIndex:5] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"["]];
                            NSString *gifString = [temp stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"]"]];
                            NSLog(@"%@",gifString);
                            // 添加表情
                            gifString = [gifString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
                            // 表情图片
                            attch.image = [UIImage imageNamed:[NSString stringWithFormat:@"emoji_%@",[gifString substringToIndex:3]]];
                            // 设置图片大小
                            attch.bounds = CGRectMake(0, 0, 15, 15);
                            
                            [text appendAttributedString:[NSAttributedString attributedStringWithAttachment:attch]];
                            [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[string substringFromIndex:5]] attributes:nil]];
                        }
                        else{
                            
                            [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",string] attributes:nil]];                    }
                    }
                }
                [string appendAttributedString:text];

                [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, string.length)];
                if (secName) {
                    [string addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor colorWithHexString:@"#1EA11F"]
                                   range:NSMakeRange(firstName.length+2, secName.length)];
                }
                [string addAttribute:NSForegroundColorAttributeName
                               value:[UIColor colorWithHexString:@"#1EA11F"]
                               range:NSMakeRange(0, firstName.length)];
                [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:13*self.scale] range:NSMakeRange(0, string.length)];
      
                CGRect labelSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 25) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
                label.attributedText = string;
                NSInteger num =labelSize.size.width/(ScreenWidth-70-20);
                
                NSArray *arr= [content componentsSeparatedByString:@"\n"];
                num=num+arr.count;
                if (arr.count!=1) {
                    num=num+1;
                }
                label.sd_layout.heightIs(num*18);

                
                
                
                
                
                
                
//                NSMutableString* string = [NSMutableString new];
//                [string appendString:firstName];
//                [string appendString:@" 回复 "];
//                [string appendString:secName];
//                [string appendString:@" : "];
//                [string appendString:content];
//                NSMutableAttributedString* attri = [[NSMutableAttributedString alloc] initWithString:string];
//                [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12*self.scale] range:NSMakeRange(0, attri.length)];
//                [attri addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, attri.length)];
//                [attri addAttribute:NSForegroundColorAttributeName value:[UIColor MyColor] range:NSMakeRange(0, firstName.length)];
//                [attri addAttribute:NSForegroundColorAttributeName value:[UIColor MyColor] range:NSMakeRange(firstName.length+4, secName.length)];
//                label.attributedText = attri;
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                if (self.count == 0) {
                    label.sd_layout
                    .topSpaceToView(self,5)
                    .leftSpaceToView(self,3)
                    .rightSpaceToView(self,3);
//                    .autoHeightRatio(0);
                }
                else
                {
                    label.sd_layout
                    .topSpaceToView(labels[self.count - 1],5)
                    .leftSpaceToView(self,3)
                    .rightSpaceToView(self,3);
//                    .autoHeightRatio(0);
                }
                self.count += 1;
                [labels addObject:label];
                UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                    [self.delegate didClickButton:obj.comment.id remindId:obj.comment.creator.id name:obj.comment.creator.nickname];
                }];
                [label addGestureRecognizer:tap];
                label.userInteractionEnabled = YES;
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
                        [attri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12*self.scale] range:NSMakeRange(0, attri.length)];
                        [attri addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, attri.length)];
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
                
                        UITapGestureRecognizer* tap =[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                            [self.delegate didClickButton:obj.comment.replies[i].targetComment.id remindId:obj.comment.replies[i].creator.id name:obj.comment.replies[i].creator.nickname];
                        }];
                        [label addGestureRecognizer:tap];
                        label.userInteractionEnabled = YES;
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
