//
//  Restaurant.h
//  Yelp
//
//  Created by Stella Su on 6/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic, strong) NSURL *restaurantImage;
@property (nonatomic, strong) NSString *restaurantName;
@property (nonatomic, strong) NSURL *ratingImage;
@property (nonatomic, strong) NSString *restaurantAddress;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *reviews;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSMutableArray *categoriesArray;
@property (nonatomic, strong) NSString *categories;

- (id)initWithRestaurantData:(NSDictionary *)restaurantData;
+ (NSMutableArray *)businessesWithArray:(NSArray *)array;

@end
