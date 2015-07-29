//
//  NRKLoginRequester.m
//  iOSPlayground
//
//  Created by noark on 7/29/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import "NRKLoginRequester.h"

NSString *const kNRKLoginErrorDomain = @"com.arkforce.iosplayground.loginrequest";

@interface NRKLoginRequester ()

@property (nonatomic) BOOL cancle;

@end

@implementation NRKLoginRequester

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cancle = NO;
    }
    return self;
}

- (void)cancleAll
{
    self.cancle = YES;
}

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password onComplete:(void (^)(BOOL, NSError *))complete
{
    if (!complete || self.cancle) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.cancle) {
            return;
        }
        if ([username isEqualToString:@"noark"] && [password isEqualToString:@"3399"]) {
            complete(YES, nil);
        } else {
            complete(NO, [NSError errorWithDomain:kNRKLoginErrorDomain code:-999 userInfo:@{@"info": @"Password error"}]);
        }
    });
}

@end
