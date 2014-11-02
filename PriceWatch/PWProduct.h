//
//  PWProducts.h
//  PriceWatch
//
//  Created by Venkateswara Prasath Durairaj on 2014-10-31.
//  Copyright (c) 2014 DVP Labs. All rights reserved.
//

@interface PWProduct : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@end
