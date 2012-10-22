//
//  ExcelDetailsViewController.m
//  ExcelFunctions
//
//  Created by Patrick Cheung on 11/10/12.
//  Copyright (c) 2012 Patrick Cheung. All rights reserved.
//

#import "ExcelDetailsViewController.h"
#import "PCAppDelegate.h"

@interface ExcelDetailsViewController ()

@end

@implementation ExcelDetailsViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    PCAppDelegate  *ptr = (PCAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.title = ptr->object->function;
	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:ptr->object->url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
