//
//  MainServicesView.h
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServicesConnection.h"
#import "TheaterServices.h"
#import "MovieServices.h"
#import "SecurityServices.h"
#import "PremierServices.h"
#import "ContactServices.h"
#import "UsersessionServices.h"
#import "AppDelegate.h"

@interface MainServicesViewController : UIViewController <webServiceDidRecieveResponseDelegate>

@end
