//
//  ResultsViewController.h
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "BaseViewController.h"

@interface ResultsViewController : BaseViewController

@property (nonatomic) BOOL single;
@property (nonatomic) NSArray *offers;
@property (nonatomic) NSString *navbarText;
@property (nonatomic) NSString *fromCode;
@property (nonatomic) NSString *toCode;

@end
