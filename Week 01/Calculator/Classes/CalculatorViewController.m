//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Michael Work on 10/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()
@property (readonly) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

-(CalculatorBrain *)brain //Getter for brain
{
	if(!brain) brain = [[CalculatorBrain alloc] init];
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit	= sender.titleLabel.text;

	if(userIsInTheMiddleOfTypingANumber)
	{
		if([digit isEqual:(@".")]){
			NSRange range = [display.text rangeOfString: @"."];
			if(range.location != NSNotFound) return;
		}
		display.text = [display.text stringByAppendingString:digit];
	}
	else
	{
		if([digit isEqual:(@".")]){
			digit = [@"0" stringByAppendingString:digit];
		}
		display.text = digit;
		userIsInTheMiddleOfTypingANumber = YES;
	}

}

- (IBAction)operationPressed:(UIButton *)sender
{
	if(userIsInTheMiddleOfTypingANumber)
	{
		self.brain.operand = [display.text doubleValue];
		userIsInTheMiddleOfTypingANumber = NO;
	}

	NSString *operation	= sender.titleLabel.text;
	[self.brain performOperation:operation];
	display.text = [NSString stringWithFormat:@"%g", self.brain.operand];
}

@end
