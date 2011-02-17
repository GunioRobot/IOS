//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by CS193p Instructor on 10/7/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@implementation PsychologistViewController

- (HappinessViewController *)happinessViewController
{
	if (!happinessViewController) happinessViewController = [[HappinessViewController alloc] init];
	return happinessViewController;
}

- (void)showDiagnosis:(int)diagnosis
{
	self.happinessViewController.happiness = diagnosis;
	self.happinessViewController.title = [NSString stringWithFormat:@"Diagnosis = %d", diagnosis];
	if (self.happinessViewController.view.window == nil) {
		[self.navigationController pushViewController:self.happinessViewController animated:YES];
	}
}

- (void)viewDidLoad
{
	self.title = @"Psychologist";
}

- (IBAction)sad
{
	[self showDiagnosis:0];
}

- (IBAction)happy
{
	[self showDiagnosis:100];
}

- (IBAction)soso
{
	[self showDiagnosis:50];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

- (void)dealloc
{
	[happinessViewController release];
	[super dealloc];
}

@end
