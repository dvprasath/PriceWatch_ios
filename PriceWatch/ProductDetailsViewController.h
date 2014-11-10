//
//  ProductDetailsViewController.h
//  PriceWatch
//
//  Created by Venkateswara Prasath Durairaj on 2014-11-09.
//  Copyright (c) 2014 DVP Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PWProduct;

@interface ProductDetailsViewController : UIViewController

- (instancetype) initWithPWProduct : (PWProduct *) product;

@end
