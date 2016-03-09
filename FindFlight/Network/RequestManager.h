//
//  RequestManager.h
//  FindFlight
//
//  Created by spens on 29/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RequestManager : NSObject

+ (instancetype)sharedInstance;

- (void)getCitiesWithCompletion:(void(^)(NSArray *cities))completion;
- (void)getAirportsWithCompletion:(void(^)(NSArray *airports))completion;
- (void)getCompaniesWithCompletion:(void(^)(NSArray *companies))completion;
- (void)getLogoForCompany:(NSString *)iata completion:(void(^)(UIImage *logo))completion;
- (void)getOffersFrom:(NSString *)cityFrom to:(NSString *)cityTo departureDate:(NSDate *)departureDate returningDate:(NSDate *)returningDate completion:(void (^)(NSArray *offers, BOOL success))completion;

@end
