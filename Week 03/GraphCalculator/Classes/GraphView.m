//
//  graphView.m
//  GraphCalculator
//
//  Created by Michael Work on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer.h"

@implementation GraphView
@synthesize delegate;


- (void)setup
{
	self.contentMode = UIViewContentModeRedraw;
}


- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		[self setup];
    }
    return self;
}

- (void)awakeFromNib
{
	[self setup];
}

- (void)drawRect:(CGRect)rect {
	CGPoint midPoint;
	midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
	midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;

	[[UIColor blueColor] set] ;
	int scale = [self.delegate scaleForGraphView:self];
    [AxesDrawer drawAxesInRect:self.bounds originAtPoint:midPoint scale:scale];

	float contentScale = (float)self.contentScaleFactor;

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextBeginPath(context);

	for (float i = self.bounds.origin.x; i <= self.bounds.size.width * contentScale; i++) {
		float graphX = (i - (midPoint.x * contentScale))/(scale * contentScale);
		float graphY = [self.delegate yForXvalue:graphX forGraphView:self];
		float yVal = (midPoint.y* contentScale) - (graphY* contentScale * scale);

		if(i==0)
		{
			// Set start point
			CGContextMoveToPoint(context, i/contentScale, yVal/contentScale);
		}
		else
		{
			//NSLog(@"pixelX = %f, pointX = %f, pixelY= %f, pointY=%f",  i, (i/contentScale), yVal, (yVal/contentScale));
			CGContextAddLineToPoint(context, i/contentScale, yVal/contentScale);
		}
	}


	[[UIColor blackColor] setStroke];
	CGContextDrawPath(context,kCGPathStroke);

}

- (void)dealloc {
    [super dealloc];
}


@end
