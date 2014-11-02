//
//  PWTableViewController.m
//  PriceWatch
//
//  Created by Venkateswara Prasath Durairaj on 2014-10-31.
//  Copyright (c) 2014 DVP Labs. All rights reserved.
//

#import "PWTableViewController.h"
#import "PWProductsDataStore.h"
#import "PWProduct.h"
#import "PWSearchRequest.h"

@interface PWTableViewController ()

@property PWProductsDataStore *productDataStore;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableArray *products;
@property NSMutableData *receivedData;

@end

@implementation PWTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Get a new or recycled cell
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                             forIndexPath:indexPath];
    PWProduct *product = _products[indexPath.row];
    cell.textLabel.text = product.name;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void) searchForProducts
{
    NSMutableURLRequest * request = [self createHttpRequest];
    
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (con)
    {
      self.receivedData=[NSMutableData data];
    }
    else
    {
        //something bad happened
    }
}


- (NSMutableURLRequest *) createHttpRequest
{
    NSString *queryString = [NSString stringWithFormat:@"http://162.243.137.136:8080/PriceWatchWeb/products/search"];
    
    NSMutableURLRequest *request=[NSMutableURLRequest
                                  requestWithURL:[NSURL URLWithString:
                                                  queryString]
                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                  timeoutInterval:60.0];
    
    PWSearchRequest *pwSearchRequest = [[PWSearchRequest alloc] init];
    pwSearchRequest.productTitle = @"Dead";
    pwSearchRequest.hostName = @"futureshop";
    pwSearchRequest.sortOrder = @"Relevance";
    pwSearchRequest.category = @"All";
    pwSearchRequest.dateFilter = @"Year";
    pwSearchRequest.pageNumber = 1;
    
    NSMutableDictionary *dict = [NSMutableDictionary  dictionaryWithObjectsAndKeys:
                                 pwSearchRequest.productTitle, @"productTitle",
                                 pwSearchRequest.hostName, @"hostName",
                                 pwSearchRequest.sortOrder, @"sortOrder",
                                 pwSearchRequest.category, @"category",
                                 pwSearchRequest.dateFilter, @"dateFilter",
                                 [NSNumber numberWithInteger: pwSearchRequest.pageNumber], @"pageNumber",
                                 nil];
    
    NSError *error;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:dict options:0 error: &error];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:requestBody];
    return request;
    
}
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"Response String %@", [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding]);
    NSDictionary *jsonDictionary =
        [NSJSONSerialization JSONObjectWithData:self.receivedData options:0 error:nil];
    
    _products = [[NSMutableArray alloc] init];
    // Get an array of dictionaries with the key "locations"
    NSArray *array = [jsonDictionary objectForKey:@"products"];
    
    for(NSDictionary *dict in array)
    {
        PWProduct *product = [[PWProduct alloc] initWithJSONDictionary:dict];
        [_products addObject:product];
    }
    [self.tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

}


@end
