//
//  ChildViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "DAO.h"
//make a propert for products


@interface ChildViewController : UITableViewController
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, strong) WebViewController *webView;
@property (nonatomic, strong) NSString *URL;
@property (nonatomic, strong) NSMutableArray *productsLogo;

@end


