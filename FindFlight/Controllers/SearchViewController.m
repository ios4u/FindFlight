//
//  SearchViewController.m
//  FindFlight
//
//  Created by spens on 29/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "SearchViewController.h"
#import "TransitionController.h"
#import "CitySelectionViewController.h"
#import "ResultsViewController.h"
#import "SpinnerObject.h"

@interface SearchViewController () <UITextFieldDelegate, UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *containers;
@property (weak, nonatomic) IBOutlet TextField *fromTextField;
@property (weak, nonatomic) IBOutlet TextField *toTextField;
@property (weak, nonatomic) IBOutlet TextField *travelDateTextField;
@property (weak, nonatomic) IBOutlet TextField *returnDateTextField;
@property (weak, nonatomic) IBOutlet CheckBox *checkBox;
@property (weak, nonatomic) IBOutlet UILabel *fromAirportCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toAirportCodeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *datePickerBottomConstraint;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *fade;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIView *destinationContainer;

@property (weak, nonatomic) IBOutlet UIView *placeholder;
@property (weak, nonatomic) IBOutlet SpinnerObject *spinner;
@end

@implementation SearchViewController
{
    UITextField *selectedDateTextField;
    UITextField *selectedDestinationTextField;
    NSString *selectedCityCodeFrom;
    NSString *selectedCityCodeTo;
    NSDate *selectedDepartureDate;
    NSDate *selectedReturningDate;
    TransitionController *transition;
    
    ResultsViewController *result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.layer.cornerRadius = 5;
    
    self.returnDateTextField.userInteractionEnabled = NO;
    
    for (UIView *view in self.containers) {
        view.layer.cornerRadius = 5;
    }
    
    self.datePickerBottomConstraint.constant = -200;
    [self.datePicker setMinimumDate:[NSDate date]];
    
    self.placeholder.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (IBAction)closeButtonHandler:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)enableReturnButtonHandler:(UIButton *)sender
{
    if (sender.tag == 0) {
        sender.tag = 1;
        self.checkBox.color = mainGreenColor;
        self.checkBox.isChecked = YES;
        self.returnDateTextField.placeholderColor = mainGrayColor;
        self.returnDateTextField.userInteractionEnabled = YES;
    } else {
        sender.tag = 0;
        self.checkBox.color = [UIColor lightGrayColor];
        self.checkBox.isChecked = NO;
        self.returnDateTextField.placeholderColor = [UIColor lightGrayColor];
        self.returnDateTextField.userInteractionEnabled = NO;
        self.returnDateTextField.text = @"";
        selectedReturningDate = nil;
    }
}

