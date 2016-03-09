//
//  DataManager.h
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic) NSArray *cities;
@property (nonatomic) NSArray *airports;
@property (nonatomic) NSArray *companies;

- (NSString *)airportNameForCityCode:(NSString *)cityCode;

@end
