//
//  PWSearchRequest.h
//  PriceWatch
//
//  Created by Venkateswara Prasath Durairaj on 2014-11-02.
//  Copyright (c) 2014 DVP Labs. All rights reserved.
//

@interface PWSearchRequest : NSObject

@property (strong, nonatomic) NSString *productTitle;
@property (strong, nonatomic) NSString *hostName;
@property (strong, nonatomic) NSString *sortOrder;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *dateFilter;
@property int pageNumber;

@end	