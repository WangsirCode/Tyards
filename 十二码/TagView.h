//
//  TagView.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/28.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 *  @author 汪宇豪, 16-07-28 14:07:02
 *
 *  @brief 显示标签的view
 */
@interface TagView : UIView
@property (nonatomic,strong) NSArray<NSString*>* tagArray;
@property (nonatomic,strong)NSMutableArray<UILabel*>* labels;

@end
