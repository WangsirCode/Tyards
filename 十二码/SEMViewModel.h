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
@property (nonatomic,assign)BOOL shouldReloadData;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (void)setup;
- (NSString*)getSchoolCode;
- (NSString*)getToken;
- (BOOL)didLogined;
- (NSString*)getSchoolName;
- (NSString*)getReply;
- (NSString*)getInvitation;
- (BOOL)haveUnredMessge;
- (void)fetchReply;
- (void)fetchInvitation;
@end
