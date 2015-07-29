//
//  NRKFakeGeocoder.h
//  iOSPlayground
//
//  Created by noark on 7/30/15.
//  Copyright © 2015 noark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRKFakeGeocoder : NSObject

+ (void)geocodeOnComplete:(void (^)())complete;

@end
