//
//  FilterViewController.h
//  Yelp
//
//  Created by Stella Su on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Filter;

@protocol FilterViewControllerDelegate;

@interface FilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id <FilterViewControllerDelegate> delegate;

@end

@protocol FilterViewControllerDelegate <NSObject>

@end