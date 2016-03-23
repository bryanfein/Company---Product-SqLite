//
//  Products.m
//  NavCtrl
//
//  Created by Aditya Narayan on 6/15/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "Products.h"


@implementation Products

-(instancetype)initWithName :(NSString*)productName andImageName:(NSString*)productLogo andURL: (NSString*)productUrl{
    self = [super init];
    if (self){
        _productName = productName;
        _productLogo = productLogo;
        _productUrl = productUrl;
    }
    return self;
}
@end
