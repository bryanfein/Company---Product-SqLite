//
//  WebView.h
//  NavCtrl
//
//  Created by Aditya Narayan on 6/10/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "qcdDemoViewController.h"
#import "WebKit/WebKit.h"



@interface WebViewController : UIViewController <NSURLSessionDelegate, WKUIDelegate>
@property (nonatomic, strong) NSString *URL;
@property (nonatomic,strong) WKWebView *wkWebView;
@end
