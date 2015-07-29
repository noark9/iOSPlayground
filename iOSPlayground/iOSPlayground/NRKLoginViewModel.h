//
//  NRKLoginViewModel.h
//  iOSPlayground
//
//  Created by noark on 7/29/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand, RACSignal, RACSubject;

@interface NRKLoginViewModel : NSObject

+ (instancetype)viewModel;

@property (copy, nonatomic) NSString *usernameString;
@property (copy, nonatomic) NSString *passwordString;


@property (strong, nonatomic, readonly) RACSignal *loadingSignal;
@property (strong, nonatomic, readonly) RACCommand *loginCommand;
@property (strong, nonatomic, readonly) RACCommand *resetCommand;
@property (copy, nonatomic, readonly) RACSignal *loginFinishSignal;

@end
