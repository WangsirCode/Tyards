//
//  ScoreCell.h
//  十二码
//
//  Created by 汪宇豪 on 2016/9/26.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ScoreCellDelegate
- (void)didClickButton;
@end
@interface ScoreCell : UITableViewCell
@property (nonatomic,strong) UILabel* label;
@property (nonatomic,strong) id<ScoreCellDelegate> delegate;
@end
