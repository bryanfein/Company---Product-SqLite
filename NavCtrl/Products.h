//
//  Products.h
//  NavCtrl
//
//  Created by Aditya Narayan on 6/15/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Products : NSObject

@property (nonatomic, strong) NSString *productName;
@property(nonatomic,strong) NSString *productUrl;
@property(nonatomic, strong) NSString *productLogo;
@property(nonatomic,strong) NSMutableArray *products;
@property (nonatomic, strong) NSString *companyID;


-(instancetype)initWithName :(NSString*)productName andImageName:(NSString*)productLogo andURL: (NSString*)productUrl;

@end
