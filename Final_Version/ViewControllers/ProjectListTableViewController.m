//
//  ProjectListTableViewController.m
//  ToDoList
//
//  Created by MobileApp on 10/28/15.
//  Copyright © 2015 MobileApp. All rights reserved.
//

#import "ProjectListTableViewController.h"

@interface ProjectListTableViewController ()
@property NSMutableArray *projectList;
@end

@implementation ProjectListTableViewController
@synthesize credentials;
-(IBAction)unwindToList:(UIStoryboardSegue *)segue {
    AddProjectViewController *source = [segue sourceViewController];
    if (source.fileName != nil && ![self.projectList containsObject:source.fileName] ) {
        [self.projectList addObject:source.fileName];
        NSString *path= [NSTemporaryDirectory() stringByAppendingString:[@"/" stringByAppendingString:self.credentials]];
        NSString *path1= [path stringByAppendingString:[@"/" stringByAppendingString:source.fileName]];
        [[NSFileManager defaultManager]createFileAtPath:path1 contents:nil attributes:nil];
        [self.tableView reloadData];
    }
}

//-(IBAction)userLogin:(UIStoryboardSegue *)segue {
//   LoginViewController *source = [segue sourceViewController];
//    if (source.credentials != nil) {
//        NSString *path= [NSTemporaryDirectory() stringByAppendingString:[@"/" stringByAppendingString: source.credentials ]];
//      //  [[NSFileManager defaultManager]createFileAtPath:path contents:nil attributes:nil];
//        NSLog(@"user Login");
//        NSError *error = nil;
//        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error: &error];
//        
//    }
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSTemporaryDirectory());
    self.projectList= [[NSMutableArray alloc]init];
    [self loadInitialData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.projectList count];
}

-(void) loadInitialData{
    NSString *path= [NSTemporaryDirectory() stringByAppendingString:[@"/" stringByAppendingString:self.credentials]];
    NSArray *directory=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (int i=1; i<[directory count]; i++) {
        [self.projectList addObject:[directory objectAtIndex:i]];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    cell.textLabel.text=[self.projectList objectAtIndex:indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSString *path1= [NSTemporaryDirectory() stringByAppendingString:[@"/" stringByAppendingString:self.credentials]];
        NSString *path= [path1 stringByAppendingString:[@"/" stringByAppendingString:[self.projectList objectAtIndex:indexPath.row]]];
        
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        
        [self.projectList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        // Request table view to reload
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view Delegate
/* -(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ProjectFile *tappedProject=[self.projectList objectAtIndex:indexPath.row];
   tappedProject.completed=!tappedProject.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"FlowViewControllerSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"%ld",indexPath.row);
        FlowViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.projectName = [self.projectList objectAtIndex:indexPath.row];
        destinationViewController.credentials = self.credentials;
    }
}
@end

