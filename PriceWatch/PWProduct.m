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
        self.name = [jsonDictionary objectForKey:@"productTitle"];
    }
    
    return self;
}
@end