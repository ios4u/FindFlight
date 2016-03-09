//
//  TextField.h
//  FindFlight
//
//  Created by spens on 28/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

#if TARGET_INTERFACE_BUILDER
IB_DESIGNABLE
#endif

@interface TextField : UITextField

@property (nonatomic) IBInspectable UIColor *placeholderColor;
@property (nonatomic) IBInspectable BOOL centeredPlaceholder;
@property (nonatomic) IBInspectable BOOL rightPlaceholder;

- (void)shake;

@end
