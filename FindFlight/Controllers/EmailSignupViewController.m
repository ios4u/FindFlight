//
//  EmailSignupViewController.m
//  FindFlight
//
//  Created by spens on 28/02/16.
//  Copyright © 2016 ru.spens. All rights reserved.
//

#import "EmailSignupViewController.h"
#import "POP.h"

@interface EmailSignupViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet TextField *nameTextField;
@property (weak, nonatomic) IBOutlet TextField *middleTextField;
@property (weak, nonatomic) IBOutlet TextField *lastTextField;
@property (weak, nonatomic) IBOutlet Divider *nameDivider;
@property (weak, nonatomic) IBOutlet TextField *emailTextField;
@property (weak, nonatomic) IBOutlet Divider *emailDivider;
@property (weak, nonatomic) IBOutlet TextField *passwordTextField;
@property (weak, nonatomic) IBOutlet Divider *passwordDivider;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CheckBox *checkBox;
@property (weak, nonatomic) IBOutlet UIButton *showPassButton;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *nameInfoLabels;
@property (weak, nonatomic) IBOutlet UILabel *emailInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastInfoLabel;

@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *signingupLabel;

@end

@implementation EmailSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillBeShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    float minSize = MIN(kbSize.width, kbSize.height);
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, minSize/3, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (IBAction)signupButtonHandler:(id)sender
{
    BOOL valid = YES;
    self.emailTextField.textColor = [UIColor whiteColor];
    if (!self.nameTextField.text.length)
    {
        self.nameDivider.color = mainRedColor;
        self.nameTextField.placeholderColor = mainRedColor;
        valid = NO;
        
        [self.nameTextField shake];
    }
    if (!self.middleTextField.text.length) {
        self.middleTextField.placeholderColor = mainRedColor;
        valid = NO;
        
        [self.middleTextField shake];
    }
    if (!self.lastTextField.text.length) {
        self.lastTextField.placeholderColor = mainRedColor;
        valid = NO;
        
        [self.lastTextField shake];
    }
    if (!self.emailTextField.text.length) { //|| ![self.emailTextField.text isValidEmail]) {
        self.emailDivider.color = mainRedColor;
        self.emailTextField.placeholderColor = mainRedColor;
        self.emailTextField.textColor = mainRedColor;
        valid = NO;
        
        [self.emailTextField shake];
    }
    if (!self.passwordTextField.text.length) {
        self.passwordDivider.color = mainRedColor;
        self.passwordTextField.placeholderColor = mainRedColor;
        valid = NO;
        
        [self.passwordTextField shake];
    }
    if (!valid) {
        return;
    }
    
    [self.view endEditing:YES];

    UIView *v1 = [self.view resizableSnapshotViewFromRect:CGRectMake(0, 0, CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2) afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    v1.frame = CGRectMake(0, 0, v1.frame.size.width, v1.frame.size.height);
    UIView *v2 = [self.view resizableSnapshotViewFromRect:CGRectMake(CGRectGetWidth(self.view.frame)/2, 0, CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2) afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    v2.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, 0, v1.frame.size.width, v1.frame.size.height);
    UIView *v3 = [self.view resizableSnapshotViewFromRect:CGRectMake(0, CGRectGetHeight(self.view.frame)/2, CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2) afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    v3.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)/2, v1.frame.size.width, v1.frame.size.height);
    UIView *v4 = [self.view resizableSnapshotViewFromRect:CGRectMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2, CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2) afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    v4.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2, v1.frame.size.width, v1.frame.size.height);
    
    [self.loadingView addSubview:v1];
    [self.loadingView addSubview:v2];
    [self.loadingView addSubview:v3];
    [self.loadingView addSubview:v4];
    
    self.loadingView.hidden = NO;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame = v1.frame;
        frame.origin.x -= 300;
        frame.origin.y -= 300;
        v1.frame = frame;
        
        frame = v2.frame;
        frame.origin.x += 300;
        frame.origin.y -= 300;
        v2.frame = frame;
        
        frame = v3.frame;
        frame.origin.x -= 300;
        frame.origin.y += 300;
        v3.frame = frame;
        
        frame = v4.frame;
        frame.origin.x += 300;
        frame.origin.y += 300;
        v4.frame = frame;
    } completion:^(BOOL finished){
        [v1 removeFromSuperview];
        [v2 removeFromSuperview];
        [v3 removeFromSuperview];
        [v4 removeFromSuperview];
        
        UIView *fill = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.signingupLabel.frame), CGRectGetMinY(self.signingupLabel.frame), 0, CGRectGetHeight(self.signingupLabel.frame))];
        fill.backgroundColor = mainGreenColor;
        fill.clipsToBounds = YES;
        [self.loadingView addSubview:fill];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-CGRectGetWidth(self.signingupLabel.frame), 0, CGRectGetWidth(self.signingupLabel.frame), CGRectGetHeight(self.signingupLabel.frame))];
        label.textColor = mainPurpleColor;
        label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        label.text = @"SIGNING UP";
        [fill addSubview:label];
        
        [UIView animateWithDuration:0.75 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = fill.frame;
            frame.origin.x = 0;
            frame.size.width = CGRectGetWidth([UIScreen mainScreen].bounds);
            frame.origin.y = 0;
            frame.size.height = CGRectGetHeight([UIScreen mainScreen].bounds);
            fill.frame = frame;
            
            frame = label.frame;
            frame.origin.x = CGRectGetMinX(self.signingupLabel.frame);
            frame.origin.y = CGRectGetMinY(self.signingupLabel.frame);
            label.frame = frame;
        }completion:^(BOOL finished){
            self.loadingView.hidden = YES;
            UIViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"EnterViewController"];
            [self.navigationController pushViewController:vc2 animated:NO];
        }];
    }];
}

