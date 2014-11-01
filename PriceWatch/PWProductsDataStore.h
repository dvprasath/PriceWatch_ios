//
//  PWProductsDataStore.h
//  PriceWatch
//
//  Created by Venkateswara Prasath Durairaj on 2014-10-31.
//  Copyright (c) 2014 DVP Labs. All rights reserved.
//

@interface PWProductsDataStore : NSObject

@property NSArray *products;

+ (instancetype) getInstance;
+ (NSArray *) getRandomproducts;

@end