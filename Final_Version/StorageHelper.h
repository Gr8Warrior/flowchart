//
//  StorageHelper.h
//  last
//
//  Created by MobileApp on 11/17/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface StorageHelper : NSObject
-(void)saveToJsonFile:(NSString *) fileName :(NSDictionary *) tempShapesDictionary :(NSString *)credentials;
-(void)saveToServer:(NSString *) fileName :(NSDictionary *) tempShapesDictionary :(NSString *)credentials;
@end
