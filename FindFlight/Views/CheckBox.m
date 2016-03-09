//
//  CheckBox.m
//  FindFlight
//
//  Created by spens on 28/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "CheckBox.h"

@implementation CheckBox
{
    BOOL _isChecked;
}

- (void)drawRect:(CGRect)rect
{
    [self drawCheckBoxWithFrame:rect color:self.color isChecked:_isChecked];
}

- (void)drawCheckBoxWithFrame: (CGRect)frame color: (UIColor*)color isChecked: (BOOL)isChecked
{
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.04286 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.04286 + 0.5), floor(CGRectGetWidth(frame) * 0.95714 + 0.5) - floor(CGRectGetWidth(frame) * 0.04286 + 0.5), floor(CGRectGetHeight(frame) * 0.95714 + 0.5) - floor(CGRectGetHeight(frame) * 0.04286 + 0.5)) cornerRadius: 4];
    [color setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
    
    
    if (isChecked)
    {
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.15000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52143 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46648 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.83571 * CGRectGetHeight(frame))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.83571 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.20714 * CGRectGetHeight(frame))];
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        bezierPath.lineJoinStyle = kCGLineJoinBevel;
        
        [color setStroke];
        bezierPath.lineWidth = 2;
        [bezierPath stroke];
    }
}

//- (void)drawCheckBoxWithFrame: (CGRect)frame color: (UIColor*)color isChecked: (BOOL)isChecked
//{
//    
//    //// Rectangle Drawing
//    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.00000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.00000 + 0.5), floor(CGRectGetWidth(frame) * 1.00000 + 0.5) - floor(CGRectGetWidth(frame) * 0.00000 + 0.5), floor(CGRectGetHeight(frame) * 1.00000 + 0.5) - floor(CGRectGetHeight(frame) * 0.00000 + 0.5)) cornerRadius: 4];
//    [color setStroke];
//    rectanglePath.lineWidth = 1;
//    [rectanglePath stroke];
//    
//    
//    if (isChecked)
//    {
//        //// Bezier Drawing
//        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
//        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18333 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.47483 * CGRectGetHeight(frame))];
//        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49424 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76667 * CGRectGetHeight(frame))];
//        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81667 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.21667 * CGRectGetHeight(frame))];
//        bezierPath.lineCapStyle = kCGLineCapRound;
//        
//        bezierPath.lineJoinStyle = kCGLineJoinRound;
//        
//        [color setStroke];
//        bezierPath.lineWidth = 3;
//        [bezierPath stroke];
//    }
//}

- (void)setIsChecked:(BOOL)isChecked
{
    _isChecked = isChecked;
    [self setNeedsDisplay];
}

@end
