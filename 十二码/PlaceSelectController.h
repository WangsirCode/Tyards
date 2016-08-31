//
//  PlaceSelectController.h
//  十二码
//
//  Created by 汪宇豪 on 16/8/31.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlaceSelectControllerDelegate
- (void)didSelectPlace:(NSString*)place iden:(NSInteger)iden;
@end
@interface PlaceSelectController : UIViewController
@property (nonatomic,strong) id<PlaceSelectControllerDelegate> delegate;
@end
