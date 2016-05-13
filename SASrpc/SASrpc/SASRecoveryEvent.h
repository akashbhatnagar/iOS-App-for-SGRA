//
//  SASRecoveryEvent.h
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/21/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SASRecoveryEvent : NSObject

@property(nonatomic) int eventId;
@property (nonatomic,strong) NSString *customerName;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,strong) NSDate *endDate;
@property  (nonatomic) int jobCount;
@property (nonatomic) BOOL hasError;


@end
