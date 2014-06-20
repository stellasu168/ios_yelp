//
//  SwitchFilterCell.h
//  Yelp
//
//  Created by Stella Su on 6/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchFilterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *dealSwitch;
@property (weak, nonatomic) IBOutlet UILabel *dealLabel;
@property (nonatomic) NSInteger off;

@end
