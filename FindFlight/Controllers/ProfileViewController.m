//
//  ProfileViewController.m
//  FindFlight
//
//  Created by spens on 28/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "ProfileViewController.h"
#import "SearchViewController.h"
#import "TransitionController.h"
#import "POP.h"
#import "Buttons.h"

@interface ProfileViewController () <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIButton *riseScoreButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet Buttons *searchFlightsButton;
@property (weak, nonatomic) IBOutlet UIView *fade;

@end

@implementation ProfileViewController
{
    UIView *fill;
    TransitionController *transition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    transition = [TransitionController new];
    transition.transitionMode = TransitionModePresent;
    
    self.avatar.layer.cornerRadius = CGRectGetWidth(self.avatar.frame)/2;
    self.avatar.layer.borderWidth = 3;
    self.avatar.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (IBAction)backButtonHandler:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)risescoreButtonHandler:(id)sender
{

}

- (IBAction)searchFligthsButtonHandler:(id)sender
{
    SearchViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitionDelegate -

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    transition.transitionMode = TransitionModePresent;
    transition.searchTransition = YES;
    transition.button = self.searchFlightsButton;
    transition.fade = self.fade;
    return transition;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    transition.transitionMode = TransitionModeDismiss;
    return transition;
}

@end
