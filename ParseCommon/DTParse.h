//
//  ParseCommon.h
//  ParseCommon
//
//  Created by David Tseng on 11/11/13.
//  Copyright (c) 2013 David Tseng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTParse : NSObject

typedef void(^XBLOCK)();
typedef void(^XOBJECTBLOCK)(id object);
typedef void(^XERRORBLOCK)(NSError* err);
typedef void(^XSTRINGBLOCK)(NSString* string);
typedef void(^XARRAYBLOCK)(NSArray* array);
typedef void(^XOBJARRAYBLOCK)(NSArray* objectArray);
typedef void(^XUSERBLOCK)(PFUser *user);

//Push
+(NSString*)showSubscribeChannels;
+(void)subscribeChannel:(NSString*)channelName;
+(void)unsubscribeChannel:(NSString*)channelName;


#pragma mark - User

//Register
//Register with email not required.
+(void)signUpByName:(NSString*)username andPassword:(NSString*)password andEmail:(NSString*)email
        withSuccess:(XBLOCK)success withFailure:(XERRORBLOCK)failure;

//Register with email required.
+(void)signUpByName:(NSString*)username andPassword:(NSString*)password
        withSuccess:(XBLOCK)success withFailure:(XERRORBLOCK)failure;

//Get current user.
+(void)currentUserWithSuccess:(XUSERBLOCK)success withFailure:(XBLOCK)failure;

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




//API from Cloud Function

+(void)shopByLocation:(CLLocationCoordinate2D)loc andRange:(double)range
          WithSuccess:(XOBJARRAYBLOCK)success withFailure:(XERRORBLOCK)failure;







@end
