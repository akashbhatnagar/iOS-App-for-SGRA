//
//  SASMachineTableViewController.m
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/29/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import "SASMachineTableViewController.h"
#import "WPXMLRPC/WPXMLRPCDecoder.h"
#import "SASMachine.h"
#import "SASTableViewCell.h"
#import "SASMachineDetailViewController.h"

@interface SASMachineTableViewController ()

@property (strong,nonatomic) NSMutableArray *machineArray;
@property (strong,nonatomic) NSArray *sortedMachineArray;

@property (nonatomic,strong) UIColor *barColor;

@property (nonatomic,strong) UIColor *textColor;

@end

@implementation SASMachineTableViewController

-(instancetype)init
{
    self = [super init];
    
    if(self){
        
        self.textColor = [UIColor whiteColor]; //white color
        self.barColor = [UIColor colorWithRed:38.0/255.0 green:63.0/255.0 blue:102/255.0 alpha:1]; //dark blue
       // self.tabBarColor = [UIColor colorWithRed:66.0/255.0 green:110.0/255.0 blue:155.0/255.0 alpha:0]; //light blue
        
        NSBundle *applicationBundle = [NSBundle mainBundle];
        
        NSString *path = [applicationBundle pathForResource:@"machine" ofType:@"txt"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:data];
        
        if ([decoder isFault]) {
            NSLog(@"XML-RPC error %ld: %@", (long)[decoder faultCode], [decoder faultString]);
        } else {
           // NSLog(@"XML-RPC response: %@", [decoder object]);
            
            NSArray *machineRawArray = [decoder object];
            self.machineArray = [NSMutableArray array];
            
            for (NSDictionary *dict in machineRawArray){
                
                SASMachine *machine = [[SASMachine alloc] init];
                machine.commonName = [dict objectForKey:@"common_name"];
                machine.spAddress = [dict objectForKey:@"sp_address"];
                machine.spType = [dict objectForKey:@"sp_type"];
                machine.state = [dict objectForKey:@"state"];
                machine.customerName = [dict objectForKey:@"customer_name"]; //may be nil
                
                machine.hardwareModel = [dict objectForKey:@"product"];
                machine.vendor = [dict objectForKey:@"vendor"];
                machine.room = [dict objectForKey:@"room"];
                machine.uuid = [dict objectForKey:@"uuid"];
                
                [self.machineArray addObject:machine];
                
            }
            
            NSSortDescriptor *spTypeSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"spType"
                                                                                  ascending:YES];
            
            self.sortedMachineArray = [self.machineArray sortedArrayUsingDescriptors:@[spTypeSortDescriptor]];
            
            NSLog(@"Machine Count: %lu", (unsigned long)[self.sortedMachineArray count]);
            
            //dereference jobArray
            self.machineArray = nil;
            
            
        }

    }
    
    //self.textColor = [UIColor whiteColor]; //white color
    //self.barColor = [UIColor colorWithRed:38.0/255.0 green:63.0/255.0 blue:102/255.0 alpha:1]; //dark blue
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Machines";
//    self.navigationController.tabBarItem.title = @"Machines";
//    UIImage *i = [UIImage imageNamed:@"server-25.png"];
//    // [i imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.navigationController.tabBarItem.image = i;
    
    [self.tableView registerClass:[SASTableViewCell class] forCellReuseIdentifier:@"SASTableViewCell"];
    
    NSMutableDictionary *colorDict = [[NSMutableDictionary alloc] init];
    
    [colorDict setValue:self.textColor forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = colorDict;
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.sortedMachineArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SASTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:74.0/255.0 green:74.0/255.0 blue:74.0/255.0 alpha:1];
    
    
    SASMachine *machine = [self.sortedMachineArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = machine.commonName;
    
    NSString *detailText = [NSString stringWithFormat:@"SP Type: %@, State: %@", machine.spType,machine.state];
    
    cell.detailTextLabel.text = detailText;
    
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
    SASMachineDetailViewController *machineDetailViewController = [[SASMachineDetailViewController alloc] init];
    
    
    machineDetailViewController.machine = [self.sortedMachineArray objectAtIndex:indexPath.row];
    
    
    // Push the view controller.
    [self.navigationController pushViewController:machineDetailViewController animated:YES];
}


@end
