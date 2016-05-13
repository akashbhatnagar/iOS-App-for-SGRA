//
//  SASMachine.h
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/29/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SASMachine : NSObject

@property (strong,nonatomic) NSString *commonName;
@property (strong,nonatomic) NSString *spAddress;
@property (strong,nonatomic) NSString *spType;
@property (strong,nonatomic) NSString *state;
@property (strong,nonatomic) NSString *customerName;
@property (strong,nonatomic) NSString *hardwareModel; //product
@property (strong,nonatomic) NSString *vendor; //vendor
@property (strong,nonatomic) NSString *room; //room
@property (strong,nonatomic) NSString *uuid; //uuid



@end
