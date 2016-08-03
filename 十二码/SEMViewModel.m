//
//  MDAViewModel.m
//  MediaAssistant
//
//  Created by Hirat on 16/7/9.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import "SEMViewModel.h"

@interface SEMViewModel ()
@property (nonatomic, strong) NSDictionary* userInfo;
@end

@implementation SEMViewModel

- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    if (self = [super init])
    {
        _userInfo = [NSDictionary dictionaryWithDictionary: dictionary];
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    
}

@end