- (IBAction)backButtonHandler:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)legalButtonHandler:(id)sender
{

}

- (IBAction)showPassButtonHandler:(id)sender
{
    if (self.passwordTextField.secureTextEntry) {
        self.passwordTextField.secureTextEntry = NO;
        self.checkBox.isChecked = YES;
    } else {
        self.passwordTextField.secureTextEntry = YES;
        self.checkBox.isChecked = NO;
    }
}

- (void)updateInfoLabels
{
    self.firstInfoLabel.hidden = self.nameTextField.text.length == 0;
    self.middleInfoLabel.hidden = self.middleTextField.text.length == 0;
    self.lastInfoLabel.hidden = self.lastTextField.text.length == 0;
    self.passwordInfoLabel.hidden = self.passwordTextField.text.length == 0;
    self.emailInfoLabel.hidden = self.emailTextField.text.length == 0;
}

#pragma mark - textfields delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.nameTextField || textField == self.middleTextField || textField == self.lastTextField) {
        self.nameDivider.color = [UIColor whiteColor];
        self.nameTextField.placeholderColor = mainPurpleColor50;
        self.middleTextField.placeholder = @"Middle";
        self.lastTextField.placeholder = @"Last";
        self.middleTextField.placeholderColor = mainPurpleColor50;
        self.lastTextField.placeholderColor = mainPurpleColor50;
        
        self.firstInfoLabel.hidden = NO;
        self.middleInfoLabel.hidden = NO;
        self.lastInfoLabel.hidden = NO;
    }
    if (textField == self.emailTextField) {
        self.emailDivider.color = [UIColor whiteColor];
        self.emailTextField.placeholderColor = mainPurpleColor50;
        self.emailInfoLabel.hidden = NO;
    }
    if (textField == self.passwordTextField) {
        self.checkBox.hidden = NO;
        self.showPassButton.hidden = NO;
        self.passwordDivider.color = [UIColor whiteColor];
        self.passwordTextField.placeholderColor = mainPurpleColor50;
        self.passwordInfoLabel.hidden = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.nameTextField || textField == self.middleTextField || textField == self.lastTextField) {
        if (!self.nameTextField.text.length && !self.middleTextField.text.length && !self.lastTextField.text.length) {
            self.nameDivider.color = mainPurpleColor50;
        }
        self.nameTextField.placeholderColor = mainPurpleColor50;
        self.middleTextField.placeholder = @"Middle";
        self.lastTextField.placeholder = @"Last";
        self.nameTextField.placeholderColor = mainPurpleColor50;
        self.nameTextField.placeholderColor = mainPurpleColor50;
    }
    if (textField == self.emailTextField) {
        if (!self.emailTextField.text.length) {
            self.emailDivider.color = mainPurpleColor50;
        }
        self.emailTextField.placeholderColor = mainPurpleColor50;
    }
    if (textField == self.passwordTextField) {
        if (!self.passwordTextField.text.length) {
            self.checkBox.hidden = YES;
            self.showPassButton.hidden = YES;
            self.passwordDivider.color = mainPurpleColor50;
        }
        self.passwordTextField.placeholderColor = mainPurpleColor50;
    }
    [self updateInfoLabels];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self updateInfoLabels];
    
    return YES;
}

@end
