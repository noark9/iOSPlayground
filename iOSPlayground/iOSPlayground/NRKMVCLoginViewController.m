//
//  NRKLoginViewController.m
//  iOSPlayground
//
//  Created by noark on 7/29/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import "NRKMVCLoginViewController.h"
#import "NRKLoginRequester.h"

@interface NRKMVCLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) NRKLoginRequester *loginRequester;

@end

@implementation NRKMVCLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)resetButtonPushed:(id)sender
{
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
    self.loginButton.enabled = NO;
    self.resetButton.enabled = NO;
}

- (IBAction)loginButtonPushed:(id)sender
{
    if (self.usernameTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        return;
    }
    self.loginRequester = [[NRKLoginRequester alloc] init];
    self.loadingView.hidden = NO;
    self.loginButton.enabled = NO;
    self.resetButton.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [self.loginRequester loginWithUsername:self.usernameTextField.text andPassword:self.passwordTextField.text onComplete:^(BOOL successed, NSError *error) {
        weakSelf.loadingView.hidden = YES;
        if (successed) {
            NSLog(@"success");
        } else {
            weakSelf.loginButton.enabled = YES;
            weakSelf.resetButton.enabled = YES;
            NSLog(@"error %@", error);
        }
    }];
}

- (void)textFieldDidEndEditing:(nonnull UITextField *)textField
{
    if (self.usernameTextField.text.length > 0 || self.passwordTextField.text.length > 0) {
        self.resetButton.enabled = YES;
    } else {
        self.resetButton.enabled = NO;
    }
    if (self.usernameTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        self.resetButton.enabled = YES;
    } else {
        self.resetButton.enabled = NO;
    }
}

@end
