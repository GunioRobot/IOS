//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Michael Work on 10/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "GraphViewController.h"


@interface CalculatorViewController()
	@property (readonly) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize userIsInTheMiddleOfTypingANumber;
@synthesize display;

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
			NSRange range = [self.display.text rangeOfString: @"."];
			if(range.location != NSNotFound) return;
		}
		self.display.text = [self.display.text stringByAppendingString:digit];
	}
	else
	{
		if([digit isEqual:(@".")]){
			digit = [@"0" stringByAppendingString:digit];
		}
		self.display.text = digit;
		userIsInTheMiddleOfTypingANumber = YES;
	}

}

- (IBAction)variablePressed:(UIButton *)sender
{
	if(!self.userIsInTheMiddleOfTypingANumber)
	{
		[self.brain setVariableAsOperand:sender.titleLabel.text];
	}
	self.display.text = [CalculatorBrain descriptionOfExpression:self.brain.expression];
}

- (IBAction)operationPressed:(UIButton *)sender
{
	if(self.userIsInTheMiddleOfTypingANumber)
	{
		self.brain.operand = [self.display.text doubleValue];
		self.userIsInTheMiddleOfTypingANumber = NO;
	}

	NSString *operation	= sender.titleLabel.text;
	[self.brain performOperation:operation];

	if([[CalculatorBrain variablesInExpression:self.brain.expression] count])
	{
		self.display.text = [CalculatorBrain descriptionOfExpression:self.brain.expression];
	}
	else {
		self.display.text = [NSString stringWithFormat:@"%g", self.brain.operand];
	}
}

- (IBAction)graphPressed
{
	//Finish off the expression, init the GraphViewController with the current expression and push it on the stack
	[self.brain performOperation:@"="];
	GraphViewController *gvc = [[GraphViewController alloc] init];
	gvc.title = [CalculatorBrain descriptionOfExpression:self.brain.expression];
	gvc.expression = self.brain.expression;
	[self.navigationController pushViewController:gvc animated:YES];
	[gvc release];
}

- (void)releaseOutlets
{
	self.display = nil;
}

- (void)viewDidUnload
{
	[self releaseOutlets];
}

- (void)dealloc
{
	[self releaseOutlets];
	[brain release];
	[super dealloc];
}

@end
