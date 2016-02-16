//
//  WebServicesConnection.h
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TheaterServices.h"
#import "MovieServices.h"
#import "SecurityServices.h"
#import "PremierServices.h"
#import "ContactServices.h"
#import "UsersessionServices.h"
@class WebServicesConnection;
@protocol webServiceDidRecieveResponseDelegate <NSObject>
-(void) webServiceReceivedResponse:(NSMutableDictionary *)response;
@end

@interface WebServicesConnection : NSObject

@property (nonatomic, weak) id<webServiceDidRecieveResponseDelegate> webServiceReceivedResponseDelegate;
@property (nonatomic, strong) NSString *goToEnviroment;

-(id)getServiceObjectFromGroup:(NSString *)group;

-(void)requestType:(NSString *)requestType
          ifParams:(Boolean) ifParams
            params:(NSDictionary *) params
       withTimeout:(NSInteger) timeout
             inURL:(NSString *)URLstring
        nestedCall:(BOOL) nestedCall
    nestedCallType:(int) nestedCallType
  URLforNestedCall:(NSString *)URLforNestedCall
nestedCallRequestType:(NSString *)nestedRequestType
nestedCallWithTimeout:(NSInteger) nestedTimeout
nestedCallIfParams:(Boolean) nestedIfParams
paramsForNestedCall:(NSDictionary *) paramsForNestedCall;

@end
