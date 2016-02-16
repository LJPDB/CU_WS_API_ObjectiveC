//
//  MeaningAndFormValidation.m
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/14/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import "MeaningAndFormValidation.h"

@implementation MeaningAndFormValidation

#pragma Mark - Parse NSDictionary to JSONString
+(NSString *)stringFromDictionary:(NSDictionary *)params  classReferenced: (NSString *) className{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString;
    
    if (! jsonData) {
        [self printErrorWithText:[NSString stringWithFormat:@"JSON Data Serialization got an error: %@", error] inClass:className];
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

#pragma Mark - Print error and TheaterId validations
+(void)printErrorWithText:(NSString *)error inClass:(NSString *)className{
    NSLog(@"%@ : %@", className, error);
}
+(BOOL)theaterInBetweenPropperValues:(int)theaterId ifValidEnviroment:(NSString *)enviroment classReferenced: (NSString *) className{
    if ((theaterId>1000)&&(theaterId<1029)) {
        if (theaterId==1028) {
            if ([enviroment isEqualToString:@"Dev"]) {
                return YES;
            }else{
                [self printErrorWithText:@"'theaterId' not valid in this enviroment" inClass:className];
                return NO;
            }
        }
        return YES;
    }else{
        [self printErrorWithText:@"Wrong 'theaterId' value" inClass:className];
        return NO;
    }
}
+(BOOL)dateInBetweenPropperValues:(int)date classReferenced: (NSString *) className{
    if ((date>0)&&(date<32)) {
        return YES;
    }else{
        [self printErrorWithText:@"Wrong 'date' value" inClass:className];
        return NO;
    }
}
+(BOOL)monthInBetweenPropperValues:(int)month  classReferenced: (NSString *) className{
    if ((month>0)&&(month<13)) {
        return YES;
    }else{
        [self printErrorWithText:@"Wrong 'month' value" inClass:className];
        return NO;
    }
}
+(BOOL)checkAllMandatoryInDictionary:(NSDictionary *)params{
    BOOL itsOk = YES;
    for (NSString *key in params) {
        id value = [params valueForKey:key];
        if ([value isEqualToString:@""] || [value isEqual:nil]) {
            itsOk = NO;
        }
    }
    return itsOk;
}

+(BOOL)checkCityExistance:(NSString *)city  classReferenced:(NSString *)className{
    NSArray *cityArray =  @[@"Barquisimeto",
                                         @"Caracas",
                                         @"Guatire",
                                         @"Maracaibo",
                                         @"Maracay",
                                         @"Margarita",
                                         @"Maturin",
                                         @"Puerto La Cruz",
                                         @"Puerto Ordaz",
                                         @"San Cristobal",
                                         @"Valencia"];
    if (![cityArray containsObject:city]) {
        [self printErrorWithText:@"City not valid. City most be one of the listed." inClass:className];
    }
    return [cityArray containsObject:city];
}

+(BOOL)checkMovieId:(NSString *)movieId classReferenced:(NSString *)className{
    int movieIdLength = [movieId length];
    BOOL movieIdRightFormat = NO;
    if (movieIdLength==10) {
        NSString *prefToCheckFourO = [movieId substringToIndex:6];
        NSString *prefToCheckThreeO = [movieId substringToIndex:5];
        if ([prefToCheckFourO isEqualToString:@"HO0000"]||[prefToCheckThreeO isEqualToString:@"HO000"]) {
            movieIdRightFormat = YES;
        } else {
            [self printErrorWithText:@"MovieId has bad format ('HO0000' format), please check the 'HO' movie code." inClass:className];
        }
    } else {
        [self printErrorWithText:@"MovieId has bad format (Id length), please check the 'HO' movie code." inClass:className];
    }
    return movieIdRightFormat;
}

+(BOOL) NSStringIsValidEmail:(NSString *)checkString classReferenced:(NSString *)className
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL validEmail = [emailTest evaluateWithObject:checkString];
    if (!validEmail) {
        [self printErrorWithText:@"Bad eMail format, please all eMail string and domain." inClass:className];
    }
    return validEmail;
}

+(BOOL) validatePlatform:(NSString *)platform classReferenced:(NSString *)className
{
    BOOL validPlatform = NO;
    NSArray *platforms = @[@"Web",@"Mobile"];
    validPlatform = [platforms containsObject:platform];
    if (!validPlatform) {
        [self printErrorWithText:@"Invalid platform....Values most be one of the listed ones (Web/Mobile)." inClass:className];
    }
    return validPlatform;
}

+(BOOL)yearInBetweenPropperValues:(int)year  classReferenced: (NSString *) className{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int actualYear = [[formatter stringFromDate:[NSDate date]] intValue];
    if ((year>(actualYear - 90))&&(year<(actualYear - 18))) {
        return YES;
    }else{
        [self printErrorWithText:@"Wrong 'year' value" inClass:className];
        return NO;
    }
}


+(BOOL)validateIdCardFormat:(NSString *)idCard  classReferenced: (NSString *) className{
    NSString *trimmedidCard = [idCard stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (idCard && ![trimmedidCard isEqualToString:@""]) {
        NSString *prefV = [idCard substringToIndex:1];
        NSString *IdNumber = [idCard substringFromIndex:1];
        NSInteger idCardIntValue = [IdNumber integerValue];
        NSString *testBack = [NSString stringWithFormat:@"%ld", (long)idCardIntValue];
        if ([prefV isEqualToString:@"V"] && [IdNumber isEqualToString:testBack]) {
            return YES;
        }else{
            [self printErrorWithText:@"Wrong 'IdCard' value. Must has 'V' as prefix and then the id number ('V234122')." inClass:className];
            return NO;
        }

    } else {
        [self printErrorWithText:@"'IdCard' value is null or empty. Must has 'V' as prefix and then the id number ('V234122')." inClass:className];
        return NO;
    }
}


@end
