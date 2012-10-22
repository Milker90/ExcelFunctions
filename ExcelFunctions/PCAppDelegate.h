//
//  PCAppDelegate.h
//  ExcelFunctions
//
//  Created by Patrick Cheung on 9/10/12.
//  Copyright (c) 2012 Patrick Cheung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExcelXMLDataObject.h"

@interface PCAppDelegate : UIResponder <UIApplicationDelegate>
{
    @public
    ExcelXMLDataObject  *object;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ExcelXMLDataObject    *object;

@end
