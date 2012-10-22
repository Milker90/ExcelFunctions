//
//  ExcelXMLDataObject.h
//  ExcelFunctions
//
//  Created by Patrick Cheung on 11/10/12.
//  Copyright (c) 2012 Patrick Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExcelXMLDataObject : NSObject
{
 @public
    NSString *category;
    NSString *function;
    NSString *url;
    NSString *description;
}

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *function;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *description;
@end
