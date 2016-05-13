//
//  SASJobDetailViewController.h
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/29/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASRecoveryEvent.h"
#import "SASJob.h"

@interface SASJobDetailViewController : UIViewController

@property (strong,nonatomic) SASRecoveryEvent *event;
@property (strong,nonatomic) SASJob *job;

@end
