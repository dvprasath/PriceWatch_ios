//
//  ProductDetailsViewController.m
//  PriceWatch
//
//  Created by Venkateswara Prasath Durairaj on 2014-11-09.
//  Copyright (c) 2014 DVP Labs. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "PWProduct.h"

@interface ProductDetailsViewController ()

@property PWProduct *product;
@property (weak, nonatomic) IBOutlet UILabel *labelProductTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelProductCurrentPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelStoreName;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;

@end

@implementation ProductDetailsViewController

- (instancetype) initWithPWProduct : (PWProduct *) product
{
    self = [super init];
    self.product = product;
    return self;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _labelProductTitle.text = _product.title;
    
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    _labelProductCurrentPrice.text = [formatter stringFromNumber:_product.currentPrice];

    
    _labelStoreName.text = _product.hostName;
    _productImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_product.imageUrl]]];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
