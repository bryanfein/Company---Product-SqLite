//
//  WebView.m
//  NavCtrl
//
//  Created by Aditya Narayan on 6/10/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"
#import "ChildViewController.h"
#import "Products.h"


@interface WebViewController ()

@end

@implementation WebViewController
@synthesize wkWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.wkWebView = [[WKWebView alloc]initWithFrame:self.view.frame];
    
    NSURL *URL2 = [NSURL URLWithString:self.URL];

    [self setView:self.wkWebView];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL2];
   [self.wkWebView loadRequest:request];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [self.wkWebView release];
    [super dealloc];
}
@end
