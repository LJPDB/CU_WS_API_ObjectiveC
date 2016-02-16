//
//  SecurityServices.h
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServicesConnection.h"
#import "MeaningAndFormValidation.h"

@interface SecurityServices : NSObject
-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC;
-(void)signinUserWithEmail:(NSString *)email andWithPassword:(NSString *)pasword fromThisPlatform:(NSString *)platform andThisURL:(NSString *)URLparam;
-(void)signoutUserWithToken:(NSString *)token;
-(void)isUserValidWithToken:(NSString *)token;
-(void)refreshUserSessionWithToken:(NSString *)token;
-(void)userInfoWithToken:(NSString *)token;
-(void)createUser:(NSDictionary *)user;
-(void)activateUserWithGUID:(NSString *)userGUID;
-(void)readCompleteUserInfoWithGUID:(NSString *)userGUID;
-(void)readCompleteUserInfoWithToken:(NSString *)token;
-(void)updateUser:(NSString *)userGUID withNewSettingsValues:(NSDictionary *)newValues;
-(void)rememberEmailForThisIdCard:(NSString *)idCard forDay:(int)date forMonth:(int)month andYearOfBirth:(int)year;
-(void)rememberPasswordForThisEmail:(NSString *)eMail;
-(void)verifyAnswerForThisEmail:(NSString *)eMail withThisAnswer:(NSString *)answer;
-(NSString *) sanitizeURLStringCustom:(NSString *)param;
-(void)verifyThisEmail:(NSString *)eMail withThisIdCard:(NSString *)IdCard;
-(NSString *) sanitizeURLString:(NSString *)param;
@end
