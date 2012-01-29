//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Michael Work on 10/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

@synthesize operand;

- (void)performWaitingOperation
{
	if([@"+" isEqual: waitingOperation])
	{
		operand = waitingOperand + operand;
	}
	else if([@"-" isEqual:waitingOperation])
	{
		operand = waitingOperand - operand;
	}
	else if([@"*" isEqual:waitingOperation])
	{
		operand = waitingOperand * operand;
	}
	else if([@"/" isEqual:waitingOperation])
	{
		if(operand)
		{
			operand = waitingOperand / operand;
		}
	}
}

- (double)performOperation:(NSString *)operation
{
	if([operation isEqual:@"sqrt"])
	{
		operand = sqrt(operand);
	}
	else if([operation isEqual:@"1/x"])
	{
		if(operand)
		{
			operand = 1 / operand;
		}
	}
	else if ([operation isEqual:@"+/-"])
	{
		operand = -1 * operand;
	}
	else if ([operation isEqual:@"sin"])
	{
		operand = sin(operand);
	}
	else if ([operation isEqual:@"cos"])
	{
		operand = cos(operand);
	}
	else if ([operation isEqual:@"Store"])
	{
		memory = operand;
	}
	else if ([operation isEqual:@"Recall"])
	{
		operand = memory;
	}
	else if ([operation isEqual:@"Mem+"])
	{
		memory += operand;
	}
	else if ([operation isEqual:@"C"])
	{
		operand = 0;
		memory = 0;
		waitingOperand = 0;
		waitingOperation = nil;
	}
	else
	{
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}

	return operand;
}

@end
