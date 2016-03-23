//
//  ChildViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ChildViewController.h"
#import "WebViewController.h"
#import "qcdDemoViewController.h"
#import "Products.h"

@interface ChildViewController ()

@end

@implementation ChildViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;


    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    

}
// This is where you add the products BRUH
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    
    cell.textLabel.text = [[self.products objectAtIndex: [indexPath row]]productName];
    
    cell.imageView.image = [UIImage imageNamed:[[self.products objectAtIndex: [indexPath row]]productLogo]];

    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        DAO *dao = [DAO sharedManager];
        [dao deleteData:[[self.products objectAtIndex: [indexPath row]]productName]];
        
       [self.products removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//  Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
    }
    [self.tableView endUpdates];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    
    
    self.webView = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.webView.title = cell.textLabel.text; // Pass the selected object to the new view controller.
    
    Products *product = [[Products alloc]init];
    
    //add the products to the products array --  all should be in one array.
    product = [self.products objectAtIndex:[indexPath row]];
    
    //assign the product url to the webview url
    self.webView.URL = product.productUrl;
    
    
    // Push the view controller.
    [self.navigationController pushViewController: self.webView animated:YES];
}
 


@end
