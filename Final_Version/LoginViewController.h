//
//  LoginViewController.h
//  Sign_Up
//
//  Created by MobileApp on 12/17/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionHelper.h"
#import "ProjectListTableViewController.h"
@interface LoginViewController : UIViewController
- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property NSString *credentials;
@property bool validCredentials;
-(IBAction)unwindToList:(UIStoryboardSegue *)segue;
@end
