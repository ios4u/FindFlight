//
//  Buttons.m
//  FindFlight
//
//  Created by spens on 28/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "Buttons.h"

@implementation Buttons
{
    CGRect f;
}

- (void)drawRect:(CGRect)rect
{
    if (self.backButton) {
        [self drawBackArrowWithFrame:rect color:self.color];
    }
    else if (self.bigButton) {
        [self drawBigButtonWithFrame:rect color:self.color];
    }
    else if (self.borderedButton) {
        [self drawBorderedButtonWithFrame:rect color:self.color];
    }
    else if (self.circleButton) {
        [self drawCircleButtonWithFrame:rect color:self.color];
    }
    else if (self.closeButton) {
        [self drawCloseButtonWithFrame:rect color:self.color];
    }
    else if (self.arrowsButton) {
        [self drawArrowsWithFrame:rect];
    }
}

- (void)drawBackArrowWithFrame: (CGRect)frame color: (UIColor*)color
{
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
    [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17500 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.35000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50000 * CGRectGetHeight(frame))];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82500 * CGRectGetHeight(frame))];
    [color setStroke];
    bezier2Path.lineWidth = 2;
    [bezier2Path stroke];
}

- (void)drawBigButtonWithFrame: (CGRect)frame color: (UIColor*)color
{
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.00000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.00000 + 0.5), floor(CGRectGetWidth(frame) * 1.00000 + 0.5) - floor(CGRectGetWidth(frame) * 0.00000 + 0.5), floor(CGRectGetHeight(frame) * 1.00000 + 0.5) - floor(CGRectGetHeight(frame) * 0.00000 + 0.5)) cornerRadius: 4];
    [color setFill];
    [rectanglePath fill];
}

- (void)drawBorderedButtonWithFrame: (CGRect)frame color: (UIColor*)color
{
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.00250) + 0.5, CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.00714) + 0.5, floor(CGRectGetWidth(frame) * 0.99750) - floor(CGRectGetWidth(frame) * 0.00250), floor(CGRectGetHeight(frame) * 0.99286) - floor(CGRectGetHeight(frame) * 0.00714)) cornerRadius: 4];
    [color setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
}

- (void)drawCircleButtonWithFrame: (CGRect)frame color: (UIColor*)color
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //// Shadow Declarations
    NSShadow* shadow = [[NSShadow alloc] init];
    [shadow setShadowColor: [UIColor.blackColor colorWithAlphaComponent: 0.5]];
    [shadow setShadowOffset: CGSizeMake(0.1, -0.1)];
    [shadow setShadowBlurRadius: 0];
    
    //// Oval Drawing
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.05000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.03333 + 0.5), floor(CGRectGetWidth(frame) * 0.96667 + 0.5) - floor(CGRectGetWidth(frame) * 0.05000 + 0.5), floor(CGRectGetHeight(frame) * 0.95000 + 0.5) - floor(CGRectGetHeight(frame) * 0.03333 + 0.5))];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
    [color setFill];
    [ovalPath fill];
    CGContextRestoreGState(context);
}

- (void)drawCloseButtonWithFrame: (CGRect)frame color: (UIColor*)color
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.25000 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.22500 + 0.5), floor(CGRectGetWidth(frame) * 0.77500 + 0.5) - floor(CGRectGetWidth(frame) * 0.25000 + 0.5), floor(CGRectGetHeight(frame) * 0.77500 + 0.5) - floor(CGRectGetHeight(frame) * 0.22500 + 0.5))];
    [color setFill];
    [ovalPath fill];
    
    
    //// Bezier Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(frame) + 0.37500 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37500 * CGRectGetHeight(frame));
    CGContextRotateCTM(context, 1 * M_PI / 180);
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0, 0)];
    [bezierPath addLineToPoint: CGPointMake(11, 10)];
    [UIColor.whiteColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    CGContextRestoreGState(context);
    
    
    //// Bezier 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(frame) + 0.38750 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.63750 * CGRectGetHeight(frame));
    CGContextRotateCTM(context, -90 * M_PI / 180);
    
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(0, 0)];
    [bezier2Path addLineToPoint: CGPointMake(11, 10)];
    [UIColor.whiteColor setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];
    
    CGContextRestoreGState(context);
}

- (void)drawArrowsWithFrame: (CGRect)frame
{
    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 0 green: 0.863 blue: 0.706 alpha: 1];
    
    
    //// Subframes
    CGRect group = CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.16667 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.16667 + 0.16) + 0.34, floor(CGRectGetWidth(frame) * 0.83333 + 0.5) - floor(CGRectGetWidth(frame) * 0.16667 + 0.5), floor(CGRectGetHeight(frame) * 0.82190 + 0.5) - floor(CGRectGetHeight(frame) * 0.16667 + 0.16) - 0.34);
    
    
    //// Group
    {
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.30000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.17901 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.20000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.17901 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.20000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.79475 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.00000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.79475 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.25000 * CGRectGetWidth(group), CGRectGetMinY(group) + 1.00000 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.50000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.79476 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.30000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.79476 * CGRectGetHeight(group))];
        [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.30000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.17901 * CGRectGetHeight(group))];
        [bezierPath closePath];
        bezierPath.miterLimit = 4;
        
        [fillColor setFill];
        [bezierPath fill];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.74999 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.50000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.20525 * CGRectGetHeight(group))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.70000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.20525 * CGRectGetHeight(group))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.70000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.82099 * CGRectGetHeight(group))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.80000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.82099 * CGRectGetHeight(group))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.80000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.20525 * CGRectGetHeight(group))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 1.00000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.20525 * CGRectGetHeight(group))];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.74999 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group))];
        [bezier2Path closePath];
        bezier2Path.miterLimit = 4;
        
        [fillColor setFill];
        [bezier2Path fill];
    }
}

@end
