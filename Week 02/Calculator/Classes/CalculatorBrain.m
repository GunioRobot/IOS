//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Michael Work on 10/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
#define VARIABLE_PREFIX @"%"

@interface CalculatorBrain()
@property(readonly) NSMutableArray *internalExpression;
-(void) addTermToExpression:(id)term;
@end


@implementation CalculatorBrain

@synthesize operand, waitingOperand, memory, waitingOperation;

- (NSMutableArray *)internalExpression
{
	if(!internalExpression) internalExpression = [[NSMutableArray alloc] init];
	return internalExpression;
}

-(void) addTermToExpression:(id)term
{
	[self.internalExpression addObject:term];
	NSLog(@"Term Added: %@", [self.internalExpression lastObject]);
	NSLog(@"expression = %@", internalExpression);
	//NSLog(@"Current Expression: %@", self.internalExpression);
}

- (id)expression
{
	return [[internalExpression copy] autorelease];
}

- (void)setOperand:(double)aDouble
{
	[self addTermToExpression:[NSNumber numberWithDouble:aDouble]];
	operand = aDouble;
}

- (void)setVariableAsOperand:(NSString *)variableName
{
	[self addTermToExpression:[VARIABLE_PREFIX stringByAppendingString:variableName]];
}


- (void)performWaitingOperation
{
	if([@"+" isEqual: self.waitingOperation])
	{
		operand = self.waitingOperand + operand;
	}
	else if([@"-" isEqual:self.waitingOperation])
	{
		operand = self.waitingOperand - operand;
	}
	else if([@"*" isEqual:self.waitingOperation])
	{
		operand = self.waitingOperand * operand;
	}
	else if([@"/" isEqual:self.waitingOperation])
	{
		if(operand)
		{
			operand = self.waitingOperand / operand;
		}
	}
}

- (double)performOperation:(NSString *)operation
{
	[self addTermToExpression:operation];
//	[self.internalExpression addObject:operation];

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
		self.memory = operand;
	}
	else if ([operation isEqual:@"Recall"])
	{
		operand = self.memory;
	}
	else if ([operation isEqual:@"Mem+"])
	{
		self.memory += operand;
	}
	else if ([operation isEqual:@"C"])
	{
		operand = 0;
		self.memory = 0;
		self.waitingOperand = 0;
		self.waitingOperation = nil;
		[internalExpression removeAllObjects];
	}
	else
	{
		[self performWaitingOperation];
		self.waitingOperation = operation;
		self.waitingOperand = operand;
	}

	return operand;
}

+ (double)evaluateExpression:(id)anExpression
		 usingVariableValues:(NSDictionary *)variables
{
	CalculatorBrain *brain = [[CalculatorBrain alloc] init];

	for(id obj in anExpression)
	{
		if([obj isKindOfClass:[NSNumber class]])
		{
			[brain setOperand:[obj doubleValue]];
		}
		else if([obj isKindOfClass:[NSString class]])
		{
			NSLog(@"Current term: %@", obj);
			if(([obj rangeOfString:VARIABLE_PREFIX].location == 0) && ([obj length] > [VARIABLE_PREFIX length]))
			 {
				 // Term is a variable, perform the substitution.
				 double sub = [[variables objectForKey:[obj substringFromIndex:1]] doubleValue];
				 NSLog(@"Substituting %g for %@", sub, [obj substringFromIndex:1]);
				 [brain setOperand: sub];
			 }
			else {
				// Term is an operation, perform it
				[brain performOperation:obj];
			}
		}
	}

	if(![[anExpression lastObject] isEqual:@"="])
	{
		//If there is no "=" at the end of the expression, add one in
		[brain performOperation:@"="];
	}

	double result = brain.operand;
	NSLog(@"Result = %g", result);
	[brain release];
	return result;
}

+ (NSSet *)variablesInExpression:(id)anExpression
{
	NSMutableSet *uniqueVariables = [NSMutableSet set];
	for(id obj in anExpression)
	{
		if([obj isKindOfClass:[NSString class]])
		{
			if(([obj rangeOfString:VARIABLE_PREFIX].location == 0) && ([obj length] > [VARIABLE_PREFIX length]) && ![uniqueVariables member:obj])
			{
				[uniqueVariables addObject:[obj substringFromIndex:1]];
			}
		}
	}

	return uniqueVariables;
}

+ (NSString *)descriptionOfExpression:(id)anExpression
{
	NSMutableString	 *description = [NSMutableString string];
	for(id obj in anExpression)
	{
		if([obj isKindOfClass:[NSString class]] && ([obj rangeOfString:VARIABLE_PREFIX].location == 0) && ([obj length] > [VARIABLE_PREFIX length]))
		{
			[description appendString:[obj substringFromIndex:1]];
		}
		else {
			[description appendFormat:@"%@", obj];
		}
	}
	return description;
}

+ (id)propertyListForExpression:(id)anExpression
{
	// See http://stackoverflow.com/questions/4536077/memory-management-of-objects-returned-by-methods-ios-objective-c
	return [[anExpression retain] autorelease];
}


+ (id)expressionForPropertyList:(id)propertyList
{
	// See http://stackoverflow.com/questions/4536077/memory-management-of-objects-returned-by-methods-ios-objective-c
	return [[propertyList retain] autorelease];
}

-(void)dealloc
{
	[waitingOperation release];
	[internalExpression release];
	[super dealloc];
}

@end
