//
//  SASMachineDetailViewController.m
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/30/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import "SASMachineDetailViewController.h"

@interface SASMachineDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *commonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *vendorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hardwareModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *spTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *spAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;

@end

@implementation SASMachineDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.navigationItem.title = @"Machine Detail";
    
    self.commonNameLabel.text = self.machine.commonName;
    if(self.machine.customerName){
        self.customerNameLabel.text = self.machine.customerName;
    }
    else{
        self.customerNameLabel.text = @"None";
    }
    
    self.vendorNameLabel.text = self.machine.vendor;
    self.hardwareModelLabel.text = self.machine.hardwareModel;
    self.spTypeLabel.text = self.machine.spType;
    self.spAddressLabel.text = self.machine.spAddress;
    self.stateLabel.text = self.machine.state;
    self.roomLabel.text = self.machine.room;
    //self.uuidLabel.lineBreakMode =
    self.uuidLabel.text = (nil != self.machine.uuid)? self.machine.uuid:@"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
