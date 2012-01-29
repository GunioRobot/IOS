//
//  GraphViewController.m
//  GraphCalculator
//
//  Created by Michael Work on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"

@implementation GraphViewController

@synthesize expression;
@synthesize graphView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

-(void)setExpression:(id)newExpression
{
	[expression release];
	expression = [newExpression retain];
	[self.graphView setNeedsDisplay];
}

- (GraphView *) graphView {
	if(!graphView)
	{
		graphView = [[GraphView alloc] initWithFrame:[self.view bounds]];
	}
	return graphView;
}

- (void)loadView {
	[super loadView];

	self.graphView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.graphView.backgroundColor = [UIColor whiteColor];
	self.graphView.delegate = self;
    [self.view addSubview:self.graphView];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.graphView.delegate = self;

	UIPinchGestureRecognizer *pinchgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(pinch:)];
	[self.graphView addGestureRecognizer:pinchgr];
	[pinchgr release];

	UIPanGestureRecognizer *pangr = [[UIPanGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(pan:)];
	[self.graphView addGestureRecognizer:pangr];
	[pangr release];

	UITapGestureRecognizer *dtapgr = [[UITapGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(doubleTap:)];
	dtapgr.numberOfTapsRequired = 2;
	[self.graphView addGestureRecognizer:dtapgr];
	[dtapgr release];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
	return YES;
}

- (float)yForXvalue:(float)xValue forGraphView:(GraphView *)requestor
{
	return [CalculatorBrain evaluateExpression:self.expression usingVariableValues:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:xValue],@"x", nil]];
}



// Handles the hiding and showing of the bar button for the splitview
- (void) splitViewController:(UISplitViewController *)svc
	  willHideViewController:(UIViewController *)aViewController
		   withBarButtonItem:(UIBarButtonItem *)barButtonItem
		forPopoverController:(UIPopoverController *)pc
{
	barButtonItem.title = aViewController.title;
	self.navigationItem.leftBarButtonItem = barButtonItem;
	// if we are not in a UINavigationController this method (appropriately) does nothing
}

- (void) splitViewController:(UISplitViewController *)svc
	  willShowViewController:(UIViewController *)aViewController
   invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	self.navigationItem.leftBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)releaseOutlets
{
	self.graphView = nil;
}

- (void)viewDidUnload
{
	[self releaseOutlets];
}

- (void)dealloc
{
	[self releaseOutlets];
	self.expression = nil;
	[super dealloc];
}


@end
