//
//  SignUpViewController.h
//  Sign_Up
//
//  Created by MobileApp on 12/17/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionHelper.h"
@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property NSString *response;

- (IBAction)signUp:(id)sender;

@end
