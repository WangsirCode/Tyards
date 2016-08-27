//
//  HistoryView.m
//  十二码
//
//  Created by 汪宇豪 on 16/8/27.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "HistoryView.h"
#import "PlayHistory.h"
@implementation HistoryView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeContraits];
        [self bindModel];
    }
    return self;
}
- (void)makeContraits
{
    NSArray<NSString*>* titleArray = @[@"日期",@"赛事",@"比分"];
    for (int i = 0; i < 3; i ++) {
        UILabel* label = [UILabel new];
        label.text = titleArray[i];
        label.textColor = [UIColor colorWithHexString:@"#999999"];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        label.sd_layout
        .topEqualToView(self)
        .leftSpaceToView(self,115*i*self.scale)
        .heightIs(48*self.scale)
        .widthIs(115*self.scale);
    }
}
- (void)bindModel
{
    [RACObserve(self, history) subscribeNext:^(id x) {
        if (self.history.count > 0) {
            NSInteger count = self.history.count;
        
            for (int i = 0; i < count; i++) {
                PlayHistory* model = self.history[i];
                NSArray<NSString*>* contents = @[[model getDate],model.tournament.name,[model getScore]];
                for (int j = 0; j<3; j++) {
                    UILabel* label = [UILabel new];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.text = contents[j];
                    [self addSubview:label];
                    label.sd_layout
                    .topSpaceToView(self,48*(i+1)*self.scale)
                    .leftSpaceToView(self,115*j*self.scale)
                    .heightIs(48*self.scale)
                    .widthIs(115.3*self.scale);
                }
            }
        }
    }];
}
@end
