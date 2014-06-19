//
//  FilterViewController.m
//  Yelp
//
//  Created by Stella Su on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//  Filters will have ..
//  - Sort (best match, distance, highest rated)
//  - radius (meters)
//  - deals (on/off)
//  - category
//
// 1. Special Deal on/off
// 2. Distance
// 3. Sort By
// 4. Categories

#import "FilterViewController.h"
#import "Filter.h"
#import "MainViewController.h"

@interface FilterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, assign) BOOL distanceCollapsed;
@property (nonatomic, assign) BOOL sortByCollapsed;
@property (nonatomic, assign) NSUInteger distanceBySelection;
@property (nonatomic, assign) NSUInteger sortBySelection;


@end

@implementation FilterViewController

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
    
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;
    
    self.distanceCollapsed = YES;
    self.sortByCollapsed = YES;
    self.sortBySelection = 0;
    self.distanceBySelection = 0;
  
    
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // alloc a Filter object
    // set Filter.userSwitch = YES / NO;
    // then call a function. (  self...addTarget (Selector @ .... )

    return cell;
}
*/


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return @"SPECIAL DEAL";
    }
    if (section == 1) {
        return @"DISTANCE";
    }
    if (section == 2) {
        return @"SORT BY";
    }
    if (section == 3) {
        return @"CATEGORIES";
    }
    else {
        return @"Empty";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    if (section == 1)
    {
        if (!self.distanceCollapsed)
        {
            return [self.categories[section][@"list"] count];
        }
        else
        {
            return 1;
        }
    }
    else if (section == 2)
    {
        if (!self.sortByCollapsed)
        {
            return [self.categories[section][@"list"] count];
        }
        else
        {
            return 1;
        }
    }
    else if (section == 3)
    {
        return 7;
        
    }
    
    else {
        return 1;
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.categories.count;
   
}
 */

/*
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.section == 0) {

    // Deque a cell like 'DEAL'
        return cell;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0)   
        {
        cell.textLabel.text = self.distanceArray[0];
        }
        return cell;
    }
 
    if (indexPath.section == 2) {
        
        // Deque a cell like SORT
 
        if (indexPath.row == 0) {
            cell.textLabel.text = self.sortByTitlesArray[0];
        }
        
        if (indexPath.row == 1) {
            sortCell.textLabel.text = self.sortByTitlesArray[1];
        }
        
        if (indexPath.row == 2) {
            sortCell.textLabel.text = self.sortByTitlesArray[2];
        }
        return cell;
    }
    
    if (indexPath.section == 3) {
        CategoriesCell *categoriesCell = [tableView dequeueReusableCellWithIdentifier:@"CategoriesCell"];
        
        if ([self.selectedCategories[@(indexPath.row)] boolValue]) {
            categoriesCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        else {
            categoriesCell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        return categoriesCell;
    }
    
    // Error message
    else { return nil; }
}
 
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSearch:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something

}



@end

