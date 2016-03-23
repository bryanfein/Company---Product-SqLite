//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"


//need to import the childView Controller class
@class ChildViewController;

@interface qcdDemoViewController : UITableViewController


//linked up the childview controller
@property (nonatomic, retain) ChildViewController * childVC;
@property (nonatomic, strong) DAO *DAO;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, strong) NSString *stockTicker;

-(void)GetRequest;


@end
