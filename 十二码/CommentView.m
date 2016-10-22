//
//  CommentView.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/1.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "CommentView.h"
#import "MDABizManager.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

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
            NSMutableAttributedString* string = [[NSMutableAttributedString alloc] init];
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",reply.creator.nickname] attributes:nil]];
            filstName = reply.creator.nickname;
            if (reply.remind) {
                [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复"] attributes:nil]];
                
//                [string appendString:@"回复"];
//                [string appendString:reply.remind.nickname];
                
                [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",reply.remind.nickname] attributes:nil]];
                secName = reply.remind.nickname;
            }
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@":  "] attributes:nil]];
//            [string appendString:@":  "];
//            [string appendString:reply.content];
            
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            NSArray *array = [reply.content componentsSeparatedByString:@"$"];
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
            
            
            UILabel* label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.numberOfLines = 0;
            [self addSubview:label];
            [self.labels appendObject:label];
//            [label setSingleLineAutoResizeWithMaxWidth:280*scale];
        //设置富文本
//            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithAttributedString:string];
//            NSRange fisrtarange = [string rangeOfString:filstName];
//            NSRange range = NSMakeRange(filstName.length, string.length - filstName.length);
//            NSRange secrange;
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, string.length)];
            if (secName) {
//                secrange = [string rangeOfString:secName options:nil range:range];
                [string addAttribute:NSForegroundColorAttributeName
//
                                      value:[UIColor colorWithHexString:@"#1EA11F"]
                 
                                      range:NSMakeRange(filstName.length+2, secName.length)];
            }
            [string addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor colorWithHexString:@"#1EA11F"]
             
                                  range:NSMakeRange(0, filstName.length)];
            [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:13*self.scale] range:NSMakeRange(0, string.length)];
            
            

            CGRect labelSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 100) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
            
            label.attributedText = string;
            int num =labelSize.size.width/(ScreenWidth-70-20);
            num=num+1;
            label.sd_layout.heightIs(num*16);

            //设置约束
            if (idx == 0) {
                label.sd_layout
                .topSpaceToView(self,10*scale)
                .rightSpaceToView(self, 10)

                .leftSpaceToView(self,10*scale);
//                .autoHeightRatio(0);
                

            }
            else
            {
                UILabel* upLabel = self.labels[idx - 1];
                label.sd_layout
                .topSpaceToView(upLabel,8*scale)
                .rightSpaceToView(self, 10)

                .leftSpaceToView(self,10*scale);
//                .autoHeightRatio(0);
            }
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                [self.delegate didClickButton:obj.targetComment.id remindId:obj.creator.id name:obj.creator.nickname];
            }];
            [label addGestureRecognizer:tap];
            label.userInteractionEnabled = YES;
        }];
        [ self setupAutoHeightWithBottomView:self.labels.lastObject bottomMargin:10*scale ];
    }
    else
    {
        self.height = 0;
    }
    

}

@end
