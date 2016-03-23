//
//  Company.h
//  NavCtrl
//
//  Created by Aditya Narayan on 6/15/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Company : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) NSString *stock;
@property (nonatomic, strong) NSString *companyID;

-(instancetype)initWithName :(NSString*)name andImageName:(NSString*)logo andProducts:(NSMutableArray *)products;

@end
