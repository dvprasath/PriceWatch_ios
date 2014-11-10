//
//  PWProductsDataStore.m
//  PriceWatch
//
//  Created by Venkateswara Prasath Durairaj on 2014-10-31.
//  Copyright (c) 2014 DVP Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWProductsDataStore.h"
#import "PWProduct.h"

@interface PWProductsDataStore()

@end


@implementation PWProductsDataStore

- (instancetype) init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
}

- (instancetype) initPrivate
{
    self = [super init];
    return  self;
}

+ (instancetype) getInstance
{
    static PWProductsDataStore *store;
    
    if(store)
    {
        store = [[self alloc] initPrivate];
    }
    
    return store;
}


+ (NSArray *) getRandomproducts
{
    static NSMutableArray *randomProducts;
    if(randomProducts == nil)
    {
        randomProducts = [[NSMutableArray alloc] init];
        for (int i=0 ; i < 20; i++)
        {
            PWProduct *product = [[PWProduct alloc] init];
            product.title =  [ NSString stringWithFormat:@"Product _ %d", i];
            randomProducts[i] = product;
        }
    }
    
    return randomProducts;
}
@end