//
//  CitySelectionViewController.h
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "BaseViewController.h"

@interface CitySelectionViewController : BaseViewController

@property (nonatomic, strong) void (^completion)(NSDictionary *city);

@end
