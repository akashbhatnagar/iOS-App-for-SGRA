//
//  SASJobTableViewController.h
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/27/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SASRecoveryEvent;

@interface SASJobTableViewController : UITableViewController

@property (strong,nonatomic) SASRecoveryEvent *event;

@property (nonatomic) int eventId;

-(instancetype)initWithEventId:(int)eventId;

@end
