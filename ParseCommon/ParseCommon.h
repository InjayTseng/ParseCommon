//
//  ParseCommon.h
//  ParseCommon
//
//  Created by David Tseng on 11/11/13.
//  Copyright (c) 2013 David Tseng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseCommon : NSObject


//Push
+(NSString*)showSubscribeChannels;
+(void)subscribeChannel:(NSString*)channelName;
+(void)unsubscribeChannel:(NSString*)channelName;


//User
+(void)signUpByName:(NSString*)username andPassword:(NSString*)password;
+(void)loginByName:(NSString*)username andPassword:(NSString*)password;
+(void)currentUser; //sign up or login first
+(void)logout;


//Facebook
+(void)logInWithFacebookByPermissions:(NSArray*)permissions;
+(void)reauthorizeUserByPermissions:(NSArray*)permissions;
+(void)linkToFacebook:(PFUser*)user;
+(void)unlinkToFacebook:(PFUser*)user;
+(FBSession*)facebookSession;


//In-App Purchase
+(void)addObserverForProduct:(NSString*)productName;
+(void)buyProduct:(NSString*)productName;

@end
