//
//  DraftsCell.m
//  十二码
//
//  Created by Hello World on 16/11/8.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "DraftsCell.h"

@implementation DraftsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setData:(NSDictionary*)dic{
    self.titleLab.text=dic[@"title"];
    self.rightLab.text=[NSString stringWithFormat:@"%@",dic[@"commentCount"]];
    self.leftLab.text=[NSString stringWithFormat:@"%@",dic[@"loveCount"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
