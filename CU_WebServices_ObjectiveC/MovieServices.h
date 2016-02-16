//
//  MovieServices.h
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServicesConnection.h"
#import "MeaningAndFormValidation.h"

@interface MovieServices : NSObject
-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC;
-(void)getAllMoviesByThisCity: (NSString *) city;
-(void)getAllMoviesByThisCity:(NSString *)city forThisDay:(int)day andThisMonth:(int)month;
-(void)getAllFromMovieByThisCity:(NSString *)city withThisMovieId:(NSString *)movieId;
-(void)getAllFromMovieByThisCity:(NSString *)city withThisMovieId:(NSString *)movieId forThisDay:(int)date andThisMonth:(int)month;
-(void)getMovieSlidersForThisCity: (NSString *) city;
-(void)getBarMoviesForThisCity: (NSString *) city;
-(void)getMoreMoviesForThisCity: (NSString *) city;
@end
