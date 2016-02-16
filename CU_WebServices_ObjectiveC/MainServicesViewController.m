//
//  MainServicesView.m
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import "MainServicesViewController.h"


@interface MainServicesViewController ()

@property (nonatomic, strong) WebServicesConnection *WSC;
@property (nonatomic, strong) NSMutableDictionary *allTheaters;

@end

@implementation MainServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegateAUX =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.WSC = [appDelegateAUX WSC];
    _WSC.webServiceReceivedResponseDelegate = self;
    
    //          Premier Methods
    PremierServices *premierSO = [self.WSC getServiceObjectFromGroup:@"premier"];
    //[premierSO getAllPremierMovies:nil];
    //****************************************//
    
    //          Theaters Methods
    TheaterServices *theaterSO = [self.WSC getServiceObjectFromGroup:@"theater"];
    //[theaterSO getAllTheaters:nil];
    //[theaterSO getTheaterById:1008];
    //[theaterSO getAllById:1008 byDate:12 andByMonth:3];
    //[theaterSO getAllAvailableCities:nil];
    //[theaterSO getAllByThisCity:@"Caracas"];
    //[theaterSO getAllByThisCity:@"Barquisimeto" byDate:12 andByMonth:5];
    //[theaterSO getSessionByTheaterId:1007 withSessionId:266141]; //here you can take tickets type given a theater and session ids! then you can use this tickets type to arrange your Create method parameters for UserSession
    //***************************************//
    
    //          Movie Methods
    MovieServices *movieSO = [self.WSC getServiceObjectFromGroup:@"movie"];
    //[movieSO getAllMoviesByThisCity:@"Maturin"];
    //[movieSO getAllMoviesByThisCity:@"Maturin" forThisDay:18 andThisMonth:12];
    //[movieSO getMovieByThisCity:@"Maturin" withThisMovieId:@"HO00003016"];
    //[movieSO getAllFromMovieByThisCity:@"Maturin" withThisMovieId:@"HO00003016" forThisDay:15 andThisMonth:12];
    //[movieSO getMovieSlidersForThisCity:@"Maturin"];
    //[movieSO getBarMoviesForThisCity:@"Maturin"];
    //[movieSO getMoreMoviesForThisCity:@"Maturin"];
    //***************************************//
    
    //          Security Methods
    SecurityServices *securitySO = [self.WSC getServiceObjectFromGroup:@"security"];
    //[securitySO signinUserWithEmail:@"ing.ljpdb@gmail.com" andWithPassword:@"Qwerty01" fromThisPlatform:@"Mobile" andThisURL:nil];
    //[securitySO signoutUserWithToken:@"VjrCrTMPpb221/h/QwAITg=="];
    //[securitySO isUserValidWithToken:@"VjrCrTMPpb221/h/QwAITg=="]; //7B372887-96A5-4BE3-8020-DAAAB94FB215   //dYLpvd7qkqlk+TcEWtEDGQ==
    //[securitySO refreshUserSessionWithToken:@"9mbmO2ARxqM34bR+hVKTiQ=="];
    //[securitySO userInfoWithToken:@"VjrCrTMPpb221/h/QwAITg=="];  //This method has to sanitize the TOKEN before send it in order to clean unsupported charaters and to retreive data
    //[securitySO sanitizeURLString:@"CV#rtrdc45<5fe"];
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSDictionary *testUser = @{
                               @"Id": uuid,
                               @"Name": @"Helena",
                               @"LastName": @"Bahachille",
                               @"Password": @"123456",
                               @"PasswordComparation": @"123456",
                               @"SecretQuestion": @"marca de carros preferida",
                               @"SecretAnswer": @"mercedes",
                               @"ReceiveMassMail": @false,
                               @"BirthDate": @"/Date(1984-00-04 12:00:00)/",
                               @"Email": @"helenabahachile@gmail.com",
                               @"EmailComparation": @"helenabahachile@gmail.com",
                               @"IdCard": @"V14645998",
                               @"IdCardType": @"V",
                               @"IdCardNumber": @"14645998",
                               @"Phone": @"2127311745",
                               @"MobilePhone": @"04123245678",
                               @"Sex": @"1",
                               @"City": @"Caracas",
                               @"State": @"DtoCapital",
                               @"Country": @"VE",
                               @"Address": @"XXXXXXXXXXX",
                               @"CreationDate": @"/Date(2015-00-11 12:00:00)/",
                               @"ActivationDate": @"/Date(2015-00-11 12:00:00)/",
                               @"Active": @false,
                               @"DateOut": @"/Date(2015-00-11 12:00:00)/",
                               @"DateLastVisit": @"/Date(2015-00-11 12:00:00)/",
                               @"DateCurrentVisit": @"/Date(2015-00-11 12:00:00)/",
                               @"DateLastUpdate": @"/Date(2015-00-11 12:00:00)/",
                               @"Zipcode": @1050,
                               @"Twitter": @"",
                               @"Facebook": @"",
                               @"Instagram": @""
                               };
    
    NSDictionary *updateTestUser = @{
                               @"SecretQuestion": @"favorite NFL team",
                               @"SecretAnswer": @"Miami Dolphins",
                               @"Instagram": @"http://www.instagram.com"
                               };

    //[securitySO createUser:testUser];
    //[securitySO activateUserWithGUID:@"A96DE5F5-A247-4589-80F2-BBBD6397CEBC"];  //id hb
    //[securitySO readCompleteUserInfoWithGUID:@"A96DE5F5-A247-4589-80F2-BBBD6397CEBC"];  //id personal
    //[securitySO readCompleteUserInfoWithToken:@"yaqZBLohh4mFhzb/5Mc2SA=="];
    //[securitySO rememberEmailForThisIdCard:@"V16430181" forDay:5 forMonth:2 andYearOfBirth:1983];
    //[securitySO updateUser:@"A96DE5F5-A247-4589-80F2-BBBD6397CEBC" withNewSettingsValues:nil];
    //[securitySO rememberPasswordForThisEmail:@"HelenaBahachille@gmail.com"];  //this one does not do the job...
    //[securitySO verifyAnswerForThisEmail:@"HelenaBahachille@gmail.com" withThisAnswer:@"Miami Dolphins"];
    //[securitySO verifyThisEmail:@"HelenaBahachille@gmail.com" withThisIdCard:@"V14645998"];
    
    //***************************************//
    
    //          Contact Methods
    ContactServices *contactSO = [self.WSC getServiceObjectFromGroup:@"contact"];
    NSDictionary *complain = @{ @"Subject" : @"Fallas al Comprar por Pagina Web",
                                 @"Theater" : @"Centro Sur",
                                 @"Movie" : @"Test Movie",
                                 @"Date" : @"/Date(12-04-2015)/",
                                 @"Time" : @"/Date(00)/",
                                 @"Name" : @"John",
                                 @"LastName" : @"Doe",
                                 @"IDCard" :  @"V34452676",
                                 @"PhoneCode" : @"212",
                                 @"Phone" : @"9732134",
                                 @"Email" : @"lpuga@cinesunidos.com",
                                 @"Comment" : @"this is a test"};
    //[contactSO sendComplaint: complain];
    //*****************************************//
    
    UsersessionServices *userSessionSO = [self.WSC getServiceObjectFromGroup:@"usersession"];
    NSMutableArray *ticketsToBuy = [[NSMutableArray alloc] init];
    NSDictionary *ticket = @{
                             @"BookingFee" : @22.32,
                             @"ServiceFee" : @0,
                             @"ServiceFeeWithTax" : @0,
                             @"Name" : @"Boleto - Mayor de 60 años",
                             @"Price" : @150,
                             @"Tax" : @2.68,
                             @"Code" : @"0333",
                             @"Quantity" : @1 };
    NSDictionary *ticket2 = @{
                              @"BookingFee" : @22.32,
                              @"Code" : @0330,
                              @"Name" : @"Boleto - General",
                              @"Price" : @300,
                              @"Quantity" : @0,
                              @"ServiceFee" : @0,
                              @"ServiceFeeWithTax" : @0,
                              @"Tax" : @2.68
                              };
    NSDictionary *ticket3 = @{
                              @"BookingFee" : @22.32,
                              @"Code" : @0334,
                              @"Name" : @"Boleto - Niño",
                              @"Price" : @150,
                              @"Quantity" : @0,
                              @"ServiceFee" : @0,
                              @"ServiceFeeWithTax" : @0,
                              @"Tax" : @2.68
                              };
    /*{
        "AreaCategoryCode" : "0000000001",
        "AreaNumber" : 1,
        "ColumnIndex" : 8,
        "Name" : "A9",
        "RowIndex" : 11,
        "Status" : "Booked",  // es un enum del lado del backend
        "Type" : "Chair"
    }*/
    NSDictionary *seats = @{
        @"AreaCategoryCode" : @"0000000001",
        @"AreaNumber" : @1,
        @"ColumnIndex" : @12,
        @"Name" : @"A13",
        @"RowIndex" : @8,
        @"Status" : @2,
        @"Type" : @0
        };
    [ticketsToBuy addObject:ticket];
    [ticketsToBuy addObject:ticket2];
    [ticketsToBuy addObject:ticket3];
    NSMutableArray *seatsArray = [[NSMutableArray alloc] init];
    [seatsArray addObject:seats];
    //[userSessionSO createUserSessionInTheater:1007 withSession:266141 forMovie:@"HO00002887" withTickets:ticketsToBuy];
    //[userSessionSO comfirmUserSessionWithThisId:@"b2f8d2d3-b944-4f9c-ba67-26e24dd32511" withSeats:seatsArray];
    //[userSessionSO readUserReservationWithUserSessionId:@"215c8a32-3f10-4e2b-ba4e-6ba72c7144e8"];
    NSDictionary *paymentInfo = @{
                                  @"UserSessionId" : @"b2f8d2d3-b944-4f9c-ba67-26e24dd32511",
                                  @"Type" : @"0",
                                  @"Month" : @"5",
                                  @"Year" : @"2016",
                                  @"Number" : @"4544400125579539",
                                  @"SecurityCode" : @"980",
                                  @"Name" : @"Edgar Silva",
                                  @"CertificateType" : @"V",
                                  @"Certificate" : @"9504449",
                                  @"Phone" : @"04127354692",
                                  @"Email" : @"esc64@yahoo.com"
                                  };
    /*
     NSDictionary *paymentInfo = @{
                                  @"UserSessionId" : @"f1058e5e-cafc-4192-87ad-91c563d0eb45",
                                  @"Type" : @0,
                                  @"Month" : @2,
                                  @"Year" : @19,
                                  @"Number" : @4110195222118199,
                                  @"SecurityCode" : @776,
                                  @"Name" : @"Leonardo J Puga",
                                  @"CertificateType" : @"V",
                                  @"Certificate" : @"16430181",
                                  @"Phone" : @"04143147699",
                                  @"Email" : @"ing.ljpdb@gmail.com"
                                  };
    */
    //[userSessionSO paymentInfo:paymentInfo];
    //[userSessionSO getGiftCardBalanceWithNumber:@"9917930702010791"];
    //[userSessionSO unsubscribeUserFromPostWithID:@"7b372887-96a5-4be3-8020-daaab94fb215" andWithEmail:@"ing.ljpdb@gmail.com"];
    [userSessionSO unsubscribeUserFromPostWithID:@"7b372887-96a5-4be3-8020-daaab94fb215" andWithEmail:@"ing.ljpdb@gmail.com"];
    /*  Create Session
     
     {
     "TheaterId" : "1027",
     "SessionId" : "286696",
     "MovieId" : "HO00002979",
     "Tickets" : [
        {
        "BookingFee": 22.32,
        "ServiceFee": 133.93,
        "ServiceFeeWithTax": 18.75,
        "Name": "Boleto - Mayo de 60 años",
        "Price": 150,
        "Tax": 18.75,
        "Code": "0190",
        "Quantity": 1
        }
     ]
     }
     */
    
    /*   Confirmation
     {   //asientos seleccionados en el lider a para spectre007
     "Seats" : [
     {
     "AreaCategoryCode" : "0000000001",
     "AreaNumber" : 1,
     "ColumnIndex" : 7,
     "Name" : "A8",
     "RowIndex" : 12,
     "Status" : 2,
     "Type" : 0
     }
     ],
     "UserSessionId" : "ee7132fc-1b3d-4fff-94c0-266ebdc0e304"
     }
     */
    
    
    /*   Payment
     { credit card  ES    //giftcard 977563000999999871  4/10  cvv: 947 al parecer cuando es tipo giftcard no hace falta los datos de CVV ni vencimiento
     "UserSessionId" : "ee7132fc-1b3d-4fff-94c0-266ebdc0e304",
     "Type" : 0,
     "Month" : 5,
     "Year" : 2016,
     "Number" : "4544400125579539",
     "SecurityCode" : "980",
     "Name" : "Edgar Silva",
     "CertificateType" : "V",
     "Certificate" : "9504449",
     "Phone" : "04127354692",
     "Email" : "esc64@yahoo.com"
     }
     */
    
    
   // [premierSO testMethod];
   
    
    
    
    //
    
    /*dispatch_async(dispatch_get_main_queue(), ^{
        _allTheaters = [[NSMutableDictionary alloc] initWithDictionary: [theaterSO getAllTheaters:nil]];
    });*/
    
    // Do any additional setup after loading the view.
    //NSDictionary *test = [[NSDictionary alloc] init];
    //NSArray *test2 = @[@"ew", @"ergf"];
    //NSString *stringtest = @"leo";
   // NSDictionary *insideTest = @{ @"1" : @"first", @"2" : @"second" };
   // NSArray *insideTestArray = [[NSArray alloc] initWithObjects:insideTest, nil];
    //[test setValue:test2 forKey:@"first"];
   // [test setValue:stringtest forKey:@"second"];
   // [test setValue:insideTest forKey:@"fireTest"];
   // NSLog(@"Multiple objects dictionary: %@", test);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)webServiceReceivedResponse:(NSMutableDictionary *)response{
    NSLog(@"Service received response");
}

@end
