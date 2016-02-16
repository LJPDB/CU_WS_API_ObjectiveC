//
//  ContactServices.h
//  CU_WebServices_ObjectiveC
//
//  Created by Leonardo Puga De Biase on 12/7/15.
//  Copyright © 2015 Leonardo Puga De Biase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServicesConnection.h"
#import "MeaningAndFormValidation.h"

@interface ContactServices : NSObject
-(void)setURIstring:(NSString *) URIstring andSetWSC:(id)WSC;
-(void)sendComplaint:(NSDictionary *)complaintParams;
@end

/* 
 COMPLAIN object structure
{
 "Subject" : "Fallas al Comprar por Pagina Web",
 "Theater" : "Orinokia",
 "Movie" : "Test Movie",
 "Date" : "/Date(12-04-2015)/",
 "Time" : "/Date(00)/",
 "Name" : "John",
 "LastName" : "Doe",
 "IDCard" :  "V32323232",
 "PhoneCode" : "212",
 "Phone" : "2346413"
 "Email" : "example@domain.com",
 "Comment" : "this is a test"
 }


 Default Values needed for COMPLAINTS
                    <SUBJECTS>
 
 "Fallas al Comprar por Pagina Web"
 "Fallas al Comprar por App BlackBerry"
 "Tiempos de Espera"
 "Atención déscortes y poco amable"
 "Falta de Higiene y Limpieza"
 "Falla de Proyeccion, Sonido y Aire Acondicionado"
 "Descontento con Alimentos, Bebidas y Dulces"
 "Promociones"
 "Otro"
 ​
                    <THEATERS>
 "Centro Sur"
 "Costa Azul"
 "El Marqués"
 "Galerías Ávila"
 "Galerías Paraiso"
 "Guatire Plaza"
 "Hyper Jumbo"
 "La Granja"
 "Las Américas"
 "Las Trinitarias"
 "Líder"
 "Los Naranjos"
 "Millennium"
 "Metrocenter"
 "Metrópolis"
 "Orinokia"
 "Petroriente"
 "Regina"
 "Sambil Barquisimeto"
 "Sambil Caracas"
 "Sambil Maracaibo"
 "Sambil Margarita"
 "Sambil S. Cristóbal"
 "Sambil Valencia"
 
 */
