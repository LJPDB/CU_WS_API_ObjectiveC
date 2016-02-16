//
//  UsersessionServices.h
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServicesConnection.h"

@interface UsersessionServices : NSObject
-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC;
-(void)createUserSessionInTheater:(int)theaterId withSession:(int)sessionId forMovie:(NSString *)movieId withTickets:(NSArray *)ticketsArray;
-(void)comfirmUserSessionWithThisId:(NSString *)userSessionId withSeats:(NSMutableArray *)seatsArray;
-(void)paymentInfo:(NSDictionary *)paymentObject;
-(void)readUserReservationWithUserSessionId: (NSString *) userSessionId;
-(void)getGiftCardBalanceWithNumber: (NSString *) giftCardNumber;
-(void)unsubscribeUserFromPostWithID: (NSString *)userGUID andWithEmail: (NSString *)eMail;
@end
