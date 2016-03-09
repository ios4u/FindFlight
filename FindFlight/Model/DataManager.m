//
//  DataManager.m
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (instancetype)sharedInstance
{
    static DataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [DataManager new];
    });
    return instance;
}

- (NSString *)airportNameForCityCode:(NSString *)cityCode;
{
    for (NSDictionary *d in self.airports) {
        if ([cityCode isEqualToString:d[@"cityCode"]]) {
            return d[@"name"];
        }
    }
    return nil;
}

@end
