 //
//  WebServicesConnection.m
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import "WebServicesConnection.h"

@interface WebServicesConnection ()

@property (nonatomic, strong) NSMutableString *URI;
@property (nonatomic, strong) NSMutableDictionary *enviromentServer;
@property (nonatomic, strong) NSMutableArray *justServicesKeys;
@property (nonatomic, strong) NSMutableDictionary *singleServiceObjects;
@property (nonatomic, strong) NSMutableDictionary *groupServicesType;
@property (nonatomic, strong) NSMutableDictionary *webServicesPref;
@property (nonatomic) Boolean iOSbellowNine;
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSMutableDictionary *JSONparsed;

@end


@implementation WebServicesConnection

-(id) init{   
    if (self) {
        self = [super init];
        self.clientID = @"111.111.111.120";
        self.goToEnviroment = @"Dev";
        self.webServicesPref =  [[NSMutableDictionary alloc] initWithDictionary: @{ @"theater" : @"/Theater.svc/",
                                                                                    @"movie" : @"/Movie.svc/",
                                                                                    @"security" : @"/Security.svc/",
                                                                                    @"premier" : @"/Premier.svc/",
                                                                                    @"contact" : @"/Contact.svc/",
                                                                                    @"usersession" : @"/UserSessionServices.svc/" }];
        self.enviromentServer = [[NSMutableDictionary alloc] initWithDictionary:@{ @"Dev" : @"http://cu-dev-wcf-services.cloudapp.net",
                                                                                   @"Prod" : @"http://23.102.188.6" }];
        self.groupServicesType = [[NSMutableDictionary alloc] initWithDictionary:@{ @"theater" : @0,
                                                                                    @"movie" : @1,
                                                                                    @"security" : @2,
                                                                                    @"premier" : @3,
                                                                                    @"contact" : @4,
                                                                                    @"usersession" : @5 }];
        self.justServicesKeys = [[NSMutableArray alloc] initWithArray: [self.groupServicesType allKeys]];
        self.URI = [[NSMutableString alloc] init];
        self.singleServiceObjects = [[NSMutableDictionary alloc] init];
        [self.URI setString:[self.enviromentServer  valueForKey: self.goToEnviroment]];
        
        NSInteger i = 0;
        NSMutableString *classNameReady = [[NSMutableString alloc] init];
        for (NSString *key in self.justServicesKeys) {
            [classNameReady setString: [NSString stringWithFormat:@"%@%@", [key capitalizedString], @"Services"]];
            [self.singleServiceObjects setValue:[[NSClassFromString(classNameReady) alloc] init] forKey: [NSString stringWithFormat:@"%@", [self.groupServicesType valueForKey:key]]];
            i++;
            [classNameReady setString: @""];
        }
        NSLog(@"WebService Objects: %@", self.singleServiceObjects);
        
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_8_3) {
            _iOSbellowNine = NO;
        } else {
            _iOSbellowNine = YES;
        }
    }
    return self;
}

