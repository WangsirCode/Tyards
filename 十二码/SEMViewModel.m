//
//  MDAViewModel.m
//  MediaAssistant
//
//  Created by Hirat on 16/7/9.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import "SEMViewModel.h"
#import "MDABizManager.h"
#import "UserModel.h"
@interface SEMViewModel ()
@property (nonatomic, strong) NSDictionary* userInfo;
@property (nonatomic,strong ) NSString* unreadReply;
@property (nonatomic,strong) NSString* unreadInvitation;
@end

@implementation SEMViewModel

- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    if (self = [super init])
    {
        _userInfo = [NSDictionary dictionaryWithDictionary: dictionary];
        [self fetchInvitation];
        [self getReply];
        [self setup];
    }
    return self;
}

- (void)setup
{
    
}
-(NSString *)getSchoolCode
{
    NSUserDefaults *database = [NSUserDefaults standardUserDefaults];
    return [database objectForKey:@"name"];
}
- (NSString*)getSchoolName
{
    NSUserDefaults *database = [NSUserDefaults standardUserDefaults];
    return [database objectForKey:@"displayname"];
}
- (NSString *)getToken
{
    NSString* token = (NSString*)[DataArchive unarchiveUserDataWithFileName:@"token"];
    if (token == nil) {
        return @"";
    }
    return token;
}
- (BOOL)didLogined
{
   UserModel* model  = (UserModel*)[DataArchive unarchiveUserDataWithFileName:@"userinfo"];
    if (model) {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)fetchReply
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchUnReadReply:[self getToken] success:^(id data) {
        _unreadReply = [(NSNumber*)data stringValue];
    } failure:^(NSError *aError) {
        
    }];
}
- (void)fetchInvitation
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchUnreadInvitation:[self getToken] success:^(id data) {
        _unreadInvitation = [(NSNumber*)data stringValue];
    } failure:^(NSError *aError) {
        
    }];
}

- (NSString *)getReply
{
    if ([self.unreadReply integerValue] != 0) {
        return self.unreadReply;
    }
    else
    {
        return nil;
    }
    return nil;
}
- (NSString *)getInvitation
{
    if ([self.unreadInvitation integerValue] != 0) {
        return self.unreadReply;
    }
    else
    {
        return nil;
    }
    return nil;
}
- (BOOL)haveUnredMessge
{
    if ([self getReply] || [self getInvitation]) {
        return YES;
    }
    return NO;
}

@end
