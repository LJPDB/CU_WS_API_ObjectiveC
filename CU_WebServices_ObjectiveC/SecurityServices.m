//
//  SecurityServices.m
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import "SecurityServices.h"
@interface SecurityServices()
@property (nonatomic, strong) NSString *URIstring;
@property (nonatomic, strong) WebServicesConnection *WSC;
@end
@implementation SecurityServices
-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC{
    _URIstring = URIstring;
    _WSC = WSC;
}

// Security.svc/SignIn/
-(void)signinUserWithEmail:(NSString *)email andWithPassword:(NSString *)pasword fromThisPlatform:(NSString *)platform andThisURL:(NSString *)URLparam{
    if(email && pasword && platform){
        BOOL validEmail = [MeaningAndFormValidation NSStringIsValidEmail:(NSString *)email classReferenced: (NSString *)[self class]];
        BOOL validPlatform = [MeaningAndFormValidation validatePlatform:platform classReferenced: (NSString *)[self class]];
        if (validEmail && validPlatform) {
            NSString *requestType = @"POST";
            NSInteger timeout = 80.0;
            NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/", self.URIstring, @"SignIn"];
            NSDictionary *params = @{ @"Email" : email, @"Password" : pasword, @"Platform" : platform, @"URL" : URLparam ? URLparam : @""};
            [_WSC requestType:requestType ifParams:YES params:params withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
        }
    }else{
        [MeaningAndFormValidation printErrorWithText:@"signinUserWithEmail -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}



// Security.svc/SignOut
-(void)signoutUserWithToken:(NSString *)token{
    NSString *trimmedToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(token && ![trimmedToken isEqualToString:@""]){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSDictionary *params = @{ @"token" : [self sanitizeURLString:token] };
        NSMutableString *stringParams = [[NSMutableString alloc] init];
        for (NSString *key in params) {
            NSString *aux = [[NSString alloc] initWithString:[NSString stringWithFormat:@"?%@=%@", key, [params valueForKey:key]]];
            stringParams = (NSMutableString *)[stringParams stringByAppendingString:aux];
        }
        NSString *auxURI = [NSString stringWithFormat:@"%@%@%@", self.URIstring, @"Signout", (NSString *)stringParams];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"signoutUserWithToken -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/Valid
-(void)isUserValidWithToken:(NSString *)token{
    NSString *trimmedToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(token && ![trimmedToken isEqualToString:@""]){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSDictionary *params = @{ @"token" : [self sanitizeURLString:token] };
        NSMutableString *stringParams = [[NSMutableString alloc] init];
        for (NSString *key in params) {
            NSString *aux = [[NSString alloc] initWithString:[NSString stringWithFormat:@"?%@=%@", key, [params valueForKey:key]]];
            stringParams = (NSMutableString *)[stringParams stringByAppendingString:aux];
        }
        NSString *auxURI = [NSString stringWithFormat:@"%@%@%@", self.URIstring, @"Valid", (NSString *)stringParams];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"isUserValidWithToken -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/Refresh
-(void)refreshUserSessionWithToken:(NSString *)token{
    NSString *trimmedToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(token && ![trimmedToken isEqualToString:@""]){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSDictionary *params = @{ @"token" : [self sanitizeURLString:token] };
        NSMutableString *stringParams = [[NSMutableString alloc] init];
        for (NSString *key in params) {
            NSString *aux = [[NSString alloc] initWithString:[NSString stringWithFormat:@"?%@=%@", key, [params valueForKey:key]]];
            stringParams = (NSMutableString *)[stringParams stringByAppendingString:aux];
        }
        NSString *auxURI = [NSString stringWithFormat:@"%@%@%@", self.URIstring, @"Refresh", (NSString *)stringParams];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"refreshUserSessionWithToken -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/Info
-(void)userInfoWithToken:(NSString *)token{
    NSString *trimmedToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(token && ![trimmedToken isEqualToString:@""]){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSDictionary *params = @{ @"token" : [self sanitizeURLString:token] };
        NSMutableString *stringParams = [[NSMutableString alloc] init];
        for (NSString *key in params) {
            NSString *aux = [[NSString alloc] initWithString:[NSString stringWithFormat:@"?%@=%@", key, [params valueForKey:key]]];
            stringParams = (NSMutableString *)[stringParams stringByAppendingString:aux];
        }
        NSString *auxURI = [NSString stringWithFormat:@"%@%@%@", self.URIstring, @"Info", (NSString *)stringParams];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"userInfoWithToken -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/User
-(void)createUser:(NSDictionary *)user{
    if([self checkUserKeyValues:user]&&[self checkUserMandatorySettings:user]){
        NSString *requestType = @"POST";
        NSInteger timeout = 80.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@/", self.URIstring, @"User"];
        [_WSC requestType:requestType ifParams:YES params:user withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"createUser -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/ActivateUser/userId
-(void)activateUserWithGUID:(NSString *)userGUID{
    if(userGUID){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@/%@", self.URIstring, @"ActivateUser", userGUID];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"activateUserWithGUID -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/User/userId
-(void)readCompleteUserInfoWithGUID:(NSString *)userGUID{
    //NSString *trimmedToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(userGUID){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@/%@", self.URIstring, @"User", userGUID];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"readCompleteUserInfoWithGUID -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/Info
-(void)readCompleteUserInfoWithToken:(NSString *)token{
    NSString *trimmedToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(token && ![trimmedToken isEqualToString:@""]){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSDictionary *params = @{ @"hash" : [self sanitizeURLString:token] };
        NSMutableString *stringParams = [[NSMutableString alloc] init];
        for (NSString *key in params) {
            NSString *aux = [[NSString alloc] initWithString:[NSString stringWithFormat:@"?%@=%@", key, [params valueForKey:key]]];
            stringParams = (NSMutableString *)[stringParams stringByAppendingString:aux];
        }

        NSString *auxURI = [NSString stringWithFormat:@"%@%@%@", self.URIstring, @"UserByHash", stringParams];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"readCompleteUserInfoWithToken -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/UpdateUser/
-(void)updateUser:(NSString *)userGUID withNewSettingsValues:(NSDictionary *)newValues{
    //NSString *trimmedToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(userGUID && [self checkUserKeyValues:newValues]){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *firstCall = [NSString stringWithFormat:@"%@%@/%@", self.URIstring, @"User", userGUID];
        NSString *secondCall = [NSString stringWithFormat:@"%@%@/", self.URIstring, @"UpdateUser"];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:firstCall nestedCall:YES nestedCallType:0 URLforNestedCall:secondCall nestedCallRequestType:@"POST" nestedCallWithTimeout:80.0 nestedCallIfParams:YES paramsForNestedCall:newValues];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"updateUser -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/RememberEmail/IdCard/day/month/year
-(void)rememberEmailForThisIdCard:(NSString *)idCard forDay:(int)date forMonth:(int)month andYearOfBirth:(int)year{
    BOOL validYear = [MeaningAndFormValidation yearInBetweenPropperValues:year classReferenced:(NSString *)[self class]];
    BOOL validDate = [MeaningAndFormValidation dateInBetweenPropperValues:date classReferenced: (NSString *)[self class]];
    BOOL validMonth = [MeaningAndFormValidation monthInBetweenPropperValues:month classReferenced: (NSString *)[self class]];
    BOOL validIdCard = [MeaningAndFormValidation validateIdCardFormat:idCard classReferenced:(NSString *)[self class]];
    if(validYear && validDate && validIdCard && validMonth){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@/%@/%d/%d/%d", self.URIstring, @"RememberEmail", idCard, date, month, year];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"rememberEmailForThisIdCard -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/RememberPassword/userEail
-(void)rememberPasswordForThisEmail:(NSString *)eMail{
    BOOL validEmail = [MeaningAndFormValidation NSStringIsValidEmail:eMail classReferenced:(NSString *)[self class]];
    if(validEmail){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@/%@", self.URIstring, @"RememberPassword", eMail];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"rememberPasswordForThisEmail -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/VerifiedAnswer/userEail/answer
-(void)verifyAnswerForThisEmail:(NSString *)eMail withThisAnswer:(NSString *)answer{
    BOOL validEmail = [MeaningAndFormValidation NSStringIsValidEmail:eMail classReferenced:(NSString *)[self class]];
    NSString *trimmedAnswer = [answer stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(validEmail && answer && ![trimmedAnswer isEqualToString:@""]){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@/%@/%@", self.URIstring, @"VerifiedAnswer", eMail, [self sanitizeURLStringCustom:answer]];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"verifyAnswerForThisEmail -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Security.svc/VerifiedEmailAndIdCard/userEail/answer
-(void)verifyThisEmail:(NSString *)eMail withThisIdCard:(NSString *)IdCard {
    BOOL validEmail = [MeaningAndFormValidation NSStringIsValidEmail:eMail classReferenced:(NSString *)[self class]];
    BOOL validIdCard = [MeaningAndFormValidation validateIdCardFormat:IdCard classReferenced:(NSString *)[self class]];
    if(validEmail && validIdCard){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@/%@/%@", self.URIstring, @"VerifiedEmailAndIdCard", eMail, IdCard];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"verifyThisEmail -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}



#pragma mark - Methods to validate and serialize params

-(NSString *) sanitizeURLString:(NSString *)param
{
    NSMutableString *Results = (NSMutableString *)param;
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@">" withString:@"%3E"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"#" withString:@"%23"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"{" withString:@"%7B"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"'\'" withString:@"%5C"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"ˆ" withString:@"%5E"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"˜" withString:@"%7E"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"[" withString:@"%5B"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"]" withString:@"%5D"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"`" withString:@"%60"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
    //Results = (NSString *)[Results stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"$" withString:@"%24"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];

    return (NSString *)Results;
}

-(NSString *) sanitizeURLStringCustom:(NSString *)param
{
    NSMutableString *Results = (NSMutableString *)param;
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@">" withString:@"%3E"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"#" withString:@"%23"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"{" withString:@"%7B"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"'\'" withString:@"%5C"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"ˆ" withString:@"%5E"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"˜" withString:@"%7E"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"[" withString:@"%5B"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"]" withString:@"%5D"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"`" withString:@"%60"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"$" withString:@"%24"];
    Results = (NSMutableString *)[Results stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    return (NSString *)Results;
}



-(BOOL)checkUserMandatorySettings:(NSDictionary *)user{
    BOOL isValid = YES;
    NSArray *mandatoryValues = @[@"Id", @"Name", @"LastName", @"Password", @"PasswordComparation", @"Email", @"EmailComparation", @"SecretQuestion", @"SecretAnswer", @"IdCard", @"BirthDate"];
    NSMutableArray *emptyValues = [[NSMutableArray alloc]init];
    for (NSString *key in user) {
        if (([[user valueForKey:key] intValue] == 0) && (![key isEqualToString:@"Sex"]) && (![key isEqualToString:@"ReceiveMassMail"]) && (![key isEqualToString:@"Active"])) {
            if ([[user valueForKey:key] isEqualToString:@""] || [user valueForKey:key]==nil || [[[user valueForKey:key] stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
                [emptyValues addObject:key];
            }
        }
    }
    if( ![emptyValues containsObject:@"Email"] && ![emptyValues containsObject:@"EmailComparation"] && ![[user valueForKey:@"Email"] isEqualToString:[user valueForKey:@"EmailComparation"]] ){
        isValid = NO;
        [MeaningAndFormValidation printErrorWithText:@"checkUserMandatorySettings -> Email and ConfirmationEmail do not match" inClass:(NSString *)[self class]];
    }
    for (NSString *value in emptyValues) {
        if ([mandatoryValues containsObject:value]) {
            isValid = NO;
            [MeaningAndFormValidation printErrorWithText:@"checkUserMandatorySettings -> Mandatory values passed 'null' or 'empty'" inClass:(NSString *)[self class]];
        }
    }
    return isValid;
}

-(BOOL)checkUserKeyValues:(NSDictionary *)userSettings{
    BOOL isValid = YES;
    NSArray *defaultValues = @[@"Id", @"Name", @"LastName", @"Password", @"PasswordComparation", @"SecretQuestion", @"SecretAnswer", @"ReceiveMassMail", @"BirthDate", @"Email", @"EmailComparation", @"IdCard", @"IdCardType", @"IdCardNumber", @"Phone", @"MobilePhone", @"Sex", @"City", @"State", @"Country", @"Address", @"CreationDate", @"ActivationDate", @"Active", @"DateOut", @"DateLastVisit", @"DateCurrentVisit", @"DateLastUpdate", @"Zipcode", @"Twitter", @"Facebook", @"Instagram"];
    if (userSettings) {
        NSArray *keys = [userSettings allKeys];
        for (NSString *value in keys) {
            if (![defaultValues containsObject:value]) {
                isValid = NO;
                [MeaningAndFormValidation printErrorWithText:@"checkUserKeyValues -> Dictionary has invalid user attribute(s)'s name, check dictionary keys." inClass:(NSString *)[self class]];
            }
        }
    } else {
        isValid = NO;
        [MeaningAndFormValidation printErrorWithText:@"checkUserKeyValues -> Invalid variable passed through." inClass:(NSString *)[self class]];
    }
    
    return isValid;
}


@end