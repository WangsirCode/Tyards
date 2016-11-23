//
//  WateringCell.h
//  十二码
//
//  Created by Hello World on 16/11/2.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WateringCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *authorLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;

-(void)setData:(NSDictionary *)dic;
@end
