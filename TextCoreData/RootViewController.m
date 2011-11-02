//
//  RootViewController.m
//  TextCoreData
//
//  Created by xiaosong on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController
@synthesize managedObjectContext,cellsArray;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRalation)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    //          ----fetch-----
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Relation" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSError *error = nil;
    NSMutableArray *mutableResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    [self setCellsArray:mutableResults];
    [mutableResults release];
    [request release];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellsArray count];
    // Return the number of rows in the section.
//    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    Relation *rela = (Relation*)[cellsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = rela.INFO1;
    // Configure the cell...
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    
    
    RelationViewController *rela = [[RelationViewController alloc] initWithNibName:@"RelationViewController" bundle:nil];
    Relation *relaInfo = [cellsArray objectAtIndex:indexPath.row];
    NSLog(@"%@",relaInfo.INFO1);
    selectIndex = indexPath.row;
    rela.relaDelegate = self;
    [self.navigationController pushViewController:rela animated:YES];
    [rela setData:[NSArray arrayWithObjects:relaInfo.INFO1,relaInfo.INFO2,relaInfo.INFO3,relaInfo.INFO4, nil]];
    [rela.view viewWithTag:5].hidden = YES;
    [rela release];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *objectToDelete = [cellsArray objectAtIndex:indexPath.row];
        [managedObjectContext deleteObject:objectToDelete];
        [cellsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            //
        }
    }

}

#pragma mark - addRalation
-(void)addRalation{
    RelationViewController *rela = [[RelationViewController alloc] initWithNibName:@"RelationViewController" bundle:nil];
    rela.relaDelegate = self;
    [self.navigationController pushViewController:rela animated:YES];
    [rela.view viewWithTag:7].hidden = YES;
    [rela release];
}

-(void)commit:(NSArray*)array
{
    Relation *relation = (Relation*)[NSEntityDescription insertNewObjectForEntityForName:@"Relation" inManagedObjectContext:managedObjectContext];
    relation.INFO1 = [array objectAtIndex:0];
    relation.INFO2 = [array objectAtIndex:1];
    relation.INFO3 = [array objectAtIndex:2];
    relation.INFO4 = [array objectAtIndex:3];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
//        
    }
    [self.cellsArray insertObject:relation atIndex:0];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)commitChange:(NSArray*)array{
    //select;
    /*
    Relation *relation = (Relation*)[NSEntityDescription insertNewObjectForEntityForName:@"Relation" inManagedObjectContext:managedObjectContext];
    relation.INFO1 = [array objectAtIndex:0];
    relation.INFO2 = [array objectAtIndex:1];
    relation.INFO3 = [array objectAtIndex:2];
    relation.INFO4 = [array objectAtIndex:3];
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        //        
    }
    [self.cellsArray insertObject:relation atIndex:selectIndex];
    
    Relation *relation2 = [cellsArray objectAtIndex:selectIndex+1];
    [managedObjectContext deleteObject:relation2];
    [self.cellsArray removeObjectAtIndex:selectIndex+1];
    
    
    [self.tableView reloadData];
     */
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Relation" 
                                              inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSError *error = nil;
    NSMutableArray *mutableResults = [[managedObjectContext executeFetchRequest:request
                                                                          error:&error] mutableCopy];
    Relation *relation = [mutableResults objectAtIndex:selectIndex];
    relation.INFO1 = [array objectAtIndex:0];
    relation.INFO2 = [array objectAtIndex:1];
    relation.INFO3 = [array objectAtIndex:2];
    relation.INFO4 = [array objectAtIndex:3];
    
    if (![managedObjectContext save:&error]) {
        //        
    }
    
    
    
    [self setCellsArray:[self fetchAll]];
    [self.tableView reloadData];
    
    [request release];
    [mutableResults release];
    
    
}

-(NSArray*)fetchAll{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Relation" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    NSError *error = nil;
    NSMutableArray *mutableResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    [request release];
    [mutableResults autorelease];
    return mutableResults;
}

@end
