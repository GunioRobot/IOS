//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Michael Work on 10/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject
{
	@private
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
	double memory;
}

@property double operand;
- (double)performOperation:(NSString *)operation;

@end
