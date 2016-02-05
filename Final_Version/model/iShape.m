//
//  iShape.m
//  Shapes
//
//  Created by MobileApp on 10/30/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "iShape.h"

#define DegreesToRadians(x) ((x) * M_PI / 180.0)
@implementation iShape
@synthesize x,y,text,data;
@synthesize uniqueId;
-(id) initWithFrame:(CGRect)frame :(NSNumber *) uId :(NSNumber *) angle
{
    self =[super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.x = [NSNumber numberWithFloat:frame.origin.x]  ;
        self.y = [NSNumber numberWithFloat:frame.origin.y]  ;
        self.uniqueId = uId;
        self.height =[NSNumber numberWithFloat:frame.size.height]  ;
        self.width =[NSNumber numberWithFloat:frame.size.width]  ;
        self.angle =angle;
        text= [[UITextField alloc] initWithFrame:CGRectMake(10, 10, frame.size.width, frame.size.height-15)];

        text.textColor = [UIColor colorWithRed:0/256.0 green:84/256.0 blue:129/256.0 alpha:1.0];
        text.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
        text.backgroundColor=[UIColor clearColor];
        text.text=@" ";
        [self addSubview:text];
     
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

-(NSDictionary *) getDictionary{
    
    NSMutableDictionary *dictionary=[NSMutableDictionary new];
    [dictionary setObject:self.x forKey:@"x"];
    [dictionary setObject:self.y forKey:@"y"];
    [dictionary setObject:self.uniqueId forKey:@"uniqueId"];
    [dictionary setObject:self.height forKey:@"height"];
    [dictionary setObject:self.width forKey:@"width"];
    [dictionary setObject:self.angle forKey:@"angle"];
    [dictionary setObject:self.uniqueId forKey:@"uniqueId"];
    [dictionary setObject:[[self class] description] forKey:@"type"];
    return dictionary;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
}

@end
