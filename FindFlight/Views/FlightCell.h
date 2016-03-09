//
//  FlightCell.h
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *destinationTo;
@property (weak, nonatomic) IBOutlet UILabel *timeTo;
@property (weak, nonatomic) IBOutlet UILabel *flightTimeTo;
@property (weak, nonatomic) IBOutlet UILabel *destinationReturn;
@property (weak, nonatomic) IBOutlet UILabel *timeReturn;
@property (weak, nonatomic) IBOutlet UILabel *flightTimeReturn;
@property (weak, nonatomic) IBOutlet UILabel *transfersTo;
@property (weak, nonatomic) IBOutlet UILabel *transfersReturn;
@property (weak, nonatomic) IBOutlet UIImageView *logo;

@end
