//
//  Divider.m
//  FindFlight
//
//  Created by spens on 28/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "Divider.h"

@implementation Divider

- (void)drawRect:(CGRect)rect
{
    [self drawDividerWithFrameWidth:CGRectGetWidth(rect) dividerFrameHeight:CGRectGetHeight(rect)];
}

- (void)drawDividerWithFrameWidth: (CGFloat)dividerFrameWidth dividerFrameHeight: (CGFloat)dividerFrameHeight
{
    UIColor* gray = self.color;
    
    //// Variable Declarations
    BOOL showHorizontalDivider = dividerFrameWidth > dividerFrameHeight ? YES : NO;
    BOOL showVerticalDivider = dividerFrameWidth < dividerFrameHeight ? YES : NO;
    
    //// Frames
    CGRect frame = CGRectMake(0, 0, dividerFrameWidth, dividerFrameHeight);
    
    
    if (showHorizontalDivider)
    {
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) - 0.5, CGRectGetWidth(frame), 1)];
        [gray setFill];
        [rectanglePath fill];
    }
    
    
    if (showVerticalDivider)
    {
        //// Rectangle 3 Drawing
        UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame) - 0.5, CGRectGetMinY(frame), 1, CGRectGetHeight(frame))];
        [gray setFill];
        [rectangle3Path fill];
    }
}

- (void)setColor:(UIColor *)color
{
    [super setColor:color];
    [self setNeedsDisplay];
}

@end
