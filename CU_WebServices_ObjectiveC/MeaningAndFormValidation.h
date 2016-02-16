//
//  MeaningAndFormValidation.h
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/14/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServicesConnection.h"

@interface MeaningAndFormValidation : NSObject
+(BOOL)monthInBetweenPropperValues:(int)month classReferenced: (NSString *) className;
+(BOOL)dateInBetweenPropperValues:(int)date classReferenced: (NSString *) className;
+(BOOL)theaterInBetweenPropperValues:(int)theaterId ifValidEnviroment:(NSString *)enviroment  classReferenced: (NSString *) className;
+(void)printErrorWithText:(NSString *)error inClass:(NSString *)className;
+(NSString *)stringFromDictionary:(NSDictionary *)params  classReferenced: (NSString *) className;
+(BOOL)checkAllMandatoryInDictionary:(NSDictionary *)params;
+(BOOL)checkCityExistance:(NSString *)city classReferenced:(NSString *)className;
+(BOOL)checkMovieId:(NSString *)movieId classReferenced:(NSString *)className;
+(BOOL)NSStringIsValidEmail:(NSString *)checkString classReferenced:(NSString *)className;
+(BOOL)validatePlatform:(NSString *)platform classReferenced:(NSString *)className;
+(BOOL)yearInBetweenPropperValues:(int)year  classReferenced: (NSString *) className;
+(BOOL)validateIdCardFormat:(NSString *)idCard  classReferenced: (NSString *) className;

@end
