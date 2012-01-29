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
@synthesize userIsInTheMiddleOfTypingANumber;

-(CalculatorBrain *)brain //Getter for brain
{
	if(!brain) brain = [[CalculatorBrain alloc] init];
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit	= sender.titleLabel.text;

	if(self.userIsInTheMiddleOfTypingANumber)
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

- (IBAction)variablePressed:(UIButton *)sender
{
	if(!self.userIsInTheMiddleOfTypingANumber)
	{
		[self.brain setVariableAsOperand:sender.titleLabel.text];
	}
	display.text = [CalculatorBrain descriptionOfExpression:self.brain.expression];
}

- (IBAction)operationPressed:(UIButton *)sender
{
	if(self.userIsInTheMiddleOfTypingANumber)
	{
		self.brain.operand = [display.text doubleValue];
		self.userIsInTheMiddleOfTypingANumber = NO;
	}

	NSString *operation	= sender.titleLabel.text;
	[self.brain performOperation:operation];

	if([[CalculatorBrain variablesInExpression:self.brain.expression] count])
	{
		display.text = [CalculatorBrain descriptionOfExpression:self.brain.expression];
	}
	else {
		display.text = [NSString stringWithFormat:@"%g", self.brain.operand];
	}
}

- (IBAction)solvePressed
{
	//[CalculatorBrain propertyListForExpression: self.brain.expression];
	//NSLog(@"Description ofexpression: %@", [CalculatorBrain descriptionOfExpression:self.brain.expression]);
	//NSLog(@"Variables in expression: %@", [CalculatorBrain variablesInExpression:self.brain.expression]);
	NSDictionary *variables = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:5],@"x", [NSNumber numberWithDouble:7],@"y",[NSNumber numberWithDouble:9],@"z",nil];
	display.text = [NSString stringWithFormat:@"%g", [CalculatorBrain evaluateExpression:self.brain.expression usingVariableValues:variables]];
}


- (void)dealloc
{
	[brain release];
	[super dealloc];
}

@end
