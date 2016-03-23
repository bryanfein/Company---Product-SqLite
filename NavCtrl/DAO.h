//
//  DAO.h
//  NavCtrl
//
//  Created by Aditya Narayan on 6/22/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Products.h"
#import "sqlite3.h"


@interface DAO : NSObject



@property (nonatomic, strong) NSMutableArray *companyList;

@property(nonatomic,strong)NSMutableArray *ListOfCompanies;
@property(nonatomic,strong)NSMutableArray *ProductArray;
@property(nonatomic,strong)NSMutableArray *apple_products;
@property(nonatomic,strong)NSMutableArray *samsung_products;
@property(nonatomic,strong)NSMutableArray *htc_products;
@property(nonatomic,strong)NSMutableArray *motorola_products;


//SQLite

@property(nonatomic)sqlite3 *companyProductDB;
@property(nonatomic,strong) NSString *dbPathString;


-(void)readCompanies;
-(void)readProducts;
//-(void)companyAndProductInfo;
-(void)openDB;
-(void)deleteData:(NSString *)name;

//Singleton

+ (id)sharedManager;



@end
