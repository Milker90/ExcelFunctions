//
//  ExcelXMLParser.h
//  ExcelFunctions
//
//  Created by Patrick Cheung on 9/11/12.
//  Copyright (c) 2012 Patrick Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExcelXMLDataObject.h"

@class ExcelXMLDataObject;

@interface ExcelXMLParser : NSObject <NSXMLParserDelegate>{
    // an ad hoc string to hold element value
    NSMutableString *currentElementValue;
    // user object
    ExcelXMLDataObject *function;
    // array of user objects
    NSMutableArray *functions;
}

@property (nonatomic, retain) ExcelXMLDataObject *function;
@property (nonatomic, retain) NSMutableArray * functions;

- (ExcelXMLParser *) initXMLParser;

@end
