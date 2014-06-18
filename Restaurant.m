//
//  Restaurant.m
//  Yelp
//
//  Created by Stella Su on 6/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

- (id)initWithRestaurantData:(NSDictionary *)restaurantData
{
    self = [super init];
    
    if (restaurantData != nil)
    {  
        
        self.restaurantName = restaurantData[@"name"];
        self.restaurantAddress = restaurantData[@"location"][@"address"][0];
        self.restaurantImage = [NSURL URLWithString: restaurantData[@"image_url"]];
        self.ratingImage = [NSURL URLWithString: restaurantData[@"rating_img_url"]];
   
       
        
    }
    
    return self;
}

+ (NSMutableArray *)businessesWithArray:(NSArray *)array
{
    
    NSMutableArray *businessesArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array){
        Restaurant *restaurant = [[Restaurant alloc] initWithRestaurantData:dictionary];
        
        [businessesArray addObject:restaurant];
    }
    
    return businessesArray;
}


@end
