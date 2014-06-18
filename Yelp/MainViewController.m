//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Modified by Stella Su on 6/15/14.
//
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController ()

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic,strong) NSArray *restaurantList;
@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterButton;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response)
        {
           // NSLog(@"sample response: %@", response);
            
            // response is a NSDictionary object
            NSArray *businesses = response[@"businesses"];
            
            if(self.restaurantList == nil){
                
                self.restaurantList = [[NSMutableArray alloc] init];
            }
         
            self.restaurantList =  [Restaurant businessesWithArray:businesses];
           
            [self.restaurantTableView reloadData];
           
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"error: %@", [error description]);
        }];
  
        
    }
    return self;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    // TableView setups
    // Look for the movies
    UINib *nib = [UINib nibWithNibName:@"RestaurantCell" bundle:nil];
    [self.restaurantTableView registerNib:nib forCellReuseIdentifier:@"RestaurantCell"];
    
    self.restaurantTableView.delegate = self;
    self.restaurantTableView.dataSource = self;
    
}
- (IBAction)filterTapped:(id)sender
{
    NSLog(@"Filter!");
    
    NSString *className = NSStringFromClass([FilterViewController class]);
    FilterViewController *filterViewController = [[FilterViewController alloc] initWithNibName:className bundle:nil];
    filterViewController.delegate = self;
    [self presentViewController:filterViewController animated:YES completion:^{}];
    
}


- (void) viewWillAppear:(BOOL)animated
{
    // Kick off the api call with the new filters
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

// Tell me how many rows of restaurants in the restaurants array
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.restaurantList.count;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Please give me a restaurant cell
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell"];
    //RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell"
   //                                  forIndexPath:indexPath];
    
    Restaurant *restaurant = [[Restaurant alloc] init];
    //restaurant = [self.restaurantList objectAtIndex: indexPath.row];
    restaurant = self.restaurantList [indexPath.row];
    
    // Configure the cell...
    cell.restaurantName.text = restaurant.restaurantName;
    cell.restaurantAddress.text = restaurant.restaurantAddress;
    
    // Make the image edges around
    [cell.restaurantImage.layer setCornerRadius:5];
    [cell.restaurantImage.layer setMasksToBounds:YES];
    
    // Create the image data in the background
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:restaurant.restaurantImage];
        NSData *ratingData = [NSData dataWithContentsOfURL:restaurant.ratingImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.restaurantImage setImage:[UIImage imageWithData:imageData]];
            [cell.ratingImage setImage: [UIImage imageWithData:ratingData]];
        });
    });


    return cell;
}


// On the 'tap'
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Do nothing for now.
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

/*
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    UITextField *searchBarTextField;
    
    for (UIView *subView in searchBar.subviews){
        for (UIView *secondLevelSubView in subView.subviews){
            if ([secondLevelSubView isKindOfClass:[UITextField class]]) {
                searchBarTextField = (UITextField *)secondLevelSubView;
                break;
            }
        }
    }
    
    [searchBar resignFirstResponder];
    [self.client searchWithTerm:searchBarTextField.text success:^(AFHTTPRequestOperation *operation, id response) {
        self.restaurantList = [[NSMutableArray alloc] init];
        for (NSDictionary *restaurant in response[@"businesses"]) {
            [self.restaurantList addObject:[[Restaurant alloc] initWithRestaurantData:restaurant]];
        }
        [self.restaurantTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    
}
-(void)searchWithDictionary:(NSMutableDictionary *)dict
{
    //[dictionary setValue:self.searchTerm forKey:@"term"];
    UITextField *searchBarTextField;
    for (UIView *subView in self.searchBar.subviews){
        for (UIView *secondLeveSubView in subView.subviews){
            if ([secondLeveSubView isKindOfClass:[UITextField class]]) {
                searchBarTextField = (UITextField *)secondLeveSubView;
                break;
            }
        }
    }
    
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:searchBarTextField.text forKey:@"term"];
    [dictionary addEntriesFromDictionary:dict];
    [dictionary setValue:@"san francisco" forKey:@"location"];
    
    [self.client searchWithDictionary:dictionary success:^(AFHTTPRequestOperation *operation, id response) {
        self.restaurantList = [[NSMutableArray alloc] init];
        for (NSDictionary *restaurant in response[@"businesses"]) {
            [self.restaurantList addObject:[[Restaurant alloc] initWithRestaurantData:restaurant]];
        }
        [self.restaurantTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

 */


@end