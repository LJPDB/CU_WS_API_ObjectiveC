//
//  PremierServices.m
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import "PremierServices.h"
@interface PremierServices()
@property (nonatomic, strong) NSString *URIstring;
@property (nonatomic, strong) WebServicesConnection *WSC;
@end
@implementation PremierServices

-(void)testMethod{
    NSLog(@"Test method print, %@", _URIstring);
}
-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC{
    _URIstring = URIstring;
    _WSC = WSC;
}

// Premier.svc/
-(void)getAllPremierMovies: (NSDictionary *) params{
    Boolean withParams = params ? YES : NO;
    NSString *requestType = @"GET";
    NSInteger timeout = 80.0;
    [_WSC requestType:requestType ifParams:withParams params:params withTimeout:timeout inURL:_URIstring nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
}


@end
