//
//  graphView.h
//  GraphCalculator
//
//  Created by Michael Work on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphView; //Lookahead

@protocol GraphViewDelegate
- (int)scaleForGraphView:(GraphView *)requestor;
- (float)yForXvalue:(float)xValue forGraphView:(GraphView *)requestor;
@end

@interface GraphView : UIView {
	id <GraphViewDelegate> delegate;
}

@property (assign) id <GraphViewDelegate> delegate;

@end
