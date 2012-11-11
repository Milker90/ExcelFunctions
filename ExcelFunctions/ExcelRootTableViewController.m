//
//  ExcelRootTableViewController.m
//  ExcelFunctions
//
//  Created by Patrick Cheung on 11/10/12.
//  Copyright (c) 2012 Patrick Cheung. All rights reserved.
//

#import "ExcelRootTableViewController.h"
#import "ExcelXMLParser.h"
#import "ExcelXMLDataObject.h"

@interface ExcelRootTableViewController ()

@end

@implementation ExcelRootTableViewController

@synthesize bannerIsVisible;
@synthesize functions;
@synthesize excelCategory;
@synthesize currentFuncArray;
@synthesize currentSelected;

static ExcelRootTableViewController *instance = nil;

+ (ExcelRootTableViewController *) getInstance
{
    @synchronized(self)
    {
        if (instance == nil)
        {
            instance = [ExcelRootTableViewController new];
        }
    }
    return instance;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.frame = CGRectMake(0.0, 0.0, adView.frame.size.width, adView.frame.size.height);
    [adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin];
    [self.view addSubview:adView];
    adView.delegate=self;
    self.bannerIsVisible=NO;
    
    self.excelCategory = [[[NSMutableArray alloc] init] autorelease];
    self.title = @"Excel Function";
    [self readFileAction];
    
    NSString *tmp = nil;
    
    for (ExcelXMLDataObject *obj in functions) {
        if (tmp == nil) {
            if (obj != nil){
                [self.excelCategory addObject:obj->category];
                tmp = obj->category;
            }
        } else {
            if (obj != nil) {
                if (![obj->category isEqualToString:tmp]) {
                    [self.excelCategory addObject:obj->category];
                    tmp = obj->category;
                }
            }
        }
    }
    //excelDict = [[NSDictionary alloc] init];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ExcelRootTableViewController *ptr = [ExcelRootTableViewController getInstance];
    self.currentSelected = (NSString*)[self.excelCategory objectAtIndex:indexPath.row];
    if (currentFuncArray == nil) {
        currentFuncArray = [[NSMutableArray alloc] init];
    } else {
        [currentFuncArray removeAllObjects];
    }
    for (ExcelXMLDataObject *obj in self.functions) {
        if ([obj->category isEqualToString:self.currentSelected]) {
            [currentFuncArray addObject:obj];
        }
    }
    ptr->currentFuncArray = currentFuncArray;
    adView = nil;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    //return 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return 0;
    return [self.excelCategory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = (NSString*)[self.excelCategory objectAtIndex:indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void) readFileAction {
    NSFileManager *filemgr;
    NSData *databuffer;
    NSString *datafile;
    NSString *docsDir;
    NSArray *dirPaths;
    filemgr = [NSFileManager defaultManager];
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    datafile = [docsDir stringByAppendingPathComponent: @"xl_xml_data.xml"];
    NSLog(@"%@", datafile);
    if ([filemgr isReadableFileAtPath:datafile] == YES) {
        databuffer = [filemgr contentsAtPath:datafile];
        [self doParse:databuffer];
    }
}

- (void) doParse:(NSData *)data {
    
    // create and init NSXMLParser object
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    
    // create and init our delegate
    ExcelXMLParser *parser = [[ExcelXMLParser alloc] initXMLParser];
    
    // set delegate
    [nsXmlParser setDelegate:parser];
    
    // parsing...
    BOOL success = [nsXmlParser parse];
    
    // test the result
    if (success) {
        self.functions = [parser functions];
    } else {
        NSLog(@"Error parsing document!");
    }
    
    [parser release];
    [nsXmlParser release];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        adView.frame = CGRectMake(0.0, 0.0, adView.frame.size.width, adView.frame.size.height);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        adView.frame = CGRectMake(0.0, 0.0, adView.frame.size.width, adView.frame.size.height);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}
@end
