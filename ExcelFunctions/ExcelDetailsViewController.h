//
//  ExcelDetailsViewController.h
//  ExcelFunctions
//
//  Created by Patrick Cheung on 11/10/12.
//  Copyright (c) 2012 Patrick Cheung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcelDetailsViewController : UIViewController
{
    UIWebView   *webView;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
