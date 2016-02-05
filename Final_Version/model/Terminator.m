//
//  Terminator.m
//  Final_Version
//
//  Created by MobileApp on 11/13/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "Terminator.h"

#define DegreesToRadians(x) ((x) * M_PI / 180.0)
@implementation Terminator


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Sets the line width for the graphics context
    CGContextSetLineWidth(context, 2.0);
    
    //Sets the current stroke color in a context using a quartz color
    CGContextSetStrokeColorWithColor(context,
                                     [UIColor blackColor].CGColor);
    
    CGRect rectangle = CGRectMake(rect.origin.x+2,rect.origin.y*.1+2,rect.size.width*.9,rect.size.height*.9);
    
    //Adds the ellipse that fits inside the rectangle
    CGContextAddEllipseInRect(context, rectangle);
    
    CGContextStrokePath(context);
    
}


@end
