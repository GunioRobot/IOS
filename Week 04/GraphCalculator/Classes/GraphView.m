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
@synthesize originOffset;

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

+ (BOOL)scaleIsValid:(CGFloat)aScale
{
	return (aScale > 0);
}

#define DEFAULT_SCALE 40

- (CGFloat)scale
{
	return [GraphView scaleIsValid:scale] ? scale : DEFAULT_SCALE;
}

- (void)setScale:(CGFloat)newScale
{
	if ([GraphView scaleIsValid:newScale]) {
		if (newScale != scale) {
			scale = newScale;
			[self setNeedsDisplay];
		}
	}	
}

-(CGPoint)origin
{
	return CGPointMake(self.originOffset.x + (self.bounds.origin.x + self.bounds.size.width/2), self.originOffset.y + (self.bounds.origin.y + self.bounds.size.height/2));
	//return CGPointMake((self.bounds.origin.x + self.bounds.size.width/2) + (self.originOffset.x * (self.bounds.origin.x + self.bounds.size.width/2)), 
	//				   (self.bounds.origin.y + self.bounds.size.height/2) + self.originOffset.y * (self.bounds.origin.y + self.bounds.size.height/2));
}


- (void)setOriginOffset:(CGPoint)offSet 
{
	
	//originOffset.x += (offSet.x/self.bounds.size.width);
//	originOffset.y += (offSet.y/self.bounds.size.height);
	originOffset = offSet;
	[self setNeedsDisplay];
}


- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
	if ((gesture.state == UIGestureRecognizerStateChanged) ||
		(gesture.state == UIGestureRecognizerStateEnded)) {
		self.scale *= gesture.scale;
		gesture.scale = 1;
	}
}

-(void)pan:(UIPanGestureRecognizer *)gesture
{
	if ((gesture.state == UIGestureRecognizerStateChanged) ||
		(gesture.state == UIGestureRecognizerStateEnded)) {
		CGPoint translation = [gesture translationInView:self];
		self.originOffset = CGPointMake(self.originOffset.x + translation.x, self.originOffset.y + translation.y);
		//self.originOffset = translation;
		[gesture setTranslation:CGPointZero inView:self];
	}
}

-(void)doubleTap:(UITapGestureRecognizer *)gesture
{
	if(gesture.state == UIGestureRecognizerStateRecognized)
	{
		self.originOffset = CGPointZero;
	}
}
  
  
- (void)drawRect:(CGRect)rect {
	[[UIColor blueColor] set] ;
    [AxesDrawer drawAxesInRect:self.bounds originAtPoint:self.origin scale:self.scale];
	
	float contentScale = (float)self.contentScaleFactor;
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextBeginPath(context);

	for (float i = self.bounds.origin.x; i <= self.bounds.size.width * contentScale; i++) {
		float graphX = (i - (self.origin.x * contentScale))/(self.scale * contentScale);		
		float graphY = [self.delegate yForXvalue:graphX forGraphView:self];
		float yVal = (self.origin.y * contentScale) - (graphY * contentScale * self.scale);
		
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
