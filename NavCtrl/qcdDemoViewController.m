//
//  qcdDemoViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "qcdDemoViewController.h"
#import "ChildViewController.h"
#import "Company.h"
#import "Products.h"

@interface qcdDemoViewController ()

@end

@implementation qcdDemoViewController

-(void)GetRequest{
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=AAPL,SSNLF,2498.TW,MSI&f=sl1&e=.csv"]];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            
            self.stockTicker = [[NSString alloc]initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
            
            
            NSArray *stockPairs = [self.stockTicker componentsSeparatedByString:@"\n"];
            for (int i = 0; i <stockPairs.count-1; i++){
                NSString *singleStock = stockPairs[i];
                NSArray *stockAndPrice = [singleStock componentsSeparatedByString:@","];
                Company *stockCompany = self.companyList[i];
                stockCompany.stock = [stockAndPrice objectAtIndex:1];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        }];
        
        [task resume];
        
    }
    


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

    
    
    self.DAO = [DAO sharedManager];
    
    //[self.DAO companyAndProductInfo];
    
    self.companyList = self.DAO.companyList;

    //This is the title of the 1st page
    self.title = @"Mobile device makers";
    
    [self GetRequest];

    
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
    return [self.companyList count];
    
   }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
        
        Company *company = [self.companyList objectAtIndex:indexPath.row];
        
        NSString *label = [NSString stringWithFormat:@" %@, Stock: %@", company.name,company.stock];
        
        cell.textLabel.text = label;
        
        cell.imageView.image = [UIImage imageNamed:[[self.companyList objectAtIndex:indexPath.row]logo]];

        
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//inserting the rows

    self.childVC.title = [[self.companyList objectAtIndex:[indexPath row]]name];
    Company *currentCompanies = [self.companyList objectAtIndex:[indexPath row]];
    self.childVC.products = currentCompanies.products;

    [self.navigationController pushViewController:self.childVC animated:YES];
    

}
 


@end
