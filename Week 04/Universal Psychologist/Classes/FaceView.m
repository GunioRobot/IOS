//
//  FaceView.m
//  Happiness
//
//  Created by CS193p Instructor on 10/5/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView

@synthesize delegate;

- (void)setup
{
	self.contentMode = UIViewContentModeRedraw;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
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
	return ((aScale > 0) && (aScale <= 1));
}

#define DEFAULT_SCALE 0.90

- (CGFloat)scale
{
	return [FaceView scaleIsValid:scale] ? scale : DEFAULT_SCALE;
}

- (void)setScale:(CGFloat)newScale
{
	if ([FaceView scaleIsValid:newScale]) {
		if (newScale != scale) {
			scale = newScale;
			[self setNeedsDisplay];
		}
	}
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
	if ((gesture.state == UIGestureRecognizerStateChanged) ||
		(gesture.state == UIGestureRecognizerStateEnded)) {
		self.scale *= gesture.scale;
		gesture.scale = 1;
	}
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
	UIGraphicsPushContext(context);
	CGContextBeginPath(context);
	CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
	CGContextStrokePath(context);
	UIGraphicsPopContext();
}

- (void)drawRect:(CGRect)rect
{
	CGPoint midPoint;
	midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
	midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;

	CGFloat size = self.bounds.size.width / 2;
	if (self.bounds.size.height < self.bounds.size.width) size = self.bounds.size.height / 2;
	size *= self.scale;

	CGContextRef context = UIGraphicsGetCurrentContext();

	CGContextSetLineWidth(context, 5.0);
	[[UIColor blueColor] setStroke];

	[self drawCircleAtPoint:midPoint withRadius:size inContext:context];

#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.10

	CGPoint eyePoint;
	eyePoint.x = midPoint.x - size * EYE_H;
	eyePoint.y = midPoint.y - size * EYE_V;
	[self drawCircleAtPoint:eyePoint withRadius:size * EYE_RADIUS inContext:context];
	eyePoint.x += size * EYE_H * 2;
	[self drawCircleAtPoint:eyePoint withRadius:size * EYE_RADIUS inContext:context];

#define MOUTH_H 0.45
#define MOUTH_V 0.4
#define MOUTH_SMILE 0.25

	CGPoint mouthStart;
	mouthStart.x = midPoint.x - MOUTH_H * size;
	mouthStart.y = midPoint.y + MOUTH_V * size;
	CGPoint mouthEnd = mouthStart;
	mouthEnd.x += MOUTH_H * size * 2;
	CGPoint mouthCP1 = mouthStart;
	mouthCP1.x += MOUTH_H * size * 2/3;
	CGPoint mouthCP2 = mouthEnd;
	mouthCP2.x -= MOUTH_H * size * 2/3;

	// use delegate here to get smile

	float smile = [self.delegate smileForFaceView:self];
	if (smile < -1.0) smile = -1.0;
	if (smile > 1.0) smile = 1.0;
	CGFloat smileOffset = MOUTH_SMILE * size * smile;
	mouthCP1.y += smileOffset;
	mouthCP2.y += smileOffset;

	CGContextBeginPath(context);
	CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
	CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
	CGContextStrokePath(context);
}

- (void)dealloc {
    [super dealloc];
}


@end
