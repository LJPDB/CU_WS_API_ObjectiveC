//
//  PremierServices.h
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServicesConnection.h"

@interface PremierServices : NSObject
-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC;
-(void)getAllPremierMovies: (NSDictionary *) params;

@end
