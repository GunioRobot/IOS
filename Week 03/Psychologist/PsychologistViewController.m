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

- (void)showDiagnosis:(int)diagnosis
{
	HappinessViewController *hvc = [[HappinessViewController alloc] init];
	hvc.happiness = diagnosis;
	hvc.title = [NSString stringWithFormat:@"%d", diagnosis];
	[self.navigationController pushViewController:hvc animated:YES];
	[hvc release];
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

@end
