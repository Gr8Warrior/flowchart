//
//  ConnectionHelper.m
//  Sign_Up
//
//  Created by MobileApp on 12/17/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "ConnectionHelper.h"

@implementation ConnectionHelper
@synthesize validate;
-(NSString *)connection:(NSString *)fullPath{
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:fullPath]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:10
     ];
    
    [request setHTTPMethod: @"GET"];
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session dataTaskWithURL:[NSURL URLWithString:fullPath]
//            completionHandler:^(NSData *data,
//                                NSURLResponse *response,
//                                NSError *error) {
//               NSString *str= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSHTTPURLResponse *res=  (NSHTTPURLResponse *)response;
//                if ([res statusCode]!=200) {
//                    NSLog(@"Unable to sign-Up, Please try after some time");
//                }
//                NSLog(@"%@ ",str);
//            }] resume];
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSString *str1= [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@ Response ",str1);
    return str1;
}
@end
