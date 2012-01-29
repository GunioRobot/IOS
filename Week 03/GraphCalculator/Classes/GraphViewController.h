//
//  GraphViewController.h
//  GraphCalculator
//
//  Created by Michael Work on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"
#import "CalculatorBrain.h";

@interface GraphViewController : UIViewController <GraphViewDelegate>{
	int graphScale;
	id expression;

	IBOutlet GraphView *graphView;
}

@property int graphScale;
@property (retain) id expression;

@property (retain) IBOutlet GraphView *graphView;

- (IBAction)zoomIn:(UIButton *)sender;
- (IBAction)zoomOut:(UIButton *)sender;

- (void)releaseOutlets;
@end
