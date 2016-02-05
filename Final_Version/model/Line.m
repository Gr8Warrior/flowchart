//
//  Line.m
//  Shapes
//
//  Created by MobileApp on 11/3/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "Line.h"

@implementation Line
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
 //Line
   
 //CGContextRef is a struct represents Quarttz 2D drawing destination and is equivalent to canvas
 CGContextRef ctx = UIGraphicsGetCurrentContext ();

 //returns with a specified co-ordinates
 CGPoint points [] = {
 CGPointMake (0, 0.48* self.bounds.size.height),
 CGPointMake ( 0 , self.bounds.size.height*.52),
 CGPointMake ( self.bounds.size.width*.9,self.bounds.size.height*.52  ),
 CGPointMake ( self.bounds.size.width*.9, 0.48*self.bounds.size.height),
 
 };
 
 CGPoint points1 [] = {
 CGPointMake ( .9* self.bounds.size.width , self.bounds.size . height*.4 ),
 CGPointMake (self.bounds.size . width  ,self.bounds.size.height * .5),
 CGPointMake (self.bounds.size . width *.9 , self.bounds.size . height *.6)
 };
 
 //Adds a sequence of Connected straight line segments to the current path
 //4=no. of elements in the points array
 CGContextAddLines (ctx, points, 4 );
 CGContextAddLines (ctx, points1, 3 );
 
 //paints the current path
 CGContextFillPath (ctx);
}


@end
