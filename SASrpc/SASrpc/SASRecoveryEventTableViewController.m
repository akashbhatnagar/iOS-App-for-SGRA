//
//  SASRecoveryEventTableViewController.m
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/22/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import "SASRecoveryEventTableViewController.h"
#import "WPXMLRPC/WPXMLRPCDecoder.h"
#import "SASRecoveryEvent.h"
#import "SASTableViewCell.h"
#import "SASJobTableViewController.h"

@interface SASRecoveryEventTableViewController ()

@property (nonatomic,strong) NSMutableArray *eventArray;
@property (nonatomic,strong) NSArray *readyEventArray;
@property (nonatomic,strong) NSArray *endEventArray;
@property (nonatomic,strong) NSArray *setupEventArray;
@property (nonatomic,strong) NSArray *pendingEventArray;
@property (nonatomic,strong) NSArray *teardownEventArray;
@property (nonatomic,strong) NSArray *exceptionEventArray;

@property (nonatomic,strong) NSMutableArray *sectionEventArray;

@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,strong) UIColor *barColor;

@property (nonatomic,strong) UIColor *tabBarColor;


@end

@implementation SASRecoveryEventTableViewController

-(instancetype)init
{
    self = [super init];
    
    if(self){
        
//        NSArray *dir = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES);
        
       // NSString *downloadPath = dir[0];
        
      //  NSError *error;
        
        //NSString* responseStr = [NSString stringWithContentsOfFile:<#(NSString *)#> encoding:NSUTF8StringEncoding error:&error];
        
        //NSLog(@"response recieved: %@", responseStr);
        
        self.textColor = [UIColor whiteColor]; //white color
        self.barColor = [UIColor colorWithRed:38.0/255.0 green:63.0/255.0 blue:102/255.0 alpha:1]; //dark blue
        //self.tabBarColor = [UIColor colorWithRed:66.0/255.0 green:110.0/255.0 blue:155.0/255.0 alpha:0]; //light blue
        //self.tabBarColor = [UIColor colorWithRed:176.0/255.0 green:0.0/255.0 blue:20.0/255.0 alpha:0]; //light red
        
        NSBundle *applicationBundle = [NSBundle mainBundle];
        
        NSString *path = [applicationBundle pathForResource:@"recoveryEvent" ofType:@"txt"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:data];
        
        if ([decoder isFault]) {
            NSLog(@"XML-RPC error %ld: %@", (long)[decoder faultCode], [decoder faultString]);
        } else {
           // NSLog(@"XML-RPC response: %@", [decoder object]);
            
            NSArray *dataArray = [decoder object];
            self.eventArray = [NSMutableArray array];
            
            //iterate through all the events and display
            for ( NSDictionary *dict in dataArray){
                
                SASRecoveryEvent *event = [[SASRecoveryEvent alloc] init];
                event.customerName = [dict objectForKey:@"customer_name"];
                event.jobCount = [[dict objectForKey:@"job_count"] intValue];
                event.eventId = [[dict objectForKey:@"id"] intValue];
                event.state = [dict objectForKey:@"state"];
                event.startDate = [dict objectForKey:@"start_time"];
                event.endDate = [dict objectForKey:@"end_time"];
                event.hasError = [[dict objectForKey:@"has_error"] boolValue];
                
                [self.eventArray addObject:event];
                
            }
            
            //NSLog(@"Events: %@", self.eventArray);
            NSLog(@" Event count: %lu",(unsigned long)[self.eventArray count]);
            
            self.sectionEventArray  = [NSMutableArray array];
            
            NSSortDescriptor *startDateSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"startDate"
                                                                                      ascending:YES];
            NSSortDescriptor *endDateSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"endDate"
                                                                                     ascending:YES];
            
            
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
            
            
           self.navigationItem.title = @"Events";
            
            //UIImage *i = [UIImage imageNamed:@"Hypno.png"];
            
            //self.tabBarItem.image = i;
            
            
        }
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[SASTableViewCell class] forCellReuseIdentifier:@"SASTableViewCell"];
    
    
    //self.tabBarItem.title = @"Events";
//    self.navigationController.tabBarItem.title = @"Events";
//    
//    UIImage *i = [UIImage imageNamed:@"fires-25.png"];
//    //[i imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.navigationController.tabBarItem.image = i;
    
    self.navigationController.tabBarController.tabBar.tintColor = self.tabBarColor;
    //self.navigationController.tabBarController.tabBar.barTintColor = self.tabBarColor;
    
    
    
    NSMutableDictionary *colorDict = [[NSMutableDictionary alloc] init];
    
    [colorDict setValue:self.textColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = colorDict;
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = self.barColor;
    self.navigationController.navigationBar.tintColor = self.textColor;

    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    //return 1;
    return [ self.sectionEventArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    NSArray *array =  [self.sectionEventArray objectAtIndex:section];
    
    return [array count];
}


- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the state of the event-- get this from the first event object in the array
    NSArray *array =  [self.sectionEventArray objectAtIndex:section];
    NSUInteger count = [array count];
    SASRecoveryEvent *re = array[0];
    NSString *label = [re.state isEqualToString:@"end"] ? @"done": re.state;
    return [[NSString alloc] initWithFormat:@"%@ (%lu)",label,(unsigned long)count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SASTableViewCell" forIndexPath:indexPath];
    
    NSArray *array = self.sectionEventArray[indexPath.section];
    SASRecoveryEvent *recoveryEvent = [array objectAtIndex:indexPath.row];
    
    cell.textLabel.text = recoveryEvent.customerName;
    NSString *jobCount = [[[NSNumber alloc] initWithInt:recoveryEvent.jobCount] stringValue];
    
    NSString *jobCountText = [@"job count: " stringByAppendingString:jobCount];
    
    NSString *startTime = [@" start time: " stringByAppendingString:[NSDateFormatter localizedStringFromDate:recoveryEvent.startDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle]];
    
    NSString *endTime = [@" end time: " stringByAppendingString:[NSDateFormatter localizedStringFromDate:recoveryEvent.endDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle]];
    
    NSString *detailText = [[jobCountText stringByAppendingString:startTime] stringByAppendingString:endTime];
    
    cell.detailTextLabel.text = detailText;
    
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
    NSArray *array = self.sectionEventArray[indexPath.section];
    SASRecoveryEvent *recoveryEvent = [array objectAtIndex:indexPath.row];
    
    //return if the job cout is zero
    if (recoveryEvent.jobCount == 0){
        return;
    }

    
    SASJobTableViewController *jobTableViewController = [[SASJobTableViewController alloc ] initWithEventId:recoveryEvent.eventId];
    
    jobTableViewController.event = recoveryEvent;
    
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:jobTableViewController animated:YES];
}


@end
