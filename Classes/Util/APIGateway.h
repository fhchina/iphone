//
//  APIGateway.h
//  Yammer
//
//  Created by aa on 1/29/09.
//  Copyright 2009 Yammer, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface APIGateway : NSObject {

}

+ (NSMutableDictionary *)usersCurrent;
+ (NSMutableArray *)homeTabs;
+ (NSMutableDictionary *)pushSettings;
+ (NSMutableArray *)users:(int)page;
+ (NSMutableDictionary *)userById:(NSString *)theUserId;
+ (NSMutableDictionary *)messages:(NSString *)url olderThan:(NSDecimalNumber *)olderThan;
+ (NSMutableDictionary *)messages:(NSString *)url newerThan:(NSDecimalNumber *)newerThan;  
+ (NSMutableDictionary *)messages:(NSString *)url olderThan:(NSDecimalNumber *)olderThan newerThan:(NSDecimalNumber *)newerThan;
+ (BOOL)createMessage:(NSString *)body repliedToId:(NSDecimalNumber *)repliedToId groupId:(NSDecimalNumber *)groupId;
+ (BOOL)followingUser:(NSString *)theUserId;
+ (BOOL)removeFollow:(NSString *)theUserId;
+ (BOOL)addFollow:(NSString *)theUserId;
+ (BOOL)sendPushToken:(NSString *)token;
+ (BOOL)updatePushSetting:(NSString *)feed_key status:(NSString *)statusValue;

@end