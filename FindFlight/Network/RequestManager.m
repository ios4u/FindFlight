//
//  RequestManager.m
//  FindFlight
//
//  Created by spens on 29/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#define BASE_URL @"http://api.travelpayouts.com"

#import "RequestManager.h"
#import "Settings.h"
#import "NSManagedObject+ObjectsManager.h"
#import "DataManager.h"

@implementation RequestManager
{
    NSURLSession *session;
}

+ (instancetype)sharedInstance
{
    static RequestManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [RequestManager new];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        NSURLSessionConfiguration *c = [NSURLSessionConfiguration defaultSessionConfiguration];
        c.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
        session = [NSURLSession sessionWithConfiguration:c];
    }
    return self;
}

- (void)getCitiesWithCompletion:(void(^)(NSArray *cities))completion
{
    NSString *endpoint = @"/data/cities.json";
    NSURL *url = [NSURL URLWithString:string(@"%@%@", BASE_URL, endpoint)];
    
    NSLog(@"begin cities fetching");
    [self startRequesWithURL:url completion:^(NSData *data) {
        if (data) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSMutableArray *tmp = [NSMutableArray new];
                for (NSDictionary *dict in arr) {
                    [tmp addObject:@{@"name" : [dict[@"name_translations"] objectForKey:@"en"],
                                     @"code" : dict[@"code"]}];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [DataManager sharedInstance].cities = tmp;
                    if (completion) {
                        completion(tmp);
                    }
                    NSLog(@"end cities fetching");
                });
            });
        }
    }];
}

- (void)getAirportsWithCompletion:(void(^)(NSArray *airports))completion
{
    NSString *endpoint = @"/data/airports.json";
    NSURL *url = [NSURL URLWithString:string(@"%@%@", BASE_URL, endpoint)];
    
    NSLog(@"begin airport fetching");
    [self startRequesWithURL:url completion:^(NSData *data) {
        if (data) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSMutableArray *tmp = [NSMutableArray new];
                for (NSDictionary *dict in arr) {
                    [tmp addObject:@{@"name" : dict[@"name"] ,
                                     @"code" : dict[@"code"],
                                     @"cityCode": dict[@"city_code"]}];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [DataManager sharedInstance].airports = tmp;
                    if (completion) {
                        completion(tmp);
                    }
                    NSLog(@"end airport fetching");
                });
            });
        }
    }];
}

- (void)getCompaniesWithCompletion:(void(^)(NSArray *companies))completion
{
    NSString *endpoint = @"/data/airlines.json";
    NSURL *url = [NSURL URLWithString:string(@"%@%@", BASE_URL, endpoint)];
    
    NSLog(@"begin companies fetching");
    [self startRequesWithURL:url completion:^(NSData *data) {
        if (data) {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSMutableArray *tmp = [NSMutableArray new];
                for (NSDictionary *dict in arr) {
                    [tmp addObject:@{@"iata" : dict[@"iata"],
                                     @"icao" : dict[@"icao"],
                                     @"name" : dict[@"name"]}];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [DataManager sharedInstance].companies = tmp;
                    if (completion) {
                        completion(tmp);
                    }
                    NSLog(@"end companies fetching");
                });
            });
        }
    }];
}

- (void)getLogoForCompany:(NSString *)iata completion:(void(^)(UIImage *logo))completion
{
    NSString *endpoint = string(@"http://ios.aviasales.ru/logos/hdpi/%@.png", iata);
    NSURL *url = [NSURL URLWithString:endpoint];
    
    [self startRequesWithURL:url completion:^(NSData *data) {
        if (data) {
            if (completion) {
                completion([UIImage imageWithData:data]);
            }
        }
    }];
}

- (void)getOffersFrom:(NSString *)cityFrom to:(NSString *)cityTo departureDate:(NSDate *)departureDate returningDate:(NSDate *)returningDate completion:(void (^)(NSArray *offers, BOOL success))completion;
{
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"YYYY-MM-dd"];
    NSString* depart = [df stringFromDate:departureDate];
    
    NSString *endpoint;
    if (!returningDate) {
        endpoint = string(@"/v1/prices/cheap?currency=USD&origin=%@&destination=%@&depart_date=%@&show_to_affiliates=true&token=5d864e5bd940e2ba5316c624cbd6732b", cityFrom, cityTo, depart);
    } else {
        endpoint = string(@"/v1/prices/cheap?currency=USD&origin=%@&destination=%@&depart_date=%@&show_to_affiliates=true&token=5d864e5bd940e2ba5316c624cbd6732b", cityFrom, cityTo, depart);
    }

    NSURL *url = [NSURL URLWithString:string(@"%@%@", BASE_URL, endpoint)];
    
    [self startRequesWithURL:url completion:^(NSData *data) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (dict) {
                BOOL success = [dict[@"success"] boolValue];
                if (success) {
                    if ([dict[@"data"] isKindOfClass:[NSArray class]]) {
                        NSArray *arr = dict[@"data"];
                        if (completion) {
                            completion(arr, success);
                        }
                    } else {
                        if (completion) {
                            NSArray *arr = [[[dict[@"data"] objectForKey:cityTo] allValues] sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *first, NSDictionary *second) {
                                float price = [first[@"price"] floatValue];
                                float price2 = [second[@"price"] floatValue];
                                return price > price2;
                            }];
                            if (arr.count) {
                                completion(arr, success);
                            } else {
                                completion(@[], NO);
                            }
                        }
                    }
                } else {
                    if (completion) {
                        completion(nil, NO);
                    }
                }
            }
        } else {
            if (completion) {
                completion(nil, NO);
            }
        }
    }];
}

- (void)startRequesWithURL:(NSURL *)url completion:(void (^)(NSData *data))completion
{
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!data || error) {
                if (completion) {
                    completion(nil);
                }
            } else {
                if (completion) {
                    completion(data);
                }
            }
        });
    }] resume];
}

@end
