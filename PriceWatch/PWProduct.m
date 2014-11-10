//
//  PWProducts.m
//  PriceWatch
//
//  Created by Venkateswara Prasath Durairaj on 2014-10-31.
//  Copyright (c) 2014 DVP Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWProduct.h"

@interface PWProduct()

@end


@implementation PWProduct : NSObject

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        // Assign all properties with keyed values from the dictionary
        self.title = [jsonDictionary objectForKey:@"productTitle"];
        self.currentPrice = [jsonDictionary objectForKey:@"currentPrice"];
        self.hostName = [jsonDictionary objectForKey:@"hostName"];
        self.imageUrl = [jsonDictionary objectForKey:@"imageLink"];
    }
    
    return self;
}
@end