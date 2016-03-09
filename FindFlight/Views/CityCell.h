//
//  CityCell.h
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@end
