//
//  SASJob.h
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/28/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SASJob : NSObject

@property (strong,nonatomic) NSString *machineCommonName;
@property (strong,nonatomic) NSString *displayParameters;
@property (nonatomic) int jobId;
@property (strong,nonatomic) NSString *state;
@property (strong,nonatomic) NSString *hostname;
@property (strong,nonatomic) NSString *os;
@property (strong,nonatomic) NSString *edition;
@property (nonatomic) int servicePack;
@property (strong,nonatomic) NSString *cpuArch;
@property (nonatomic) float systemPartitionSize;
@property (strong,nonatomic) NSString *nic1IPAddress;



@end
