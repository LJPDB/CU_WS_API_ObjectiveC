//
//  TheaterServices.m
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import "TheaterServices.h"
#import "WebServicesConnection.h"

@interface TheaterServices()
@property (nonatomic, strong) NSString *URIstring;
@property (nonatomic, strong) WebServicesConnection *WSC;
@end

@implementation TheaterServices

-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC{
    _URIstring = URIstring;
    _WSC = WSC;
}


//  Theater.svc/
-(void)getAllTheaters: (NSDictionary *) params{
    Boolean withParams = params ? YES : NO;
    NSString *requestType = @"GET";
    NSInteger timeout = 80.0;
    [_WSC requestType:requestType ifParams:withParams params:params withTimeout:timeout inURL:_URIstring nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
}

//  Theater.svc/theaterId
-(void)getTheaterById:(int)theaterId{
  //  Boolean withParams = params ? YES : NO;
    Boolean withDictionaryParams = ([MeaningAndFormValidation theaterInBetweenPropperValues:theaterId ifValidEnviroment:self.WSC.goToEnviroment  classReferenced: (NSString *)[self class]]) ? YES : NO;
    NSString *requestType = @"GET";
    NSInteger timeout = 80.0;
    NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%d", self.URIstring, theaterId];
    if (withDictionaryParams) {
                        [_WSC requestType:requestType ifParams:NO params: nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }else{
        [MeaningAndFormValidation printErrorWithText:@"No params or bad 'theaterId' passed through.!" inClass:(NSString *)[self class]];
    }
}

//  Theater.svc/theaterId/day/month
-(void)getAllById:(int)theaterId byDate:(int)date andByMonth:(int)month{
    if(theaterId && date && month){
        BOOL validTheaterId = [MeaningAndFormValidation theaterInBetweenPropperValues:theaterId ifValidEnviroment:self.WSC.goToEnviroment classReferenced: (NSString *)[self class]];
        BOOL validDate = [MeaningAndFormValidation dateInBetweenPropperValues:date classReferenced: (NSString *)[self class]];
        BOOL validMonth = [MeaningAndFormValidation monthInBetweenPropperValues:month classReferenced: (NSString *)[self class]];
        if (validDate && validMonth && validTheaterId) {
            NSString *requestType = @"GET";
            NSInteger timeout = 80.0;
            NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%d/%d/%d", self.URIstring, theaterId, date, month];
            [_WSC requestType:requestType ifParams:NO params: nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
        }
    }else{
        [MeaningAndFormValidation printErrorWithText:@"Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

//  Theater.svc/City/
-(void)getAllAvailableCities: (NSDictionary *) params{
    Boolean withParams = params ? YES : NO;
    NSString *requestType = @"GET";
    NSInteger timeout = 80.0;
    NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/", self.URIstring, @"City"];
    [_WSC requestType:requestType ifParams:withParams params:params withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
}

//  Theater.svc/City/cityName
-(void)getAllByThisCity: (NSString *) city{
    if ([MeaningAndFormValidation checkCityExistance:city classReferenced:(NSString *)[self class]]) {
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/%@", self.URIstring, @"City",city];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    } else {
        [MeaningAndFormValidation printErrorWithText:@"City name not valid" inClass:(NSString *)[self class]];
    }
    
}

//  Theater.svc/City/cityName/day/month
-(void)getAllByThisCity:(NSString *)city byDate:(int)date andByMonth:(int)month{
    if(city && date && month){
        BOOL validCity = [MeaningAndFormValidation checkCityExistance:city classReferenced: (NSString *)[self class]];
        BOOL validDate = [MeaningAndFormValidation dateInBetweenPropperValues:date classReferenced: (NSString *)[self class]];
        BOOL validMonth = [MeaningAndFormValidation monthInBetweenPropperValues:month classReferenced: (NSString *)[self class]];
        if (validDate && validMonth && validCity) {
            NSString *requestType = @"GET";
            NSInteger timeout = 80.0;
            NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/%@/%d/%d", self.URIstring, @"City", city, date, month];
            [_WSC requestType:requestType ifParams:NO params: nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
        }
    }else{
        [MeaningAndFormValidation printErrorWithText:@"Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

//  Theater.svc/Session/theaterId/sessionId
-(void)getSessionByTheaterId:(int)theaterId withSessionId:(int)sessionId{
    if(theaterId && sessionId){
        BOOL validTheaterId = [MeaningAndFormValidation theaterInBetweenPropperValues:theaterId ifValidEnviroment:self.WSC.goToEnviroment classReferenced: (NSString *)[self class]];
        if (validTheaterId) {
            NSString *requestType = @"GET";
            NSInteger timeout = 80.0;
            NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/%d/%d", self.URIstring, @"Session", theaterId, sessionId];
            [_WSC requestType:requestType ifParams:NO params: nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
        }
    }else{
        [MeaningAndFormValidation printErrorWithText:@"Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}


 
@end
