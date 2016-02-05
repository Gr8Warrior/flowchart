//
//  SignUpViewController.m
//  Sign_Up
//
//  Created by MobileApp on 12/17/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize firstName,lastName,userName,password;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)prepareForUnwind:(UIStoryboardSegue *)segue {
    
}

- (IBAction)signUp:(id)sender {
    
    if (firstName.text.length==0 || lastName.text.length==0 || userName.text.length == 0 || password.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:
                                  @"Complete Details" message:@"Please Enter all the Credentials" delegate:self
                                                 cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
        return;
    }
    
    NSString *submitBody= [[ userName.text stringByAppendingString:@"_"] stringByAppendingString: password.text];
    
    NSString *uri=@"http://192.168.4.97:8080/UserModule/webapi/myresource/saveData";
    NSString *appendFile=[@"/" stringByAppendingString:submitBody];
    NSString *fullPath=[uri stringByAppendingString:appendFile];
    // NSURL *url=[NSURL URLWithString:fullPath];
    NSLog(@"%@",fullPath);
    ConnectionHelper *connection =[ ConnectionHelper new];
    NSLog(@"%@",[connection connection:fullPath]);
    if ([[connection connection:fullPath] isEqual: @"done"]) {
        NSLog(@"directory created");
        NSString *path= [NSTemporaryDirectory() stringByAppendingString:[@"/" stringByAppendingString: submitBody]];
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil ];
        [self performSegueWithIdentifier:@"BackToLogin" sender:self];
    }
    
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
