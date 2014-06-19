//
//  MainViewController.h
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Modified by Stella Su on 6/15/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpClient.h"
#import "Restaurant.h"
#import "Filter.h"
#import "FilterViewController.h"
#import "RestaurantCell.h"


@interface MainViewController : UIViewController <UITableViewDelegate,
        UITableViewDataSource, UISearchBarDelegate, FilterViewControllerDelegate>


@end
