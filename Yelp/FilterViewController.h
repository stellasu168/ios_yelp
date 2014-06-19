//
//  FilterViewController.h
//  Yelp
//
//  Created by Stella Su on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FilterViewControllerDelegate <NSObject>
-(void)searchWithDictionary:(NSMutableDictionary *)data;

@end

@interface FilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <FilterViewControllerDelegate> delegate;
@end
