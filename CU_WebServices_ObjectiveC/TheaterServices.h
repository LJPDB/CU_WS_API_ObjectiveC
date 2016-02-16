//
//  TheaterServices.h
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeaningAndFormValidation.h"

@interface TheaterServices  : NSObject

-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC;
-(void)getAllTheaters: (NSDictionary *) params;
-(void)getTheaterById:(int)theaterId;
-(void)getAllById:(int)theaterId byDate:(int)date andByMonth:(int)month;
-(void)getAllAvailableCities: (NSDictionary *) params;
-(void)getAllByThisCity: (NSString *) city;
-(void)getAllByThisCity:(NSString *)city byDate:(int)date andByMonth:(int)month;
-(void)getSessionByTheaterId:(int)theaterId withSessionId:(int)sessionId;
@end
