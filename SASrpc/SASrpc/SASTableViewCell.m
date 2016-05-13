//
//  SASTableViewCell.m
//  SASrpc
//
//  Created by Akash Bhatnagar on 4/23/14.
//  Copyright (c) 2014 Sungard Availability Services. All rights reserved.
//

#import "SASTableViewCell.h"

@implementation SASTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.font = [self.textLabel.font fontWithSize:14.0];
        self.detailTextLabel.font = [self.detailTextLabel.font fontWithSize:10.0];
        self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
