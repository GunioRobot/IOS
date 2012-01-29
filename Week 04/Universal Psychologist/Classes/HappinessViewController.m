//
//  HappinessViewController.m
//  Happiness
//
//  Created by CS193p Instructor on 10/5/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "HappinessViewController.h"

@implementation HappinessViewController

@synthesize faceView, slider;
@synthesize happiness;

- (void)updateUI
{
	self.slider.value = self.happiness;
	[self.faceView setNeedsDisplay];
}

- (void)setHappiness:(int)newHappiness
{
    if (newHappiness < 0) newHappiness = 0;
	if (newHappiness > 100) newHappiness = 100;
	happiness = newHappiness;
	[self updateUI];
}

- (IBAction)happinessChanged:(UISlider *)sender
{
	self.happiness = sender.value;
}

- (float)smileForFaceView:(FaceView *)requestor
{
	float smile = 0;
	if (requestor == self.faceView) {
		smile = (((float)self.happiness - 50) / 50);
	}
	return smile;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.faceView.delegate = self;
	UIGestureRecognizer *pinchgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)];
	[self.faceView addGestureRecognizer:pinchgr];
	[pinchgr release];
	[self updateUI];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void)splitViewController:(UISplitViewController *)svc
	 willHideViewController:(UIViewController *)aViewController
		  withBarButtonItem:(UIBarButtonItem*)barButtonItem
	   forPopoverController:(UIPopoverController*)pc
{
	barButtonItem.title = aViewController.title;
	self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc
	 willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)button
{
	self.navigationItem.rightBarButtonItem = nil;
}

- (void)releaseOutlets
{
	self.faceView = nil;
	self.slider = nil;
}

- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[self releaseOutlets];
}


- (void)dealloc {
	[self releaseOutlets];
    [super dealloc];
}

@end
