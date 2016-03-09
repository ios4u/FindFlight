//
//  TransitionController.m
//  FindFlight
//
//  Created by spens on 29/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "TransitionController.h"
#import "Settings.h"

@implementation TransitionController
{
    UIView *bubble;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (CGRect)frameForBubbleWithOriginalCenter:(CGPoint)originalCenter size:(CGSize)originalSize start:(CGPoint)start
{
    float lengthX = fmax(start.x, originalSize.width - start.x);
    float lengthY = fmax(start.y, originalSize.height - start.y);
    float offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
    CGSize size = CGSizeMake(offset, offset);
    return CGRectMake(0, 0, size.width, size.height);
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.searchTransition) {
        if (self.transitionMode == TransitionModePresent) {
            UIView *containerView = transitionContext.containerView;
            containerView.clipsToBounds = YES;
            
            UIView *presentedControllerView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
            CGPoint originalCenter = presentedControllerView.center;
            CGSize originalSize = presentedControllerView.frame.size;
            
            bubble = [[UIView alloc] initWithFrame:[self frameForBubbleWithOriginalCenter:originalCenter size:originalSize start:self.button.center]];
            bubble.layer.cornerRadius = bubble.frame.size.width/2;
            bubble.center = self.button.center;
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.backgroundColor = mainGreenColor;
            [containerView addSubview:bubble];
            
            presentedControllerView.center = self.button.center;
            presentedControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            presentedControllerView.alpha = 0;
            [containerView addSubview:presentedControllerView];
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                bubble.transform = CGAffineTransformIdentity;
                bubble.center = containerView.center;
            }completion:^(BOOL finished){
                bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            }];
            
            self.fade.hidden = NO;
            self.fade.alpha = 0;
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                presentedControllerView.alpha = 1;
                presentedControllerView.center = originalCenter;
                presentedControllerView.transform = CGAffineTransformMakeScale(1.15, 1.15);
                
                self.fade.alpha = 0.6;
            }completion:^(BOOL finished){
                POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                spring.springSpeed = 20;
                spring.springBounciness = 20;
                spring.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];//[NSValue valueWithCGPoint:CGPointMake(0.94, 0.94)];
                spring.removedOnCompletion = YES;
                [presentedControllerView.layer pop_addAnimation:spring forKey:@"scale"];
                
                [transitionContext completeTransition:YES];
            }];
        } else {
            UIView *containerView = transitionContext.containerView;
            containerView.clipsToBounds = YES;
            
            UIView *returningControllerView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
            
            //bubble.center = self.button.center;
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                bubble.transform = CGAffineTransformMakeScale(1, 1);
            }completion:^(BOOL finished){
                [containerView addSubview:returningControllerView];
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
                    bubble.center = self.button.center;
                }completion:^(BOOL finished){
                    [bubble removeFromSuperview];
                }];
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    returningControllerView.alpha = 0;
                    returningControllerView.center = self.button.center;
                    returningControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
                    
                    self.fade.alpha = 0;
                }completion:^(BOOL finished){
                    self.fade.hidden = YES;
                    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                    spring.springSpeed = 20;
                    spring.springBounciness = 20;
                    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
                    spring.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.75, 0.75)];
                    spring.removedOnCompletion = YES;
                    [self.button.layer pop_addAnimation:spring forKey:@"scale"];
                    [transitionContext completeTransition:YES];
                }];
            }];
        }
    } else if (self.citySelectionTransition) {
        if (self.transitionMode == TransitionModePresent) {
            UIView *containerView = transitionContext.containerView;
            containerView.clipsToBounds = YES;
            
            UIView *presentedControllerView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;

            presentedControllerView.center = self.startingPoint;
            presentedControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            [containerView addSubview:presentedControllerView];
            
            self.fade.alpha = 0;
            self.fade.hidden = NO;
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                presentedControllerView.center = containerView.center;
                self.fade.alpha = 0.6;
            }completion:^(BOOL finished){
                [transitionContext completeTransition:YES];
            }];
            
            POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
            spring.springSpeed = 20;
            spring.springBounciness = 15;
            spring.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];//[NSValue valueWithCGPoint:CGPointMake(0.85, 0.85)];
            spring.removedOnCompletion = YES;
            [presentedControllerView.layer pop_addAnimation:spring forKey:@"scale"];
        } else {
            UIView *containerView = transitionContext.containerView;
            containerView.clipsToBounds = YES;
            
            UIView *returningControllerView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
            
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                returningControllerView.transform = CGAffineTransformMakeScale(0.95, 0.95);
            }completion:^(BOOL finished){
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    returningControllerView.center = self.startingPoint;
                    returningControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
                    self.fade.alpha = 0;
                }completion:^(BOOL finished){
                    self.fade.hidden = YES;
                    [transitionContext completeTransition:YES];
                }];
            }];
        }
    } else {
        if (self.transitionMode == TransitionModePresent) {
            UIView *containerView = transitionContext.containerView;
            UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
            UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
            
            //toView.transform = CGAffineTransformMakeScale(0.94, 0.94);
            
            [UIView transitionFromView:fromView toView:toView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished){
                [containerView addSubview:toView];
                [transitionContext completeTransition:YES];
            }];
        } else {
            //UIView *containerView = transitionContext.containerView;
            UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
            UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
            
            [UIView transitionFromView:fromView toView:toView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){
                [[[[UIApplication sharedApplication] delegate] window] addSubview:toView];
                [transitionContext completeTransition:YES];
            }];
        }
    }
}

@end
