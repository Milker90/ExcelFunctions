//
//  ExcelSecondLevelTableViewController.m
//  ExcelFunctions
//
//  Created by Patrick Cheung on 11/10/12.
//  Copyright (c) 2012 Patrick Cheung. All rights reserved.
//

#import "ExcelSecondLevelTableViewController.h"
#import "ExcelXMLDataObject.h"
#import "ExcelRootTableViewController.h"
#import "PCAppDelegate.h"

@interface ExcelSecondLevelTableViewController ()

@end

@implementation ExcelSecondLevelTableViewController

@synthesize functionSet;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    ExcelRootTableViewController *ptr = [ExcelRootTableViewController getInstance];
//    self.functionSet = [[NSMutableSet alloc] initWithSet:ptr->currentFuncSet copyItems:YES];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillDisappear:(BOOL)animated
{
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
    ExcelRootTableViewController *ptr = [ExcelRootTableViewController getInstance];
    ExcelXMLDataObject *obj = (ExcelXMLDataObject *) [ptr->currentFuncArray objectAtIndex:0];
    self.title = obj->category;
    return [ptr->currentFuncArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    ExcelRootTableViewController *ptr = [ExcelRootTableViewController getInstance];
    ExcelXMLDataObject *obj = (ExcelXMLDataObject *)[ptr->currentFuncArray objectAtIndex:indexPath.row];
    cell.textLabel.text = obj->function;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PCAppDelegate *appDelegate = (PCAppDelegate *)[[UIApplication sharedApplication] delegate];
    ExcelRootTableViewController *ptr = [ExcelRootTableViewController getInstance];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    ExcelXMLDataObject *obj = (ExcelXMLDataObject *)[ptr->currentFuncArray objectAtIndex:indexPath.row];
    if (appDelegate->object == nil) appDelegate->object = [[ExcelXMLDataObject alloc] init];
    appDelegate->object->function = obj->function;
    appDelegate->object->url = obj->url;
    appDelegate->object->description = obj->description;
    appDelegate->object->category = obj->category;
}

@end
