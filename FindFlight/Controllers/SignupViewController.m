//
//  SignupViewController.m
//  FindFlight
//
//  Created by spens on 28/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[RequestManager sharedInstance] getCitiesWithCompletion:nil];
    [[RequestManager sharedInstance] getAirportsWithCompletion:nil];
    [[RequestManager sharedInstance] getCompaniesWithCompletion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)emailSignupButtonHandler:(id)sender
{
    
}

- (IBAction)twitterButtonHandler:(id)sender
{
    
}

- (IBAction)facebookButtonHandler:(id)sender
{
    
}

- (IBAction)linkedInButtonHandler:(id)sender
{
    
}

@end
