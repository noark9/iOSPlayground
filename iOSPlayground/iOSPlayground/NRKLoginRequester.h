//
//  NRKLoginRequester.h
//  iOSPlayground
//
//  Created by noark on 7/29/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kNRKLoginErrorDomain;

@interface NRKLoginRequester : NSObject

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password onComplete:(void (^)(BOOL successed, NSError *error))complete;
- (void)cancleAll;

@end
