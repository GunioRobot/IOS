//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Michael Work on 10/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

-(CalculatorBrain *)brain
{
	if(!brain) brain = [[CalculatorBrain alloc] init];
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = [[sender titleLabel] text];
	
	if(userIsInTheMiddleOfTypingANumber)
	{
		if([digit isEqual:(@".")]){
			NSRange range = [[display text] rangeOfString: @"."];
			if(range.location != NSNotFound) return;
		}
		[display setText:[[display text] stringByAppendingString:digit]];
	}
	else 
	{
		if([digit isEqual:(@".")]){
			digit = [@"0" stringByAppendingString:digit];
		}
		[display setText:digit];
		userIsInTheMiddleOfTypingANumber = YES;
	}
						  
}

- (IBAction)operationPressed:(UIButton *)sender
{
	if(userIsInTheMiddleOfTypingANumber)
	{
		[[self brain] setOperand:[[display text] doubleValue]];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	NSString *operation	= [[sender titleLabel] text];
	double result = [[self brain] performOperation:operation];
	[display setText:[NSString stringWithFormat:@"%g", result]];
}

@end
