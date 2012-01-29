//
//  TopPlacesTableViewController.m
//  Places
//
//  Created by Michael McGlynn on 7/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "PlacePhotosTableViewController.h"
#import "FlickrFetcher.h"

@interface TopPlacesTableViewController()
	@property (retain) NSArray *places;
@end

@implementation TopPlacesTableViewController

@synthesize places;

- (NSArray *)places
{
	if(!places)
	{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		places = [[FlickrFetcher topPlaces] retain];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}
	return places;
}

#pragma mark -
#pragma mark Initialization

- (void)setup
{

	UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:0];

	self.tabBarItem = item;
	[item release];
}




- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		[self setup];
    }
    return self;
}



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Top Rated";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
	NSLog(@"%@", self.places);
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
    return self.places.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"TopPlacesCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

	NSString *content = [[self.places objectAtIndex:indexPath.row] objectForKey:@"_content"];
	NSArray *components = [content componentsSeparatedByString:@","];
	cell.textLabel.text = [components objectAtIndex:0];

	NSRange theRange;
	theRange.location = 1;
	theRange.length = [components count] -1;

	components = [components subarrayWithRange:theRange];

	cell.detailTextLabel.text = [components componentsJoinedByString:@","];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...

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

    PlacePhotosTableViewController *placePhotosController = [[PlacePhotosTableViewController alloc] init];
    placePhotosController.place_id =  [[self.places objectAtIndex:indexPath.row] objectForKey:@"place_id"];
	placePhotosController.title = [[self.places objectAtIndex:indexPath.row] objectForKey:@"_content"];
	// ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:placePhotosController animated:YES];
    [placePhotosController release];


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
	[places release];
    [super dealloc];
}


@end