- (IBAction)datePickerDoneButton:(id)sender
{
    if (selectedDateTextField == self.travelDateTextField) {
        selectedDepartureDate = self.datePicker.date;
    } else {
        selectedReturningDate = self.datePicker.date;
    }
    
    NSDateFormatter *df = [NSDateFormatter new];
    df.locale = [NSLocale currentLocale];
    [df setDateFormat:@"dd LLLL YYYY,"];
    NSString* datePart = [df stringFromDate:self.datePicker.date];
    [df setDateFormat:@"EEEE"];
    NSString *dayName = [df stringFromDate:self.datePicker.date];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:datePart attributes:@{NSForegroundColorAttributeName : mainPurpleColor, NSFontAttributeName : [UIFont systemFontOfSize:17 weight:UIFontWeightLight]}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:string(@" %@", dayName)
                                                                             attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:17 weight:UIFontWeightLight]}]];
    selectedDateTextField.attributedText = attributedString;
    
    self.datePickerBottomConstraint.constant = -200;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)searchButtonHandler:(id)sender
{
    BOOL valid = YES;
    if (!selectedCityCodeTo) {
        [self.fromTextField shake];
        valid = NO;
    }
    if (!selectedCityCodeFrom) {
        [self.toTextField shake];
        valid = NO;
    }
    if (!selectedDepartureDate) {
        [self.travelDateTextField shake];
        valid = NO;
    }
    if (!valid) {
        return;
    }
    
    [UIView animateWithDuration:0.15 animations:^{
        self.scrollView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        } completion:^(BOOL finished){
            self.placeholder.hidden = NO;
            [self.spinner starAnimation];
            
            self.scrollView.transform = CGAffineTransformMakeScale(1, 1);
            
            [[RequestManager sharedInstance] getOffersFrom:selectedCityCodeFrom to:selectedCityCodeTo departureDate:selectedDepartureDate returningDate:selectedReturningDate completion:^(NSArray *offers, BOOL success){
                
                if (offers && success) {
                    
                    result = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
                    result.single = selectedReturningDate == nil;
                    result.offers = offers;
                    result.fromCode = selectedCityCodeFrom;
                    result.toCode = selectedCityCodeTo;
                    if (selectedReturningDate) {
                        NSDateFormatter *df = [NSDateFormatter new];
                        df.locale = [NSLocale currentLocale];
                        [df setDateFormat:@"dd LLLL"];
                        NSString* depart = [df stringFromDate:selectedDepartureDate];
                        NSString* ret = [df stringFromDate:selectedReturningDate];
                        
                        result.navbarText = string(@"%@ - %@, %@ - %@", selectedCityCodeFrom, selectedCityCodeTo, depart, ret);
                    } else {
                        NSDateFormatter *df = [NSDateFormatter new];
                        df.locale = [NSLocale currentLocale];
                        [df setDateFormat:@"dd LLLL"];
                        NSString* depart = [df stringFromDate:selectedDepartureDate];
                        
                        result.navbarText = string(@"%@ - %@, %@", selectedCityCodeFrom, selectedCityCodeTo, depart);
                    }
                    result.transitioningDelegate = self;
                    result.modalPresentationStyle = UIModalPresentationCustom;
                    
                    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:4];
                } else {
                    if (offers && offers.count == 0) {
                        [self showAlertwithTitle:LS(@"Nothing found") message:LS(@"Try to change the date") cancelTitle:LS(@"Done") otherButtonsTitles:nil animated:YES completitionBlock:nil];
                    }
                    self.placeholder.hidden = YES;
                    [self.spinner stopAnimation];
                }
            }];
        }];
    }];
}

- (void)stopLoading
{
    self.placeholder.hidden = YES;
    [self.spinner stopAnimation];
    
    transition = [TransitionController new];
    transition.resultsTransition = YES;
    
    [self presentViewController:result animated:YES completion:nil];
}

- (IBAction)switchDestinationsHandler:(id)sender
{
    if (self.fromTextField.text.length || self.toTextField.text.length) {
        [UIView transitionWithView:self.destinationContainer duration:0.25 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            NSString *tmp = self.fromAirportCodeLabel.text;
            self.fromAirportCodeLabel.text = self.toAirportCodeLabel.text;
            self.toAirportCodeLabel.text = tmp;
            
            tmp = self.fromTextField.text;
            self.fromTextField.text = self.toTextField.text;
            self.toTextField.text = tmp;
            
            tmp = selectedCityCodeFrom;
            selectedCityCodeFrom = selectedCityCodeTo;
            selectedCityCodeTo = tmp;
        }completion:nil];
    }
}

#pragma mark - textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == self.travelDateTextField || textField == self.returnDateTextField) {
        if (textField == self.travelDateTextField) {
            [self.datePicker setMinimumDate:[NSDate date]];
        } else {
            
        }
        selectedDateTextField = textField;
        self.datePickerBottomConstraint.constant = 0;
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else {
        selectedDestinationTextField = textField;
        
        CitySelectionViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CitySelectionViewController"];
        vc.completion = ^(NSDictionary *city) {
            textField.text = city[@"name"];
            if (textField == self.fromTextField) {
                selectedCityCodeFrom = city[@"code"];
                self.fromAirportCodeLabel.text = city[@"code"];
            } else {
                selectedCityCodeTo = city[@"code"];
                self.toAirportCodeLabel.text = city[@"code"];
            }
        };
        
        transition = [TransitionController new];
        transition.startingPoint = CGPointMake(self.view.center.x, selectedDestinationTextField.center.y + 90);
        transition.transitionMode = TransitionModePresent;
        transition.fade = self.fade;
        transition.citySelectionTransition = YES;
        
        vc.transitioningDelegate = self;
        vc.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark - UIViewControllerTransitionDelegate -

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    transition.transitionMode = TransitionModePresent;
    return transition;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    transition.transitionMode = TransitionModeDismiss;
    return transition;
}

@end
