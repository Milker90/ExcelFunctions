//
//  ExcelRootTableViewController.h
//  ExcelFunctions
//
//  Created by Patrick Cheung on 11/10/12.
//  Copyright (c) 2012 Patrick Cheung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ExcelRootTableViewController : UITableViewController <ADBannerViewDelegate>
{
    ADBannerView    *adView;
    BOOL bannerIsVisible;
    
    NSMutableArray  *functions;
    NSMutableArray  *excelCategory;
    NSString        *currentSelected;
    
    @public
    NSMutableArray  *currentFuncArray;
}

@property (nonatomic,assign) BOOL bannerIsVisible;

@property (nonatomic, strong) NSMutableArray *functions;
@property (nonatomic, strong) NSMutableArray *excelCategory;
@property (nonatomic, strong) NSString       *currentSelected;
@property (nonatomic, strong) NSMutableArray *currentFuncArray;

+(ExcelRootTableViewController *)getInstance;

- (void) readFileAction;

@end
