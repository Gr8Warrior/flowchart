//
//  LoginViewController.m
//  Sign_Up
//
//  Created by MobileApp on 12/17/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize credentials;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(IBAction)unwindToList:(UIStoryboardSegue *)segue{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)submit:(id)sender {
    NSLog(@"%@", _userName.text);
    credentials= [[_userName.text stringByAppendingString:@"_"] stringByAppendingString:_password.text];
    
    NSString *uri=@"http://192.168.4.97:8080/UserModule/webapi/myresource";
    NSString *appendFile=[@"/" stringByAppendingString:credentials];
    NSString *fullPath=[uri stringByAppendingString:appendFile];
   // NSURL *url=[NSURL URLWithString:fullPath];
    NSLog(@"%@",fullPath);
    
    ConnectionHelper *connection =[ ConnectionHelper new];
    NSString *str=[connection connection:fullPath];
    NSLog(@"Return from connection %@",str);
    //if([[connection connection:fullPath] isEqual:@"YES"]){
    if (1) {
        
    NSLog(@"Valid Login");
        [self performSegueWithIdentifier:@"validLogin" sender:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Wrong Credentials" message:@"Please Enter Valid Credentials" delegate:self
                                                 cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
        NSLog(@"InValid Login");
    }

}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        NSLog(@"Alert button pressed");
    }
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"validLogin"]) {
//       credentials= [self.userName.text stringByAppendingString:@"_"];
//        credentials=[credentials stringByAppendingString:self.password.text];
//        ProjectListTableViewController *controller = (ProjectListTableViewController *)segue.destinationViewController;
//        controller.credentials = self.credentials;
//    }
    
    if ([segue.identifier isEqualToString:@"validLogin"]) {
        credentials= [self.userName.text stringByAppendingString:@"_"];
        credentials=[credentials stringByAppendingString:self.password.text];
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        ProjectListTableViewController *controller = (ProjectListTableViewController *)navController.topViewController;
        controller.credentials = self.credentials;
    }
    
}
@end
