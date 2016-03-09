//
//  BaseButton.h
//  FindFlight
//
//  Created by spens on 28/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import <UIKit/UIKit.h>

#if TARGET_INTERFACE_BUILDER
IB_DESIGNABLE
#endif

@interface BaseButton : UIButton

@property (nonatomic) IBInspectable UIColor *color;

@end
