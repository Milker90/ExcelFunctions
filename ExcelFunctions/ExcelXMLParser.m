//
//  ExcelXMLParser.m
//  ExcelFunctions
//
//  Created by Patrick Cheung on 9/11/12.
//  Copyright (c) 2012 Patrick Cheung. All rights reserved.
//

#import "ExcelXMLParser.h"

@implementation ExcelXMLParser
@synthesize function, functions;

- (ExcelXMLParser *) initXMLParser {
    self = [super init];
    if (!self) {
        return nil;
    }
    // init array of user objects
    if (self) {
        functions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) dealloc {
    [functions release];
    [function release];
    [super dealloc];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"record"]) {
        function = [[ExcelXMLDataObject alloc] init];
        //We do not have any attributes in the user elements, but if
        // you do, you can extract them here:
        function.category = [attributeDict objectForKey:@"category"];
        
        function.description = [attributeDict objectForKey:@"description"];
        function.url = [attributeDict objectForKey:@"url"];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentElementValue) {
        // init the ad hoc string with the value
        if (![string isEqualToString:@"\n"]) {
            currentElementValue = [[NSMutableString alloc] initWithString:string];
        }
    } else {
        // append value to the ad hoc string
        if (![string isEqualToString:@"\n"]) {
            [currentElementValue appendString:string];
        }
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"gesmes:Envelope"]) {
        // We reached the end of the XML document
        return;
    }
    
    if ([elementName isEqualToString:@"record"]) {
        // We are done with user entry – add the parsed user
        // object to our user array
        if (function != nil) {
            [functions addObject:function];
            // release user object
            [function release];
            function = nil;
        }
    } else if ([elementName isEqualToString:@"function"]) {
        function.function = currentElementValue;
    } else if ([elementName isEqualToString:@"url"]) {
        function.url = currentElementValue;
    } else if ([elementName isEqualToString:@"description"]) {
        function.description = currentElementValue;
    } else if ([elementName isEqualToString:@"category"]) {
        function.category = currentElementValue;
    } else {
        // The parser hit one of the element values.
        // This syntax is possible because User object
        // property names match the XML user element names
        //[currency setValue:currentElementValue forKey:elementName];
    }
    
    [currentElementValue release];
    currentElementValue = nil;
}

@end
