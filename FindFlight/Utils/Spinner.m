//
//  Spinner.m
//  Helpers
//
//  Created by spens on 29/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "Spinner.h"
#import "SpinnerObject.h"

@implementation Spinner

#define IDC_TAG 9989

+ (void)showSpinner
{
    [Spinner showSpinner:[UIColor whiteColor] containerColor:[UIColor blackColor] containerSize:CGSizeMake(60, 60) inView:nil];
}

+ (void)showSpinner:(UIColor *)color containerColor:(UIColor *)ccolor containerSize:(CGSize)size inView:(UIView *)view {
    if (!view) {
        for (UIView *subview in [UIApplication sharedApplication].keyWindow.subviews) {
            if (subview.tag == IDC_TAG) {
                return;
            }
        }
    } else {
        for (UIView *subview in view.subviews) {
            if (subview.tag == IDC_TAG) {
                return;
            }
        }
    }
    
    UIView *fadeView;
    if (!view) {
        fadeView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        fadeView.backgroundColor = [UIColor clearColor];
        fadeView.tag = IDC_TAG;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:fadeView];
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.width)];
    container.center = fadeView.center;
    container.backgroundColor = ccolor;
    container.layer.cornerRadius = 5;
    container.alpha = 0.95;
    container.clipsToBounds = YES;
    container.tag = IDC_TAG;
    
    SpinnerObject *spinner = [[SpinnerObject alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(container.frame), CGRectGetWidth(container.frame))];
    spinner.backgroundColor = [UIColor clearColor];
    spinner.endAngle = 300;
    spinner.radius = CGRectGetWidth(container.frame)/3 - 2;
    spinner.color = color;
    spinner.lineWidth = 1;
    spinner.center = CGPointMake(CGRectGetWidth(container.frame)/2, CGRectGetHeight(container.frame)/2);
    [container addSubview:spinner];
    [spinner starAnimation];
    
    if (view) {
        container.center = view.center;
        [view addSubview:container];
    } else {
        [fadeView addSubview:container];
        [[UIApplication sharedApplication].keyWindow addSubview:fadeView];
    }
}

+ (void)hideSpinner
{
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if (view.tag == IDC_TAG) {
            [view removeFromSuperview];
        }
    }
}

+ (void)hideSpinnerInView:(UIView *)view
{
    if (!view) {
        for (UIView *subview in view.subviews) {
            if (subview.tag == IDC_TAG) {
                [((UIActivityIndicatorView *)subview) stopAnimating];
                [subview removeFromSuperview];
            }
        }
    } else {
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            if (view.tag == IDC_TAG) {
                [view removeFromSuperview];
            }
        }
    }
}

@end
