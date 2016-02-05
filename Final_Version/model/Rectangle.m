//
//  Rectangle.m
//  Shapes
//
//  Created by MobileApp on 10/30/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "Rectangle.h"

@implementation Rectangle



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    rect = CGRectMake(rect.origin.x+5, rect.origin.y+5, rect.size.width-5, rect.size.height-5);
//    UITextField *text=[[UITextField alloc]initWithFrame:rect];
//    text.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
//    text.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
//    text.backgroundColor=[UIColor redColor];
//    [self addSubview:text];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext ();
    CGPoint points [] = {
        CGPointMake (0, 0 ),
        CGPointMake ( 0 , self.bounds.size.width),
        CGPointMake ( self.bounds.size.height,  self.bounds.size.width ),
        CGPointMake ( self.bounds.size.height, 00),
        CGPointMake (0, 0 ),
    };
    CGContextAddLines (ctx, points, 5 );
    CGContextStrokePath (ctx);
}


@end
