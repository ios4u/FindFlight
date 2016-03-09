//
//  TransitionController.h
//  FindFlight
//
//  Created by spens on 29/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "POP.h"

typedef NS_ENUM (NSInteger, TransitionMode)
{
    TransitionModePresent,
    TransitionModeDismiss
};

@interface TransitionController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL searchTransition;
@property (nonatomic) UIButton *button;
@property (nonatomic) TransitionMode transitionMode;
@property (nonatomic) UIView *fade;

@property (nonatomic) BOOL citySelectionTransition;
@property (nonatomic) CGPoint startingPoint;

@property (nonatomic) BOOL resultsTransition;

@end
