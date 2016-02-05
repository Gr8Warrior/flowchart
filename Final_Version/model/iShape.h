//
//  iShape.h
//  Shapes
//
//  Created by MobileApp on 10/30/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iShape : UIView
@property NSNumber *x,*y;
@property NSNumber *uniqueId;
@property NSNumber *width;
@property NSNumber *height;
@property NSNumber *angle;
@property UITextField *text;
@property NSString *data;
-(NSDictionary *) getDictionary;
-(id) initWithFrame:(CGRect)frame :(NSNumber *) uId :(NSNumber *)angle;
@end
