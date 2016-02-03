//
//  NRKLoginViewController.m
//  iOSPlayground
//
//  Created by noark on 7/29/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import "ReactiveCocoa.h"

#import "NRKLoginViewController.h"
#import "NRKLoginViewModel.h"

@interface NRKLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *loadingView;

@end

@implementation NRKLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self bindViewModel];
}

- (void)bindViewModel
{
    self.viewModel = [NRKLoginViewModel viewModel];
    RACChannelTerminal *usernameChannelToUI = self.usernameTextField.rac_newTextChannel;
    RACChannelTerminal *usernameChannelToVM = RACChannelTo(self.viewModel, usernameString);
    [usernameChannelToUI subscribe:usernameChannelToVM];
    [usernameChannelToVM subscribe:usernameChannelToUI];
    
    RACChannelTerminal *passwordChannelToUI = self.passwordTextField.rac_newTextChannel;
    RACChannelTerminal *passwordChannelToVM = RACChannelTo(self.viewModel, passwordString);
    [passwordChannelToUI subscribe:passwordChannelToVM];
    [passwordChannelToVM subscribe:passwordChannelToUI];
    
    RAC(self.loadingView, hidden) = [self.viewModel.loadingSignal not];
    
    self.resetButton.rac_command = self.viewModel.resetCommand;
    self.loginButton.rac_command = self.viewModel.loginCommand;
}

@end
