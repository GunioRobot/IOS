//
//  PlacePhotosTableViewController.m
//  Places
//
//  Created by Michael McGlynn on 8/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlacePhotosTableViewController.h"
#import	"PhotoScrollViewController.h"
#import "FlickrFetcher.h"

@interface PlacePhotosTableViewController()
@property (retain) NSArray *photos;
@end


@implementation PlacePhotosTableViewController
@synthesize photos;
@synthesize	place_id;

-(void)setPlace_id:(NSString *)aPlace_id
{
	if (![aPlace_id isEqualToString:place_id]){
		place_id = aPlace_id;

	}
}

-(NSArray *) photos
{
	if(!photos)
	{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		photos = [[FlickrFetcher photosAtPlace:self.place_id] retain];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}

	return photos;
}


#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//	NSLog(@"place id = %@", self.place_id);
//	NSLog(@"%@", self.photos);
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
}



#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.photos.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"PlacePhotosCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

	NSString *title = [[self.photos objectAtIndex:indexPath.row] objectForKey:@"title"];
	NSString *description = [[[self.photos objectAtIndex:indexPath.row] objectForKey:@"description"] objectForKey:@"_content"];

	cell.textLabel.text = ([title length] > 0) ? title : (([description length] > 0) ? description : @"Unknown");

	cell.detailTextLabel.text = ([title length] > 0) ? description : @"";
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];



	 farm, server, id, secret
    */
	PhotoScrollViewController *photoScrollViewController = [[PhotoScrollViewController alloc] init];
	photoScrollViewController.photoInfo = [self.photos objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:photoScrollViewController animated:YES];
    [photoScrollViewController release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[photos release];
	[place_id release];
    [super dealloc];
}


@end

