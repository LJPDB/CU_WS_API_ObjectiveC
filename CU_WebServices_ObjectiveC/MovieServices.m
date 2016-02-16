//
//  MovieServices.m
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import "MovieServices.h"


@interface MovieServices()
@property (nonatomic, strong) NSString *URIstring;
@property (nonatomic, strong) WebServicesConnection *WSC;
@end

@implementation MovieServices

-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC{
    _URIstring = URIstring;
    _WSC = WSC;
}

//  Movie.svc/cityName
-(void)getAllMoviesByThisCity: (NSString *) city{
    if ([MeaningAndFormValidation checkCityExistance:city classReferenced:(NSString *)[self class]]) {
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@", self.URIstring, city];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }
}

// Movie.svc/cityName/day/month
-(void)getAllMoviesByThisCity:(NSString *)city forThisDay:(int)date andThisMonth:(int)month{
    if(city && date && month){
        BOOL validCity = [MeaningAndFormValidation checkCityExistance:city classReferenced: (NSString *)[self class]];
        BOOL validDate = [MeaningAndFormValidation dateInBetweenPropperValues:date classReferenced: (NSString *)[self class]];
        BOOL validMonth = [MeaningAndFormValidation monthInBetweenPropperValues:month classReferenced: (NSString *)[self class]];
        if (validDate && validMonth && validCity) {
            NSString *requestType = @"GET";
            NSInteger timeout = 80.0;
            NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/%d/%d", self.URIstring, city, date, month];
            [_WSC requestType:requestType ifParams:NO params: nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
        }
    }else{
        [MeaningAndFormValidation printErrorWithText:@"Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Movie.svc/cityName/movieId
-(void)getAllFromMovieByThisCity:(NSString *)city withThisMovieId:(NSString *)movieId{
    if(city && movieId){
        BOOL validCity = [MeaningAndFormValidation checkCityExistance:city classReferenced: (NSString *)[self class]];
        BOOL validMovieId = [MeaningAndFormValidation checkMovieId:movieId classReferenced:(NSString *)[self class]];
        if (validMovieId && validCity) {
            NSString *requestType = @"GET";
            NSInteger timeout = 80.0;
            NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/%@", self.URIstring, city, movieId];
            [_WSC requestType:requestType ifParams:NO params: nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
        }
    }else{
        [MeaningAndFormValidation printErrorWithText:@"Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

// Movie.svc/cityName/movieId/day/month
-(void)getAllFromMovieByThisCity:(NSString *)city withThisMovieId:(NSString *)movieId forThisDay:(int)date andThisMonth:(int)month{
    if(city && date && month && movieId){
        BOOL validCity = [MeaningAndFormValidation checkCityExistance:city classReferenced: (NSString *)[self class]];
        BOOL validDate = [MeaningAndFormValidation dateInBetweenPropperValues:date classReferenced: (NSString *)[self class]];
        BOOL validMonth = [MeaningAndFormValidation monthInBetweenPropperValues:month classReferenced: (NSString *)[self class]];
        BOOL validMovieId = [MeaningAndFormValidation checkMovieId:movieId classReferenced:(NSString *)[self class]];
        if (validDate && validMonth && validCity && validMovieId) {
            NSString *requestType = @"GET";
            NSInteger timeout = 80.0;
            NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/%@/%d/%d", self.URIstring, city, movieId, date, month];
            [_WSC requestType:requestType ifParams:NO params: nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
        }
    }else{
        [MeaningAndFormValidation printErrorWithText:@"Wrong params passed through.!" inClass:(NSString *)[self class]];
    }
}

//  Movie.svc/Slider/cityName
-(void)getMovieSlidersForThisCity: (NSString *) city{
    if ([MeaningAndFormValidation checkCityExistance:city classReferenced:(NSString *)[self class]]) {
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/%@", self.URIstring, @"Slider", city];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }
}

//  Movie.svc/Bar/cityName
-(void)getBarMoviesForThisCity: (NSString *) city{
    if ([MeaningAndFormValidation checkCityExistance:city classReferenced:(NSString *)[self class]]) {
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/%@", self.URIstring, @"Bar", city];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }
}

//  Movie.svc/MoreMovie/cityName
-(void)getMoreMoviesForThisCity: (NSString *) city{
    if ([MeaningAndFormValidation checkCityExistance:city classReferenced:(NSString *)[self class]]) {
        NSString *requestType = @"GET";
        NSInteger timeout = 80.0;
        NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/%@", self.URIstring, @"MoreMovie", city];
        [_WSC requestType:requestType ifParams:NO params:nil withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
    }
}


@end
