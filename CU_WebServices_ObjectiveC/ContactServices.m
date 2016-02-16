//
//  ContactServices.m
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import "ContactServices.h"
@interface ContactServices()
@property (nonatomic, strong) NSString *URIstring;
@property (nonatomic, strong) WebServicesConnection *WSC;
@property (nonatomic, strong) NSArray *complaintReasons;
@property (nonatomic, strong) NSArray *theatersName;
@end
@implementation ContactServices

-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC{
    _URIstring = URIstring;
    _WSC = WSC;
    _complaintReasons = @[@"Fallas al Comprar por Pagina Web",
                          @"Fallas al Comprar por App BlackBerry",
                          @"Tiempos de Espera",
                          @"Atención déscortes y poco amable",
                          @"Falta de Higiene y Limpieza",
                          @"Falla de Proyeccion, Sonido y Aire Acondicionado",
                          @"Descontento con Alimentos, Bebidas y Dulces",
                          @"Promociones",
                          @"Otro"];
    _theatersName = @[@"Centro Sur",
                      @"Costa Azul",
                      @"El Marqués",
                      @"Galerías Ávila",
                      @"Galerías Paraiso",
                      @"Guatire Plaza",
                      @"Hyper Jumbo",
                      @"La Granja",
                      @"Las Américas",
                      @"Las Trinitarias",
                      @"Líder",
                      @"Los Naranjos",
                      @"Millennium",
                      @"Metrocenter",
                      @"Metrópolis",
                      @"Orinokia",
                      @"Petroriente",
                      @"Regina",
                      @"Sambil Barquisimeto",
                      @"Sambil Caracas",
                      @"Sambil Maracaibo",
                      @"Sambil Margarita",
                      @"Sambil S. Cristóbal",
                      @"Sambil Valencia"];
}

-(void)sendComplaint:(NSDictionary *)complaintParams{
    BOOL itsParamsOkay = [MeaningAndFormValidation checkAllMandatoryInDictionary:complaintParams];
    if (itsParamsOkay) {
        if ([_complaintReasons containsObject:[complaintParams valueForKey:@"Subject"]]&&[_theatersName containsObject:[complaintParams valueForKey:@"Theater"]]) {
            NSString *requestType = @"POST";
            NSInteger timeout = 80.0;
            NSString *auxURI = [[NSString alloc] initWithFormat:@"%@%@/", _URIstring, @"Send"];
            [_WSC requestType:requestType ifParams:itsParamsOkay params:complaintParams withTimeout:timeout inURL:auxURI nestedCall:NO nestedCallType:0 URLforNestedCall:nil nestedCallRequestType:nil nestedCallWithTimeout:0 nestedCallIfParams:NO paramsForNestedCall:nil];
        }else{
            [MeaningAndFormValidation printErrorWithText:@"Invalid params 'Subject' or 'Theater' values." inClass:(NSString *)[self class]];
        }

    } else {
        [MeaningAndFormValidation printErrorWithText:@"Invalid params values (not empty values allowed)." inClass:(NSString *)[self class]];
    }
}

@end
