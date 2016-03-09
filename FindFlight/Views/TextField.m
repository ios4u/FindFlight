//
//  TextField.m
//  FindFlight
//
//  Created by spens on 28/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "TextField.h"

@implementation TextField
{
    UIColor *_placeholderColor;
    BOOL _centeredPlaceholder;
    BOOL _rightPlaceholder;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:17 weight:UIFontWeightLight],
                                 NSForegroundColorAttributeName : _placeholderColor ?: mainGrayColor};
    
    CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
    
    if (!_centeredPlaceholder && !_rightPlaceholder) {
        [[self placeholder] drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withAttributes: attributes];
    } else if (_centeredPlaceholder) {
        [[self placeholder] drawAtPoint:CGPointMake(rect.size.width/2 - 27, (rect.size.height/2)-boundingRect.size.height/2) withAttributes: attributes];
    } else {
        [[self placeholder] drawAtPoint:CGPointMake(rect.size.width - 32, (rect.size.height/2)-boundingRect.size.height/2) withAttributes: attributes];
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    NSString *pl = self.placeholder;
    self.placeholder = @"";
    self.placeholder = pl;
}

- (void)setCenteredPlaceholder:(BOOL)centeredPlaceholder
{
    _centeredPlaceholder = centeredPlaceholder;
    NSString *pl = self.placeholder;
    self.placeholder = @"";
    self.placeholder = pl;
}

- (void)setRightPlaceholder:(BOOL)rightPlaceholder
{
    _rightPlaceholder = rightPlaceholder;
    NSString *pl = self.placeholder;
    self.placeholder = @"";
    self.placeholder = pl;
}

- (void)shake
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.07;
    animation.repeatCount = 2;
    animation.autoreverses = YES;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x - 5, self.center.y)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x + 5, self.center.y)];
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:@"position"];
}

@end
