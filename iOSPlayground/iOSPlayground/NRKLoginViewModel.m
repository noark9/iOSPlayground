//
//  NRKLoginViewModel.m
//  iOSPlayground
//
//  Created by noark on 7/29/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import "NRKLoginViewModel.h"
#import "NRKLoginRequester.h"

#import "ReactiveCocoa.h"

@interface NRKLoginViewModel ()

@property (nonatomic) BOOL loading;

@property (strong, nonatomic) RACCommand *loginCommand;
@property (strong, nonatomic) RACCommand *resetCommand;

@property (strong, nonatomic) RACSignal *loadingSignal;
@property (strong, nonatomic) NRKLoginRequester *loginRequester;
@property (copy, nonatomic) RACSignal *loginFinishSignal;

@end

@implementation NRKLoginViewModel

+ (instancetype)viewModel
{
    id viewModel = [[self alloc] init];
    return viewModel;
}

- (instancetype)init
{
    if (self = [super init]) {
        // init code
        [self configViewModel];
    }
    
    return self;
}

- (void)configViewModel
{
    RACSignal *usernameSignal = RACObserve(self, usernameString);
    RACSignal *passwordSignal = RACObserve(self, passwordString);
    self.loadingSignal = RACObserve(self, loading);
    
    RACSignal *resetCommandEnableSignal = [RACSignal combineLatest:@[usernameSignal, passwordSignal, self.loadingSignal] reduce:^id(NSString *username, NSString *password, NSNumber *loadingValue) {
        if ([loadingValue boolValue]) {
            return @(NO);
        }
        return @(username.length > 0 || password.length > 0);
    }];
    RACSignal *loginCommandEnableSignal = [RACSignal combineLatest:@[usernameSignal, passwordSignal, self.loadingSignal] reduce:^id(NSString *username, NSString *password, NSNumber *loadingValue) {
        if ([loadingValue boolValue]) {
            return @(NO);
        }
        return @(username.length > 0 && password.length > 0);
    }];
    @weakify(self);
    self.resetCommand = [[RACCommand alloc] initWithEnabled:resetCommandEnableSignal signalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            self.usernameString = @"";
            self.passwordString = @"";
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    self.loginCommand = [[RACCommand alloc] initWithEnabled:loginCommandEnableSignal signalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            self.loading = YES;
            self.loginRequester = [[NRKLoginRequester alloc] init];
            [self.loginRequester loginWithUsername:self.usernameString andPassword:self.passwordString onComplete:^(BOOL successed, NSError *error) {
                self.loading = NO;
                if (successed) {
                    NSLog(@"successed");
                } else {
                    NSLog(@"login error %@", error);
                }
            }];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    self.loading = NO;
}

@end
