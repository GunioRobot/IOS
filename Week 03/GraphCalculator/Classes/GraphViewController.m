//
//  GraphViewController.m
//  GraphCalculator
//
//  Created by Michael Work on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphViewController.h"
#define GRAPH_SCALE_INIT 40
#define GRAPH_SCALE_STEP 10

@implementation GraphViewController

@synthesize graphScale;
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
	self.graphScale = GRAPH_SCALE_INIT;
	self.graphView.delegate = self;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait) ||
			(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) ||
			(interfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
			(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (int)scaleForGraphView:(GraphView *)requestor
{
	return self.graphScale;
}

- (float)yForXvalue:(float)xValue forGraphView:(GraphView *)requestor
{
	return [CalculatorBrain evaluateExpression:self.expression usingVariableValues:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:xValue],@"x", nil]];
}


- (IBAction)zoomIn:(UIButton *)sender
{
	self.graphScale += GRAPH_SCALE_STEP;
	[self.graphView setNeedsDisplay];
}

- (IBAction)zoomOut:(UIButton *)sender
{
	if(self.graphScale > GRAPH_SCALE_STEP)
	{
		self.graphScale -= GRAPH_SCALE_STEP;
	}
	[self.graphView setNeedsDisplay];
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
