//
//  CityCell.m
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "CityCell.h"
#import "Settings.h"

@implementation CityCell

- (void)awakeFromNib {
    
    UIView *selection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 70)];
    selection.backgroundColor = [mainGreenColor colorWithAlphaComponent:0.3];
    self.selectedBackgroundView = selection;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
