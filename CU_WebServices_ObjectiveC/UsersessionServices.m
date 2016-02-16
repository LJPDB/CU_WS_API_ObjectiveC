//
//  UsersessionServices.m
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import "UsersessionServices.h"
@interface UsersessionServices()
@property (nonatomic, strong) NSString *URIstring;
@property (nonatomic, strong) WebServicesConnection *WSC;
@end
@implementation UsersessionServices
-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC{
    _URIstring = URIstring;
    _WSC = WSC;
}

// UserSessionServices.svc/
-(void)createUserSessionInTheater:(int)theaterId withSession:(int)sessionId forMovie:(NSString *)movieId withTickets:(NSArray *)ticketsArray {
    //NSString *trimmedToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    BOOL validMovieId = [MeaningAndFormValidation checkMovieId:movieId classReferenced:(NSString *)[self class]];
    BOOL validTheaterId = [MeaningAndFormValidation theaterInBetweenPropperValues:theaterId ifValidEnviroment:self.WSC.goToEnviroment classReferenced: (NSString *)[self class]];
    if(validTheaterId && validMovieId){
        NSString *requestType = @"POST";
        NSInteger timeout = 120.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@", self.URIstring];
        NSDictionary *sessionToCreate = @{@"TheaterId" : [NSString stringWithFormat:@"%d", theaterId], @"SessionId" : [NSString stringWithFormat:@"%d", sessionId], @"MovieId" : movieId, @"Tickets" : [NSArray arrayWithArray:ticketsArray]};
        [_WSC requestType:requestType ifParams:YES params:sessionToCreate withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"createUser -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// UserSessionServices.svc/Confirmation/
-(void)comfirmUserSessionWithThisId:(NSString *)userSessionId withSeats:(NSMutableArray *)seatsArray{
    if(userSessionId && ![seatsArray isEqual:nil] && [seatsArray count]>0){
        NSString *requestType = @"POST";
        NSInteger timeout = 120.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@/", self.URIstring, @"Confirmation"];
        NSDictionary *sessionToConfirm = @{@"Seats" : [NSMutableArray arrayWithArray:seatsArray], @"UserSessionId" : [NSString stringWithFormat:@"%@", userSessionId]};
        [_WSC requestType:requestType ifParams:YES params:sessionToConfirm withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"confirmUserSession -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// UserSessionServices.svc/Payment/
-(void)paymentInfo:(NSDictionary *)paymentObject{
    if([paymentObject count]>0){
        NSString *requestType = @"POST";
        NSInteger timeout = 120.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@/", self.URIstring, @"Payment"];
        //NSDictionary *sessionToConfirm = @{@"Seats" : [NSMutableArray arrayWithArray:seatsArray], @"UserSessionId" : [NSString stringWithFormat:@"%@", userSessionId]};
        [_WSC requestType:requestType ifParams:YES params:paymentObject withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"paymentInfo -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// UserSessionServices.svc/userSessionId/true
-(void)readUserReservationWithUserSessionId: (NSString *) userSessionId{
    if([userSessionId length]>=36){
    NSString *requestType = @"GET";
    NSInteger timeout = 120.0;
    NSString *auxURI = [NSString stringWithFormat:@"%@%@/%@", self.URIstring, userSessionId, @"true"];
    [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"readUserReservation -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// UserSessionServices.svc/ValidateGiftCard/true
-(void)getGiftCardBalanceWithNumber: (NSString *) giftCardNumber{
    if([giftCardNumber length]>=15){
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@?%@=%@", self.URIstring, @"ValidateGiftCard", @"GiftCard", giftCardNumber];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"getgiftCardBalance -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// UserSessionServices.svc/UnsubscribePost/
-(void)unsubscribeUserFromPostWithID: (NSString *)userGUID andWithEmail: (NSString *)eMail{
    if([userGUID length]>=36 && [MeaningAndFormValidation NSStringIsValidEmail:eMail classReferenced:(NSString *)[self class]]){
        NSString *requestType = @"POST";
        NSInteger timeout = 120.0;
        NSString *auxURI = [NSString stringWithFormat:@"%@%@/", self.URIstring, @"UnsubscribePost"];
        NSDictionary *userToUnsubscribe = @{@"Id" : userGUID, @"Email" : eMail};
        [_WSC requestType:requestType ifParams:YES params:userToUnsubscribe withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"unsubscribeUserFromPost -> Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}


@end
