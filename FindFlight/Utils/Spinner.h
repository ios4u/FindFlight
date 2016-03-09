//
//  Spinner.h
//  Helpers
//
//  Created by spens on 29/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface Spinner : NSObject

+ (void)showSpinner;
+ (void)showSpinner:(UIColor *)color containerColor:(UIColor *)ccolor containerSize:(CGSize)size inView:(UIView *)view;
+ (void)hideSpinner;
+ (void)hideSpinnerInView:(UIView *)view;

@end
