//
//  SASRecoveryEvent.m
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/21/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import "SASRecoveryEvent.h"

@implementation SASRecoveryEvent

- (NSString *)description{
    
    NSString *descString = [[NSString alloc] initWithFormat:@"CustomerName: %@, State: %@, EventId: %d, JobCount: %d, startTime: %@", self.customerName,self.state,self.eventId, self.jobCount, self.startDate];
    
    return descString;
    
}

@end
