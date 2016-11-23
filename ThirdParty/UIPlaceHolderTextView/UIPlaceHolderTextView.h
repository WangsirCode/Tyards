//
//  UIPlaceHolderTextView.h
//  FantasyPlane_ipad
//
//  Created by fx on 14-5-21.
//  Copyright (c) 2014年 sookin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
