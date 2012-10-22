//
//  ExcelSecondLevelTableViewController.h
//  ExcelFunctions
//
//  Created by Patrick Cheung on 11/10/12.
//  Copyright (c) 2012 Patrick Cheung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcelSecondLevelTableViewController : UITableViewController
{
    NSMutableSet *functionSet;
}

@property(nonatomic, strong) NSMutableSet *functionSet;

@end
