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
- (float)yForXvalue:(float)xValue forGraphView:(GraphView *)requestor;
@end

@interface GraphView : UIView {
	CGFloat scale;
	CGPoint	originOffset;
	id <GraphViewDelegate> delegate;

}

@property CGFloat scale;
@property CGPoint originOffset;
@property (readonly) CGPoint origin;
@property (assign) id <GraphViewDelegate> delegate;

@end
