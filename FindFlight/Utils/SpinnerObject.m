//
//  SpinnerObject.m
//  FindFlight
//
//  Created by spens on 01/03/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "SpinnerObject.h"

@implementation SpinnerObject

- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor clearColor];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width/2, rect.size.height/2)
                                                        radius:self.radius
                                                    startAngle:0
                                                      endAngle:(3.14159265359 * self.endAngle/180)
                                                     clockwise:YES];
    [self.color setStroke];
    path.lineWidth = self.lineWidth;
    [path stroke];
}

- (void)starAnimation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INFINITY;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopAnimation
{
    [self.layer removeAllAnimations];
}

@end
