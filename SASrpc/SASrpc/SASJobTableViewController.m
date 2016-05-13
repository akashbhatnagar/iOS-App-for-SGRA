//
//  SASJobTableViewController.m
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/27/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import "SASJobTableViewController.h"
#import "WPXMLRPC/WPXMLRPCDecoder.h"
#import "SASRecoveryEvent.h"
#import "SASTableViewCell.h"
#import "SASJob.h"
#import "SASJobDetailViewController.h"



@interface SASJobTableViewController ()

@property (strong,nonatomic) NSMutableArray *jobArray;
@property (strong,nonatomic) NSArray *sortedJobArray;


@end

@implementation SASJobTableViewController

-(instancetype) init
{
    [NSException raise:@"SASJobTableViewController initialization" format:@"Use initWithEventId"];
    
    return nil;
}

-(instancetype) initWithEventId:(int) eventId
{
    
    self = [super init];
    
    if(self){
        
        NSBundle *applicationBundle = [NSBundle mainBundle];
        
        NSString *path = [applicationBundle pathForResource:@"recoveryJobs" ofType:@"txt"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:data];
        
        if ([decoder isFault]) {
            NSLog(@"XML-RPC error %ld: %@", (long)[decoder faultCode], [decoder faultString]);
        } else {
            //NSLog(@"XML-RPC response: %@", [decoder object]);
            
            NSDictionary *dataDictionary = [decoder object];
            NSArray *dataArray = [dataDictionary objectForKey:@"jobs"];
            
            self.jobArray = [NSMutableArray array];
            
            //iterate through all the events and display
            for ( NSDictionary *dict in dataArray){
                
                SASJob *job = [[SASJob alloc] init];
                job.machineCommonName = [dict objectForKey:@"machine_common_name"];
                job.displayParameters = [dict objectForKey:@"display_parameters"];
                job.jobId = [[dict objectForKey:@"id"] intValue];
                job.state = [dict objectForKey:@"state"];
                NSDictionary *paramsDict = [dict objectForKey:@"params"];
                //host info
                NSDictionary *hostDict = [paramsDict objectForKey:@"HOST_INFORMATION"];
                job.hostname = [hostDict objectForKey:@"hostname"];
                
                //OS info
                NSDictionary *osDict = [paramsDict objectForKey:@"OS"];
                job.os = [osDict objectForKey:@"name"];
                job.edition = [osDict objectForKey:@"ed"];
                job.servicePack = [[osDict objectForKey:@"sp"] intValue];
                job.cpuArch = [osDict objectForKey:@"hwarch"];
            
                
                //Partition info
                
                //network
                NSDictionary *networkDict = [paramsDict objectForKey:@"network"];
                job.nic1IPAddress = [networkDict objectForKey:@"nic1_ip_address"];
                
                
                [self.jobArray addObject:job];
                
                
            }
            
            //NSLog(@"Jobs: %@", self.jobArray);
            NSLog(@"Count: %lu",(unsigned long)[self.jobArray count]);
            
           // self.sectionEventArray  = [NSMutableArray array];
            
            NSSortDescriptor *jobIdSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"jobId"
                                                                                      ascending:YES];
            
            self.sortedJobArray = [self.jobArray sortedArrayUsingDescriptors:@[jobIdSortDescriptor]];
            
            //dereference jobArray
            self.jobArray = nil;
            
            self.navigationItem.title = @"Jobs";
            
            /*
            
            //create the sorted arrays for various sections based on the states and start date/end date
            
            //pending events
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"state = 'pending'"];
            self.pendingEventArray = [[self.eventArray filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:@[startDateSortDescriptor, endDateSortDescriptor]];
            
            if([self.pendingEventArray count] != 0){
                [self.sectionEventArray addObject:self.pendingEventArray];
            }
            
            //setup events
            predicate = [NSPredicate predicateWithFormat:@"state = 'setup'"];
            self.setupEventArray = [[self.eventArray filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:@[startDateSortDescriptor, endDateSortDescriptor]];
            
            if([self.setupEventArray count] != 0){
                [self.sectionEventArray addObject:self.setupEventArray];
            }
            
            //ready events
            predicate = [NSPredicate predicateWithFormat:@"state = 'ready'"];
            self.readyEventArray = [[self.eventArray filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:@[startDateSortDescriptor, endDateSortDescriptor]];
            
            if([self.readyEventArray count] != 0){
                [self.sectionEventArray addObject:self.readyEventArray];
            }
            
            //teardown events
            predicate = [NSPredicate predicateWithFormat:@"state = 'teardown'"];
            self.teardownEventArray = [[self.eventArray filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:@[startDateSortDescriptor, endDateSortDescriptor]];
            
            if([self.teardownEventArray count] != 0){
                [self.sectionEventArray addObject:self.teardownEventArray];
            }
            
            //end events
            predicate = [NSPredicate predicateWithFormat:@"state = 'end'"];
            self.endEventArray = [[self.eventArray filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:@[startDateSortDescriptor, endDateSortDescriptor]];
            
            
            if([self.endEventArray count] != 0){
                [self.sectionEventArray addObject:self.endEventArray];
            }
            
            predicate = [NSPredicate predicateWithFormat:@"state = 'exception'"];
            self.exceptionEventArray = [[self.eventArray filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:@[startDateSortDescriptor, endDateSortDescriptor]];
            
            if([self.exceptionEventArray count] != 0 ){
                [self.sectionEventArray addObject:self.exceptionEventArray];
            }
            
            
            
            
            //UIImage *i = [UIImage imageNamed:@"Hypno.png"];
            
            //self.tabBarItem.image = i;
            */
            
        }

        
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[SASTableViewCell class] forCellReuseIdentifier:@"SASTableViewCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the state of the event-- get this from the first event object in the array
    
    //NSString *label = [re.state isEqualToString:@"end"] ? @"done": re.state;
    //return [[NSString alloc] initWithFormat:@"%@ (%lu)",label,count];
    
    return self.event.customerName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.sortedJobArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SASTableViewCell" forIndexPath:indexPath];
    
    
    SASJob *job = [self.sortedJobArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = job.machineCommonName;
    
    cell.detailTextLabel.text = job.displayParameters;
    
   cell.textLabel.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
  cell.detailTextLabel.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
    
    
    // Configure the cell...
    
    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    SASJobDetailViewController *jobDetailViewController = [[SASJobDetailViewController alloc]init];
    
    // Pass the selected object to the new view controller.
    jobDetailViewController.event = self.event;
    
    jobDetailViewController.job = [self.sortedJobArray objectAtIndex:indexPath.row];
    
    // Push the view controller.
    [self.navigationController pushViewController:jobDetailViewController animated:YES];
}


@end
