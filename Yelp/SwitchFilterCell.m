//
//  SwitchFilterCell.m
//  Yelp
//
//  Created by Stella Su on 6/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SwitchFilterCell.h"

@implementation SwitchFilterCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onTap:(id)sender {
    
    
    // if off, turn on
    if (self.off == 1) {
        self.off = 0;
        
    }
    
    // if on, turn off
    if (self.off == 0) {
        self.off = 1;
        
    }

    
}



@end
