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
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
	double memory;
}

- (void)setOperand:(double)aDouble;
- (double)performOperation:(NSString *)operation;

@end
