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
    
}
- (void)bindModel
{
    [RACObserve(self, history) subscribeNext:^(id x) {
        if (self.history.count > 0) {
            NSInteger count = self.history.count;
        
            for (int i = 0; i < count; i++) {
                PlayHistory* model = self.history[i];
                HistoryInfoView* view = [[HistoryInfoView alloc] init];
                view.model = model;
                [self addSubview:view];
                view.sd_layout
                .topSpaceToView(self,i*120*self.scale)
                .leftEqualToView(self)
                .rightEqualToView(self)
                .heightIs(120*self.scale);
            }
        }
    }];
}
@end