#pragma mark - Get back a specific web service kind of an object (Theater, Premier, Movie......etc)
-(id)getServiceObjectFromGroup:(NSString *)group{
    NSNumber *valueForGroupSwitch = [self.groupServicesType valueForKey:[group lowercaseString]];
    if (!valueForGroupSwitch) {
        [MeaningAndFormValidation printErrorWithText:@" getServiceObjectFromGroup: Wrong name for ServiceGroup, please check your 'getServiceObjectFromGroup' argument." inClass:(NSString *)[self class]];
        return nil;
    } else {
        id tempObj = [self.singleServiceObjects valueForKey:[NSString stringWithFormat:@"%@", valueForGroupSwitch]];
        [tempObj setURIstring:[self.URI stringByAppendingString:[self.webServicesPref valueForKey:[group lowercaseString]]] andSetWSC:self];
        return tempObj;
    }
}


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
paramsForNestedCall:(NSDictionary *) paramsForNestedCall{
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
    //NSString *URLwithCharacters = [URLstring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: URLstring] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];
    [request    setHTTPMethod:requestType];
    //for sending data
    if (ifParams) {
        NSError *error;
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
        //[request setHTTPBody:[NSData dataWithBytes:[params UTF8String] length:strlen([params UTF8String])]];
        [request setHTTPBody:postData];
    }
    //to accept data
    [request  setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Accept"];
    [request  setValue:_clientID forHTTPHeaderField:@"ClientID"];
    
    //NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //__block NSMutableDictionary * JSONparsed = [[NSMutableDictionary alloc] init];
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_8_3) {
        [NSURLConnection sendAsynchronousRequest: request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
            if ([data length] > 0 && connectionError == nil) {
                NSLog(@"Response from service: %@", response);
                NSError *JSONerror = nil;
                //id responseParsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
                NSDictionary *JSONinDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
                
                if (!nestedCall) {
                    if (!JSONerror) {
                        _JSONparsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
                        [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                        NSLog(@"Response parsed to JSON: %@", JSONinDictionary);
                    }else{
                        NSString *auxReceiver = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                        _JSONparsed = [NSMutableDictionary dictionaryWithDictionary:@{ @"Response" : [auxReceiver stringByReplacingOccurrencesOfString:@"\"" withString:@""] }];
                        NSLog(@"JSON bad formed and transformed to somenthing meaningful for the app: %@", _JSONparsed);
                        [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                    }
                } else {
                    if (!JSONerror) {
                        NSMutableDictionary *auxDictionaryToSend = [[NSMutableDictionary alloc] init];
                        switch (nestedCallType) {
                            case 0:
                                // UpdateUser
                                //aqui hacer el seteo de los nuevos valores
                                [auxDictionaryToSend setDictionary:JSONinDictionary];
                                for (NSString *key in paramsForNestedCall) {
                                    [auxDictionaryToSend setValue:[paramsForNestedCall valueForKey:key] forKey:key];
                                }
                                [self OLDmakeNestedCallWithURL:URLforNestedCall andWithParams:auxDictionaryToSend nestedCallWithTimeout:nestedTimeout nestedCallIfParams:nestedIfParams nestedCallRequestType:nestedRequestType];
                                break;
                                
                            default:
                                NSLog(@"Bad parameter to request a nestedCall");
                                break;
                        }
                        //[self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                        NSLog(@"Response parsed to JSON: %@", JSONinDictionary);
                    }else{
                        //NSString *auxReceiver = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                        //_JSONparsed = [NSMutableDictionary dictionaryWithDictionary:@{ @"Response" : auxReceiver }];
                        NSLog(@"JSON bad formed and transformed to somenthing meaningful for the app:");
                        //[self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                    }
                }
                
                
            } else if ([data length] == 0 && connectionError ==nil) {
                NSLog(@"Nothing back in Response from service");
            }else if ( connectionError != nil && connectionError.code == ECONNABORTED) {
                NSLog(@"Fail to connect before Timeout!");
            }else if (connectionError != nil){
                NSLog(@"Error: %@", connectionError);
            }
        }];
    }else{
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithRequest:(NSURLRequest *) request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError){
            if ([data length] > 0 && connectionError == nil) {
                NSLog(@"Response from service: %@", response);
                NSError *JSONerror = nil;
                //id responseParsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
                NSDictionary *JSONinDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
                if (!nestedCall) {
                    if (!JSONerror) {
                        _JSONparsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
                        [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                        NSLog(@"Response parsed to JSON: %@", JSONinDictionary);
                    }else{
                        NSString *auxReceiver = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                        _JSONparsed = [NSMutableDictionary dictionaryWithDictionary:@{ @"Response" : [auxReceiver stringByReplacingOccurrencesOfString:@"\"" withString:@""] }];
                        NSLog(@"JSON bad formed and transformed to somenthing meaningful for the app: %@", _JSONparsed);
                        [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                    }
                } else {
                    if (!JSONerror) {
                        NSMutableDictionary *auxDictionaryToSend = [[NSMutableDictionary alloc] init];
                        switch (nestedCallType) {
                            case 0:
                                // UpdateUser
                                //aqui hacer el seteo de los nuevos valores
                                [auxDictionaryToSend setDictionary:JSONinDictionary];
                                for (NSString *key in paramsForNestedCall) {
                                    [auxDictionaryToSend setValue:[paramsForNestedCall valueForKey:key] forKey:key];
                                }                                
                                [self makeNestedCallWithURL:URLforNestedCall andWithParams:auxDictionaryToSend nestedCallWithTimeout:nestedTimeout nestedCallIfParams:nestedIfParams nestedCallRequestType:nestedRequestType];
                                break;
                                
                            default:
                                NSLog(@"Bad parameter to request a NestedCall");
                                break;
                        }
                        //[self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                        NSLog(@"Response parsed to JSON: %@", JSONinDictionary);
                    }else{
                        //NSString *auxReceiver = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                        //_JSONparsed = [NSMutableDictionary dictionaryWithDictionary:@{ @"Response" : auxReceiver }];
                        NSLog(@"JSON bad formed and transformed to somenthing meaningful for the app:");
                        //[self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                    }
                }
            } else if ([data length] == 0 && connectionError ==nil) {
                NSLog(@"Nothing back in Response from service");
            }else if ( connectionError != nil && connectionError.code == ECONNABORTED) {
                NSLog(@"Fail to connect before Timeout!");
            }else if (connectionError != nil){
                NSLog(@"Error: %@", connectionError);
            }
        }]resume];
    }
    //return _JSONparsed;
    });
}

