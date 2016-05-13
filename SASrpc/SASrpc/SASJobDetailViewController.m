//
//  SASJobDetailViewController.m
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/29/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import "SASJobDetailViewController.h"


@interface SASJobDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *customerName;
@property (weak, nonatomic) IBOutlet UILabel *jobId;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *machine;
@property (weak, nonatomic) IBOutlet UILabel *hostName;
@property (weak, nonatomic) IBOutlet UILabel *ipAddress;
@property (weak, nonatomic) IBOutlet UILabel *os;



@end

@implementation SASJobDetailViewController

-(instancetype)init
{
    self = [super init];
    
    if(self){
        
    
        
    }
    
    return self;
}

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
    
    self.customerName.text = self.event.customerName;
    self.jobId.text = [NSString stringWithFormat:@"%d",self.job.jobId];
    self.state.text = self.job.state;
    self.machine.text = self.job.machineCommonName;
    self.hostName.text = self.job.hostname;
    self.ipAddress.text = self.job.nic1IPAddress;
    self.os.text = self.job.os;
    
    self.navigationItem.title = @"Job Detail";
                       
                       
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
