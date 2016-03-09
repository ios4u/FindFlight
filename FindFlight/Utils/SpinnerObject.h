//
//  SpinnerObject.h
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

#if TARGET_INTERFACE_BUILDER
IB_DESIGNABLE
#endif

@interface SpinnerObject : UIView

@property (nonatomic) IBInspectable float radius;
@property (nonatomic) IBInspectable float endAngle;
@property (nonatomic) IBInspectable UIColor *color;
@property (nonatomic) IBInspectable float lineWidth;

- (void)starAnimation;
- (void)stopAnimation;

@end