-(void)makeNestedCallWithURL:(NSString *)NestedURL andWithParams:(NSDictionary *)nestedParams nestedCallWithTimeout:(NSInteger) timeout nestedCallIfParams:(Boolean) ifParams nestedCallRequestType:(NSString *)requestType{  //iOS version > 8.3
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: NestedURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];
    [request    setHTTPMethod:requestType];
    //for sending data
    if (ifParams) {
        NSError *error;
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        NSData *postData = [NSJSONSerialization dataWithJSONObject:nestedParams options:0 error:&error];
        //[request setHTTPBody:[NSData dataWithBytes:[params UTF8String] length:strlen([params UTF8String])]];
        [request setHTTPBody:postData];
    }
    //to accept data
    [request  setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Accept"];
    NSURLSession *NestedSession = [NSURLSession sharedSession];
    [[NestedSession dataTaskWithRequest:(NSURLRequest *) request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError){
        if ([data length] > 0 && connectionError == nil) {
            NSLog(@"Response from NESTED service: %@", response);
            NSError *JSONerror = nil;
            //id responseParsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
            NSDictionary *JSONinDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
            if (!JSONerror) {
                _JSONparsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
                [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                NSLog(@"NESTED Response parsed to JSON: %@", JSONinDictionary);
            }else{
                NSString *auxReceiver = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                _JSONparsed = [NSMutableDictionary dictionaryWithDictionary:@{ @"NESTED Response" : auxReceiver }];
                NSLog(@"NESTED JSON bad formed and transformed to somenthing meaningful for the app: %@", _JSONparsed);
                [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
            }
 
        } else if ([data length] == 0 && connectionError ==nil) {
            NSLog(@"Nothing back in Response from NESTED service");
        }else if ( connectionError != nil && connectionError.code == ECONNABORTED) {
            NSLog(@"Fail to NESTED connect before Timeout!");
        }else if (connectionError != nil){
            NSLog(@"NESTED Error: %@", connectionError);
        }
    }]resume];
}

-(void)OLDmakeNestedCallWithURL:(NSString *)NestedURL andWithParams:(NSDictionary *)nestedParams nestedCallWithTimeout:(NSInteger) timeout nestedCallIfParams:(Boolean) ifParams nestedCallRequestType:(NSString *)requestType{  //iOS version < 8.3
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: NestedURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];
    [request    setHTTPMethod:requestType];
    //for sending data
    if (ifParams) {
        NSError *error;
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        NSData *postData = [NSJSONSerialization dataWithJSONObject:nestedParams options:0 error:&error];
        //[request setHTTPBody:[NSData dataWithBytes:[params UTF8String] length:strlen([params UTF8String])]];
        [request setHTTPBody:postData];
    }
    //to accept data
    [request  setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Accept"];
    [NSURLConnection sendAsynchronousRequest: request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if ([data length] > 0 && connectionError == nil) {
            NSLog(@"Response from NESTED service: %@", response);
            NSError *JSONerror = nil;
            //id responseParsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
            NSDictionary *JSONinDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
            if (!JSONerror) {
                _JSONparsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONerror];
                [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
                NSLog(@"NESTED Response parsed to JSON: %@", JSONinDictionary);
            }else{
                NSString *auxReceiver = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                _JSONparsed = [NSMutableDictionary dictionaryWithDictionary:@{ @"NESTED Response" : auxReceiver }];
                NSLog(@"NESTED JSON bad formed and transformed to somenthing meaningful for the app: %@", _JSONparsed);
                [self.webServiceReceivedResponseDelegate webServiceReceivedResponse:_JSONparsed];
            }
        } else if ([data length] == 0 && connectionError ==nil) {
            NSLog(@"Nothing back in Response from NESTED service");
        }else if ( connectionError != nil && connectionError.code == ECONNABORTED) {
            NSLog(@"Fail to NESTED connect before Timeout!");
        }else if (connectionError != nil){
            NSLog(@"NESTED Error: %@", connectionError);
        }
    }];
}

@end
