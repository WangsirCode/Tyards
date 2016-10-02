//
//  TagLabels.m
//  十二码
//
//  Created by 汪宇豪 on 16/9/16.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "TagLabels.h"
#import "SEMTeamHomeViewController.h"
#import "PlayerDetailViewController.h"
#import "GameInfoDetailViewController.h"
#import "CoachDetailViewController.h"
#import "RaceInfoDetailController.h"
@implementation TagLabels

- (instancetype) init
{
    self = [super init];
    if (self) {
        [self bindModel];
    }
    return self;
}
- (void)bindModel
{
    [RACObserve(self, model) subscribeNext:^(id x) {
        if (self.model) {
            __block NSInteger row = 0;
            __block NSInteger column = 0;
            __block NSInteger count = 0;
            __block NSInteger leftSpace = 0;
            __block NSInteger width = 0;
            [self.model enumerateObjectsUsingBlock:^(Tag * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                MyLabel* label = [[MyLabel alloc] init];
                label.textInsets = UIEdgeInsetsMake(5, 5, 5, 5);
                label.textAlignment = NSTextAlignmentCenter;
                label.text = obj.text;
                label.textColor = [UIColor MyColor];
                label.layer.borderWidth = 1;
                label.layer.borderColor = [UIColor colorWithHexString:@"#C8C8C8"].CGColor;
                if ([obj.type isEqualToString:@"Coach"]) {
                    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                        CoachDetailViewController* controler = [[CoachDetailViewController alloc] initWithDictionary:@{@"id":@(obj.rid)}];
                        [self.viewController.navigationController pushViewController:controler animated:YES];
                    }];
                    [label addGestureRecognizer:tap];
                }
                    else if ([obj.type isEqualToString:@"Player"])
                    {
                        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                            PlayerDetailViewController* controler = [[PlayerDetailViewController alloc] initWithDictionary:@{@"id":@(obj.rid)}];
                            [self.viewController.navigationController pushViewController:controler animated:YES];
                        }];
                        [label addGestureRecognizer:tap];
 
                    }
                    else if ([obj.type isEqualToString:@"Team"])
                    {
                        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                            SEMTeamHomeViewController* controler = [[SEMTeamHomeViewController alloc] initWithDictionary:@{@"ide":@(obj.rid)}];
                            [self.viewController.navigationController pushViewController:controler animated:YES];
                        }];
                        [label addGestureRecognizer:tap];
                    }
                    else if ([obj.type isEqualToString:@"Tournament"])
                    {
                        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                            GameInfoDetailViewController* controler = [[GameInfoDetailViewController alloc] initWithDictionay:@{@"id":@(obj.rid)}];
                            [self.viewController.navigationController pushViewController:controler animated:YES];
                        }];
                        [label addGestureRecognizer:tap];
                    }
                    else if ([obj.type isEqualToString:@"Game"])
                    {
                        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                            RaceInfoDetailController* controler = [[RaceInfoDetailController alloc] initWithDictionay:@{@"id":@(obj.rid)}];
                            [self.viewController.navigationController pushViewController:controler animated:YES];
                        }];
                        [label addGestureRecognizer:tap];
                    }
                [self addSubview:label];
                label.userInteractionEnabled = YES;
                label.font = [UIFont systemFontOfSize:18*self.scale];
                width = obj.text.length * 20 + 10;
                if ((count=count+obj.text.length) > 12) {
                    count = obj.text.length;
                    row = 0;
                    column ++;
                    leftSpace = 0;
                }
                else
                {
                    row++;
                }
                label.sd_layout
                .topSpaceToView(self,40*column*self.scale)
                .heightIs(25*self.scale)
                .leftSpaceToView(self,leftSpace*self.scale + 15)
                .widthIs(width*self.scale);
                leftSpace += width;
                leftSpace += 15;
                if (idx == self.model.count - 1) {
                    [self setupAutoHeightWithBottomView:label bottomMargin:10];
                }
                
            }];
        }
    }];
}
@end
