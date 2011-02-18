//
//  GraphViewController.m
//  GraphCalculator
//
//  Created by Michael Work on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"

#define GRAPH_SCALE_STEP 10

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	
    [super viewDidLoad];
	self.graphView.delegate = self;	
	
	UIGestureRecognizer *pinchgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(pinch:)];
	[self.graphView addGestureRecognizer:pinchgr];
	[pinchgr release];	

	UIGestureRecognizer *pangr = [[UIPanGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(pan:)];
	[self.graphView addGestureRecognizer:pangr];
	[pangr release];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait) ||
			(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) ||
			(interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
			(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (float)yForXvalue:(float)xValue forGraphView:(GraphView *)requestor
{
	return [CalculatorBrain evaluateExpression:self.expression usingVariableValues:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:xValue],@"x", nil]];
}

- (IBAction)zoomIn:(UIButton *)sender
{
	self.graphView.scale += GRAPH_SCALE_STEP;
}

- (IBAction)zoomOut:(UIButton *)sender
{
	self.graphView.scale -= GRAPH_SCALE_STEP;
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
