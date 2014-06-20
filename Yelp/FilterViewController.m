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
#import "SwitchFilterCell.h"
#import "MainViewController.h"
#import "ExpandFilterCell.h"ExpandFilterCell.h

@interface FilterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filterTableView;

@property (strong, nonatomic) Filter *filter;
@property (strong, nonatomic ) SwitchFilterCell *sfc;

@property (strong, nonatomic) NSMutableDictionary *collapsed;
@property (strong, nonatomic) NSMutableDictionary *selectedCategories;

@property (nonatomic, assign) BOOL isWithDeal;

@property (strong, nonatomic) NSMutableArray *sortByTitlesArray;
@property (strong, nonatomic) NSMutableArray *distanceTitlesArray;
@property (strong, nonatomic) NSMutableArray *categoriesTitlesArray;
@property (strong, nonatomic) NSMutableArray *categoriesBaseTitelsArray;
@property (strong, nonatomic) NSMutableDictionary *categoriesDictionary;
@property (strong, nonatomic) NSMutableArray *userSelectionCategories;

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        self.title = @"Filters";
        self.collapsed = [NSMutableDictionary dictionary];
        self.selectedCategories = [NSMutableDictionary dictionary];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;

    
    if (self.filter == nil) {
        self.filter = [[Filter alloc] init];
    }
    
    
    if (self.userSelectionCategories == nil) {
        self.userSelectionCategories = [[NSMutableArray alloc] init];
    }
    
    self.filterTableView.separatorColor = [UIColor clearColor];
    
    self.isWithDeal = YES;
    
    [self setUpDataArrays];
    
    [self.filterTableView registerNib:[UINib nibWithNibName:@"SwitchFilterCell" bundle:nil] forCellReuseIdentifier:@"SwitchFilterCell"];
    
    [self.filterTableView registerNib:[UINib nibWithNibName:@"DistanceCell" bundle:nil] forCellReuseIdentifier:@"DistanceCell"];
    
    [self.filterTableView registerNib:[UINib nibWithNibName:@"SortCell" bundle:nil] forCellReuseIdentifier:@"SortCell"];
    
    [self.filterTableView registerNib:[UINib nibWithNibName:@"CategoriesCell" bundle:nil] forCellReuseIdentifier:@"CategoriesCell"];
    
    [self.filterTableView registerNib:[UINib nibWithNibName:@"FirstRowCell" bundle:nil] forCellReuseIdentifier:@"FirstRowCell"];

    
    
    [self.filterTableView reloadData];
    

    
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
    
    if (section == 1) {
        return [self.collapsed[@(section)] boolValue] ? 5 : 1;
    }
    
    if (section == 2) {
        return [self.collapsed[@(section)] boolValue] ? 4 : 1;
    }
    
    if (section == 3) {
        return 7;
    }
    
    else {
        return 1;
    }
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


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    indexPath.section == 0;
    SwitchFilterCell *sfc = [self.filterTableView dequeueReusableCellWithIdentifier:@"SwitchFilterCell"];
    self.sfc = sfc;
    return sfc;
    
    
}



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

- (void)setUpDataArrays {
    
    self.sortByTitlesArray = [NSMutableArray arrayWithObjects:@"Best Match", @"Best Match", @"Distance", @"Highest Rated", nil];
    self.distanceTitlesArray = [NSMutableArray arrayWithObjects:@"Auto", @"Auto", @"1 Mile Radius", @"2 Miles Radius", @"10 Miles Radius", nil];
    self.categoriesTitlesArray = [NSMutableArray arrayWithObjects:@"American (New)", @"American (Traditional)", @"Arabian", @"Argentine", @"Armenian", @"Asian Fusion", @"Australian", nil];
    self.categoriesBaseTitelsArray = [NSMutableArray arrayWithObjects:@"newamerican", @"tradamerican", @"arabian", @"argentine", @"armenian", @"asianfusion", @"australian", nil];
}

@end

