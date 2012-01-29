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
	double waitingOperand;
	double memory;
	NSString *waitingOperation;
	NSMutableArray *internalExpression;
}

@property double operand, waitingOperand, memory;
@property (copy) NSString *waitingOperation;
@property (readonly) id expression;

- (void)setOperand:(double)aDouble;
- (void)setVariableAsOperand:(NSString *)variableName;
- (double)performOperation:(NSString *)operation;

+ (double)evaluateExpression:(id)anExpression
		 usingVariableValues:(NSDictionary *)variables;

+ (NSSet *)variablesInExpression:(id)anExpression;
+ (NSString *)descriptionOfExpression:(id)anExpression;

+ (id)propertyListForExpression:(id)anExpression;
+ (id)expressionForPropertyList:(id)propertyList;
@end
