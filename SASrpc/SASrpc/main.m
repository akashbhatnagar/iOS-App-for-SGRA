//
//  main.m
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/18/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SASAppDelegate.h"
#import "WPXMLRPC/WPXMLRPCEncoder.h"
#import "WPXMLRPC/WPXMLRPCDecoder.h"
#import "SASRecoveryEvent.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        
       
 /*       NSURL *URL = [NSURL URLWithString:@"http://172.31.100.218:8000/de/RPC2"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
        [request setHTTPMethod:@"POST"];
        
        WPXMLRPCEncoder *encoder = [[WPXMLRPCEncoder alloc] initWithMethod:@"get_recovery_events" andParameters:nil];
        
        NSString* requestStr = [[NSString alloc] initWithData:encoder.body encoding:NSUTF8StringEncoding];
        
        NSLog(@"Request sent: %@", requestStr);
        
        [request setHTTPBody:encoder.body];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                                  NSURLResponse *response,
                                                                  NSError *error) {
          
            if(error){
                NSLog(@"Error returned: %@", error.localizedDescription);
            }
            else {
                
                NSString* responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"response recieved: %@", responseStr);
                
                WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:data];
                
                if ([decoder isFault]) {
                    NSLog(@"XML-RPC error %ld: %@", (long)[decoder faultCode], [decoder faultString]);
                } else {
                    NSLog(@"XML-RPC response: %@", [decoder object]);
                    
                    NSArray *dataArray = [decoder object];
                    NSMutableArray *eventArray = [NSMutableArray array];
                    
                    //iterate through all the events and display
                    for ( NSDictionary *dict in dataArray){
                        
                        SASRecoveryEvent *event = [[SASRecoveryEvent alloc] init];
                        event.customerName = [dict objectForKey:@"customer_name"];
                        event.jobCount = [[dict objectForKey:@"job_count"] intValue];
                        event.eventId = [[dict objectForKey:@"id"] intValue];
                        event.state = [dict objectForKey:@"state"];
                        event.startDate = [dict objectForKey:@"start_time"];
                        event.endDate = [dict objectForKey:@"end_time"];
                        event.hasError = [dict objectForKey:@"has_error"];
                        
                        [eventArray addObject:event];
                        
                    }
                    
                    NSLog(@"Events: %@", eventArray);
                    NSLog(@"Count: %lu",(unsigned long)[eventArray count]);
                    
                    //just fetch recovery event details for the first object
                    
                    NSMutableURLRequest *jobRequest = [[NSMutableURLRequest alloc] initWithURL:URL];
                    [jobRequest setHTTPMethod:@"POST"];
                    
                    SASRecoveryEvent *event = eventArray[0];
                    NSNumber *eventId = [NSNumber numberWithInt:event.eventId];
                    
                    WPXMLRPCEncoder *encoder = [[WPXMLRPCEncoder alloc] initWithMethod:@"get_recovery_event" andParameters:@[eventId]];
                    
                    NSString* jobRequestStr = [[NSString alloc] initWithData:encoder.body encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"Request sent: %@", jobRequestStr);
                    
                    [request setHTTPBody:encoder.body];
                    
                    NSURLSession *jobSession = [NSURLSession sharedSession];
                    [[jobSession dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                                              NSURLResponse *response,
                                                                              NSError *error) {
                        
                        if(error){
                            NSLog(@"Error returned: %@", error.localizedDescription);
                        }
                        else {
                            
                            NSString* jobResponseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            NSLog(@"response recieved: %@", jobResponseStr);
                            
                            WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:data];
                            
                            if ([decoder isFault]) {
                                NSLog(@"XML-RPC error %ld: %@", (long)[decoder faultCode], [decoder faultString]);
                            } else {
                                NSLog(@"XML-RPC response: %@", [decoder object]);

                            }
                        }
                        
                        
                    }] resume];
                    
                    
                    
                }
                
            }
            
            
            
            
        }] resume];
        
    */
        
       /*
        //this is code to get the machine data
       
        NSURL *URL = [NSURL URLWithString:@"http://172.31.100.218:8000/de/RPC2"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
        [request setHTTPMethod:@"POST"];
        
        WPXMLRPCEncoder *encoder = [[WPXMLRPCEncoder alloc] initWithMethod:@"get_machines" andParameters:nil];
        
        NSString* requestStr = [[NSString alloc] initWithData:encoder.body encoding:NSUTF8StringEncoding];
        
        NSLog(@"Request sent: %@", requestStr);
        
        [request setHTTPBody:encoder.body];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data,
                                                                  NSURLResponse *response,
                                                                  NSError *error) {
            
            if(error){
                NSLog(@"Error returned: %@", error.localizedDescription);
            }
            else {
                
                NSString* responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"response recieved: %@", responseStr);
                
                WPXMLRPCDecoder *decoder = [[WPXMLRPCDecoder alloc] initWithData:data];
                
                if ([decoder isFault]) {
                    NSLog(@"XML-RPC error %ld: %@", (long)[decoder faultCode], [decoder faultString]);
                } else {
                    NSLog(@"XML-RPC response: %@", [decoder object]);
                   
                }
                
            }
            
        }] resume];
       */
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([SASAppDelegate class]));
    }
}
