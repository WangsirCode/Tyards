//
//  MDAViewModel.h
//  MediaAssistant
//
//  Created by Hirat on 16/7/9.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import <RVMViewModel.h>

@interface SEMViewModel : RVMViewModel

@property (nonatomic, strong, readonly) NSDictionary* userInfo;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

- (void)setup;

@end
