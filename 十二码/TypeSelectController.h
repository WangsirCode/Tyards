//
//  TypeSelectController.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TypeSelectControllerDelegate
- (void)didSelectedItem:(NSString*)type;
@end
@interface TypeSelectController : UIViewController
@property (nonatomic,strong) id<TypeSelectControllerDelegate> delegate;
@end
