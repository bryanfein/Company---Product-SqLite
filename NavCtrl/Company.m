//
//  Company.m
//  NavCtrl
//
//  Created by Aditya Narayan on 6/15/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "Company.h"


@implementation Company



-(instancetype)initWithName :(NSString*)name andImageName:(NSString*)logo andProducts:(NSMutableArray *)products{

    self = [super init];
    if (self){
        _name = name;
        _logo = logo;
        _products = products;
    }
    return self;
}
@end
