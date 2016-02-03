//
//  DLVCView.m
//  iOSPlayground
//
//  Created by noark on 15/11/24.
//  Copyright © 2015年 noark. All rights reserved.
//

#import "DLVCView.h"

@implementation DLVCView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIButton *subview in self.subviews) {
        if (subview.tag == 998 && [subview isKindOfClass:[UIButton class]]) {
            return [subview hitTest:CGPointZero withEvent:event];
        }
    }
    return nil;
}

@end
