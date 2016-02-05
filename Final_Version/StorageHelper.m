//
//  StorageHelper.m
//  last
//
//  Created by MobileApp on 11/17/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "StorageHelper.h"

@implementation StorageHelper
-(void)saveToJsonFile:(NSString*)fileName :(NSDictionary *)tempShapesDictionary :(NSString *)credentials{
    NSError *error;
    NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:credentials];

    [[NSFileManager defaultManager] removeItemAtPath:[path stringByAppendingPathComponent:fileName]   error:&error];
    NSLog(@"%@",path);
    NSData *json=[NSJSONSerialization dataWithJSONObject: tempShapesDictionary options:NSJSONWritingPrettyPrinted error:&error];
    if (!json) {
        NSLog(@"JSON error: %@", error);
    } else {
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[json bytes] length:[json length] encoding:NSUTF8StringEncoding];
        NSLog(@"JSON OUTPUT: %@",JSONString);
    }
    
    path=[path stringByAppendingPathComponent:fileName
                    ];
    [[NSFileManager defaultManager] createFileAtPath:path contents:json attributes:nil];
}

-(void)saveToServer:(NSString*)fileName :(NSDictionary *)tempShapesDictionary :(NSString *)credentials{
    
    if ( [self checkForNetwork]) {
        NSLog(@"Network available");
    }
    NSString *uri=@"http://192.168.4.97:8081/InTimeFlow/webapi/IntimeFlow";
    NSString *appendFile=[@"/" stringByAppendingString:fileName];
    NSString *fullPath=[uri stringByAppendingString:appendFile];
        fullPath=[fullPath stringByAppendingString:@"_"];
        fullPath=[fullPath stringByAppendingString:credentials];
    NSURL *url=[NSURL URLWithString:fullPath];
    NSLog(@"%@",fullPath);
    NSError *error;
    NSData *json=[NSJSONSerialization dataWithJSONObject: tempShapesDictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *Post=[[NSString alloc]initWithData:json encoding:NSUTF8StringEncoding];
    if (!json) {
        NSLog(@"JSON error: %@",error);
    } else {
        
        Post = [[NSString alloc] initWithBytes:[json bytes] length:[json length] encoding:NSUTF8StringEncoding];
    }
    
    NSData *PostData = [Post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:PostData];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        
        // parse the JSON into Foundation objects
        NSString *str= [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        
    }];
    
    
}

- (BOOL)checkForNetwork
{
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"http://restservice-4mm3zyftrs.elasticbeanstalk.com/webapi/IntimeFlow"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    switch (myStatus) {
        case NotReachable:
            NSLog(@"There's no internet connection at all. Display error message now.");
            return false;
            break;
            
        case ReachableViaWWAN:
            NSLog(@"We have a 3G connection");
            return false;
            break;
            
        case ReachableViaWiFi:
            NSLog(@"We have WiFi.");
            return false;
            break;
            
        default:
            break;
    }
}

@end
