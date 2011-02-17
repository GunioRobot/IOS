//
//  PsychologistViewController.h
//  Psychologist
//
//  Created by CS193p Instructor on 10/7/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HappinessViewController.h"

@interface PsychologistViewController : UIViewController
{
	HappinessViewController *happinessViewController;
}

@property (readonly) HappinessViewController *happinessViewController;

- (IBAction)sad;
- (IBAction)happy;
- (IBAction)soso;

@end
