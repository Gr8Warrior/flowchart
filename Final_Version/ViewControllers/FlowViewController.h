//
//  FlowViewController.h
//  Final_Version
//
//  Created by MobileApp on 11/10/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "ViewController.h"
#import "Line.h"
#import "Diamond.h"
#import "Rectangle.h"
#import "Rhombus.h"
#import "Terminator.h"
#import "Label.h"
#import "StorageHelper.h"

@interface FlowViewController : ViewController{
    NSInteger currentShape;
    int rotate;
}
@property NSString *projectName;
- (IBAction)line:(id)sender;
- (IBAction)rectangle:(id)sender;
- (IBAction)diamond:(id)sender;
- (IBAction)terminator:(id)sender;
- (IBAction)rhombus:(id)sender;
- (IBAction)database:(id)sender;
- (IBAction)text:(id)sender;
- (IBAction)save:(id)sender;
@property NSString *credentials;
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event ;
@end
