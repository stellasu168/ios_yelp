//
//  FilterViewController.m
//  Yelp
//
//  Created by Stella Su on 6/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, assign) BOOL distanceCollapsed;
@property (nonatomic, assign) BOOL sortByCollapsed;
@property (nonatomic, assign) NSUInteger distanceBySelection;
@property (nonatomic, assign) NSUInteger sortBySelection;
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, assign) NSUInteger priceSelection;
@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.values = [@[@(NO),@(NO),@(YES),@(YES)] mutableCopy];
        self.categories = [NSMutableArray arrayWithObjects:
                        @{
                            @"name":@"Price",
                            @"type":@"segmented",
                            @"list":@[@"$",@"$$",@"$$$",@"$$$$"]
                             },
                        @{
                             @"name":@"Most Popular",
                             @"type":@"switches",
                             @"list":@[@"Open Now",@"Hot & New",@"Offering a Deal",@"Delivery"]
                             },
                        @{
                             @"name":@"Distance",
                             @"type":@"expandable",
                             @"list":@[@"Auto",@"2 blocks",@"6 blocks",@"1 mile",@"5 miles"]
                             },
                        @{
                             @"name":@"Sort By",
                             @"type":@"expandable",
                             @"list":@[@"Best Match",@"Distance",@"Rating",@"Most Reviewed"]
                             }
                           ,nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;
    [self.filterTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FilterCell"];
    UINib *nib = [UINib nibWithNibName:@"SegmentedTableViewCell" bundle:nil];
    [self.filterTableView registerNib:nib forCellReuseIdentifier:@"SegmentedCell"];
    [self.filterTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SwitchCell"];
    [self.filterTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ExpandableCell"];
    
    UINavigationBar *headerView = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    
    UINavigationItem *buttonCarrier = [[UINavigationItem alloc]initWithTitle:@"Filter"];
    
    UIBarButtonItem *barBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    UIBarButtonItem *barSaveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    
    [buttonCarrier setLeftBarButtonItem:barBackButton];
    [buttonCarrier setRightBarButtonItem:barSaveButton];
    NSArray *barItemArray = [[NSArray alloc]initWithObjects:buttonCarrier,nil];
    [headerView setItems:barItemArray];
    
    [self.filterTableView setTableHeaderView:headerView];
    [headerView setTintColor:[UIColor whiteColor]];
    [headerView setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [headerView setBarTintColor:[UIColor redColor]];
    self.distanceCollapsed = YES;
    self.sortByCollapsed = YES;
    self.sortBySelection = 0;
    self.distanceBySelection = 0;
    self.priceSelection = 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        SegmentedTableViewCell *cell = (SegmentedTableViewCell *)[self.filterTableView dequeueReusableCellWithIdentifier:@"SegmentedCell" forIndexPath:indexPath];
//[cell setSelectedIndex:self.priceSelection];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        UITableViewCell *cell;
        cell = [self.filterTableView dequeueReusableCellWithIdentifier:@"SwitchCell" forIndexPath:indexPath];
        cell.textLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchView setOn:self.values[indexPath.row]];
        
        cell.accessoryView = switchView;
        return cell;
    }
    else if (indexPath.section == 2)
    {
        UITableViewCell * cell = [self.filterTableView dequeueReusableCellWithIdentifier:@"ExpandableCell" forIndexPath:indexPath];
        if(self.distanceCollapsed) {
            cell.textLabel.text = self.categories[indexPath.section][@"list"][self.distanceBySelection];
        }
        else {
            cell.textLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
            return cell;
        }
        return cell;
    }
    else if (indexPath.section == 3)
    {
        
        UITableViewCell * cell = [self.filterTableView dequeueReusableCellWithIdentifier:@"ExpandableCell" forIndexPath:indexPath];
        if(self.sortByCollapsed) {
            cell.textLabel.text = self.categories[indexPath.section][@"list"][self.sortBySelection];
            
        }
        else {
            cell.textLabel.text = self.categories[indexPath.section][@"list"][indexPath.row];
        }
        return cell;
    }
    else {
        UITableViewCell *cell = [self.filterTableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 4;
    }
    else if (section == 2) {
        if (!self.distanceCollapsed) {
            return [self.categories[section][@"list"] count];
        }
        else {
            return 1;
        }
    }
    else if (section == 3) {
        if (!self.sortByCollapsed) {
            return [self.categories[section][@"list"] count];
        }
        else {
            return 1;
        }
    }
    else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.categories[section][@"name"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.categories.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
		self.distanceCollapsed = !self.distanceCollapsed;
        self.distanceBySelection = indexPath.row;
		[self.filterTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
	}
    else if(indexPath.section == 3)
    {
		self.sortByCollapsed = !self.sortByCollapsed;
        self.sortBySelection = indexPath.row;
		[self.filterTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    [self.filterTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    return;
}

//- (void)save
//{
//    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
//    [filters setValue:[NSNumber numberWithInt:self.sortBySelection] forKey:@"sort"];
//    if ([self.delegate respondsToSelector:@selector(searchWithDictionary:)])
//    {
//        [self.delegate searchWithDictionary:filters];
//    }
//    [self dismissViewControllerAnimated:YES completion:^{}];
//    return;
//}
//
//-(void)searchWithDictionary:(NSMutableDictionary *)data
//{
//    if ([self.delegate respondsToSelector:@selector(searchWithDictionary:)])
//    {
//        [self.delegate searchWithDictionary:data];
//    }
//}



@end

