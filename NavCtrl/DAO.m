//
//  DAO.m
//  NavCtrl
//
//  Created by Aditya Narayan on 6/22/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO

-(void)openDB
{
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    self.dbPathString = [docPath stringByAppendingPathComponent:@"company.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:self.dbPathString])
    {
        
        [fileManager copyItemAtPath:@"/Users/fein91/Desktop/company.db" toPath:self.dbPathString error:nil];
        
    }
    [self readCompanies];
    [self readProducts];
    [self importProductToCompany];
}


-(void)readCompanies
{
    self.companyList = [[NSMutableArray alloc]init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([self.dbPathString UTF8String], &_companyProductDB)==SQLITE_OK)
    {
        //[self.companyList removeAllObjects];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM company"];
        
        const char *query_sql = [querySQL UTF8String];
        
        if (sqlite3_prepare(_companyProductDB, query_sql,-1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
                NSString *company_id = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement,0)];
                NSString *company_name =[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement,1)];
                NSString *company_logo =[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement,2)];
                NSString *company_stock =[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement,3)];
                
                
                Company  *company = [[Company alloc]init];
                company.name = company_name;
                company.logo = company_logo;
                company.stock = company_stock;
                company.companyID = company_id;
                company.products = [[NSMutableArray alloc]init];
                
                [self.companyList addObject:company];
                
                NSLog(@"id=%@ name= %@ logo= %@ stock=%@",company_id, company_name, company_logo, company_stock);
                
            }
        }
        
        
        
        
    }
}

-(void)readProducts
{
    self.ProductArray = [[NSMutableArray alloc]init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([self.dbPathString UTF8String], &_companyProductDB)==SQLITE_OK)
    {
        [self.ProductArray removeAllObjects];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM product"];
        
        const char *query_sql = [querySQL UTF8String];
        
        if (sqlite3_prepare(_companyProductDB, query_sql,-1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement)== SQLITE_ROW)
            {
                NSString *company_id = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement,0)];
                NSString *product_name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement,1)];
                NSString *product_Url = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement,2)];
                NSString *product_logo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement,3)];
                
                
                Products  *product = [[Products alloc]init];
                product.companyID = company_id;
                product.productName = product_name;
                product.productUrl = product_Url;
                product.productLogo = product_logo;
                
                [self.ProductArray addObject:product];
                NSLog(@"name=%@ url= %@ logo= %@",product_name,product_Url,product_logo);
                
            }
        }
        
    }
}

-(void) importProductToCompany {
    for (Company *newCompany in self.companyList) {
        for (Products *newProduct in self.ProductArray) {
            if ([newCompany.companyID isEqualToString:newProduct.companyID]) {
                [newCompany.products addObject:newProduct];
            }
        }
    }
}




-(void)deleteData:(NSString *)name
{
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM product WHERE product_name IS '%@'",name];
    char *error;
    if (sqlite3_exec(_companyProductDB, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK)
    {
        NSLog(@"Product Deleted");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Product Deleted" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
}



+ (instancetype) sharedManager
{
    static dispatch_once_t once;
    static id sharedManager;
    dispatch_once(&once, ^
                  {
                      sharedManager = [[self alloc]init];
                      [sharedManager openDB];
                  });
    
    
    return sharedManager;
    
}

/*
-(void)companyAndProductInfo {
    
    //APPLE PRODUCTS
    
    Products *ipad = [[Products alloc] initWithName:@"iPad" andImageName:@"Apple_logo.png" andURL:@"https://www.apple.com/ipad/"];
    Products *iPodTouch = [[Products alloc] initWithName:@"iPod Touch" andImageName:@"Apple_logo.png" andURL:@"https://www.apple.com/ipod-touch/"];
    Products *iPhone = [[Products alloc] initWithName:@"iPhone" andImageName:@"Apple_logo.png" andURL: @"https://www.apple.com/iphone/"];
    
    self.apple_products = [[NSMutableArray alloc] initWithObjects:ipad,iPodTouch,iPhone,nil];
    
    
    
    //SAMSUNG PRODUCTS
    Products *galaxyS4 = [[Products alloc] initWithName:@"Galaxy S4" andImageName:@"Samsung_Logo.jpg" andURL:@"http://www.samsung.com/global/microsite/galaxys4/"];
    Products *galaxyNote = [[Products alloc] initWithName:@"Galaxy Note" andImageName:@"Samsung_Logo.jpg" andURL:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find"];
    Products *galaxyTab = [[Products alloc] initWithName:@"Galaxy Tab" andImageName:@"Samsung_Logo.jpg" andURL:@"http://www.samsung.com/us/topic/introducing-the-galaxy-tab-s/index.html?cid=ppc-&gclid=CjwKEAjwwN-rBRD-oMzT6aO_wGwSJABwEIkJWlLOBwKEElGzACzIkJmJhUTy_kr1Q8dHFGlMFcIE7xoCG1_w_wcB"];
    
    self.samsung_products =[[NSMutableArray alloc]initWithObjects: galaxyS4,galaxyNote,galaxyTab,nil];
    
    
    //HTC Products
    
    Products *oneM9 = [[Products alloc] initWithName:@"One M9" andImageName:@"htc logo 2.png" andURL:@"http://www.htc.com/us/smartphones/htc-one-m9/"];
    Products *oneM8 = [[Products alloc]initWithName:@"One M8" andImageName:@"htc logo 2.png" andURL:@"http://www.htc.com/us/smartphones/htc-one-m8/"];
    Products *oneE8 = [[Products alloc] initWithName:@"One E8" andImageName:@"htc logo 2.png" andURL:@"http://www.htc.com/us/smartphones/htc-one-e8/"];
    
    self.htc_products = [[NSMutableArray alloc] initWithObjects:oneM9,oneM8,oneE8,nil];
    
    //Motorola Product
    
    Products *motoG = [[Products alloc] initWithName:@"Moto G" andImageName:@"Motorola_Logo.jpg" andURL:@"http://www.motorola.com/us/smartphones/moto-g-2nd-gen/moto-g-2nd-gen.html"];
    Products *motoX = [[Products alloc] initWithName:@"Moto X" andImageName:@"Motorola_Logo.jpg" andURL:@"http://www.motorola.com/us/Moto-X/FLEXR1.html"];
    Products *droidMaxx = [[Products alloc] initWithName:@"Droid Maxx" andImageName:@"Motorola_Logo.jpg" andURL: @"https://www.motorola.com/us/smartphones/droid-maxx/m-droid-maxx.html"];
    
    self.motorola_products = [[NSMutableArray alloc] initWithObjects:motoG,motoX,droidMaxx,nil];
    
    
    Company *apple = [[Company alloc] initWithName:@"Apple mobile devices" andImageName: @"Apple_logo.png" andProducts: self.apple_products];
    Company *samsung = [[Company alloc] initWithName:@"Samsung mobile devices" andImageName:@"Samsung_Logo.jpg" andProducts: self.samsung_products];
    Company *htc = [[Company alloc] initWithName:@"HTC mobile devices" andImageName:@"htc logo 2.png" andProducts:self.htc_products];
    Company *motorola = [[Company alloc] initWithName:@"Motorola mobile devices" andImageName:@"Motorola_Logo.jpg" andProducts: self.motorola_products];
    
    self.companyList = [[NSMutableArray alloc] initWithObjects: apple,samsung,htc,motorola, nil];
    self.ProductArray =[[NSMutableArray alloc] initWithObjects:self.apple_products,self.samsung_products,self.htc_products,self.motorola_products,nil];
}
*/

@end
