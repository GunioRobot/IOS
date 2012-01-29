//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Michael Work on 10/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController
{
	IBOutlet UILabel *display;
	BOOL userIsInTheMiddleOfTypingANumber;
	CalculatorBrain *brain;
}

@property BOOL userIsInTheMiddleOfTypingANumber;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)variablePressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)solvePressed;
@end

