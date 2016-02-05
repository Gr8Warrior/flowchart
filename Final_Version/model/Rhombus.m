//
//  Rhombus.m
//  Shapes
//
//  Created by MobileApp on 10/30/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "Rhombus.h"

@implementation Rhombus


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext ();
    CGPoint points [] = {
//        CGPointMake (20, 0 ),
//        CGPointMake ( 0 , self.bounds.size.width*.5),
//        CGPointMake ( (self.bounds.size.height)-20,  .5*self.bounds.size.width  ),
//        CGPointMake ( self.bounds.size.height, 00),
//        CGPointMake ( 20, 0),
        CGPointMake (20, 0 ),
        CGPointMake ( 0 , self.bounds.size.width),
        CGPointMake ( (self.bounds.size.height)-20,  self.bounds.size.width  ),
        CGPointMake ( self.bounds.size.height, 00),
        CGPointMake ( 20, 0),
    };
    CGContextAddLines (ctx, points, 5);
    CGContextStrokePath (ctx);
}


@end
