//
//  Diamond.m
//  Shapes
//
//  Created by MobileApp on 10/30/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "Diamond.h"

@implementation Diamond

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // triangle
    
    CGContextRef ctx = UIGraphicsGetCurrentContext ();
    CGPoint points [] = {
        CGPointMake ( 0 ,self.bounds.size . height * 0.5),
        CGPointMake ( self.bounds.size . width * 0.5 , 0 ),
        CGPointMake ( self.bounds.size . width , self.bounds.size . height * 0.5),
        CGPointMake ( self.bounds.size . width * 0.5 ,  self.bounds.size . height  ),
        CGPointMake ( 0 ,self.bounds.size . height * 0.5),
    };
    CGContextAddLines (ctx, points, 5 );
    CGContextStrokePath (ctx);
}


@end
