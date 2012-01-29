//
//  ImaginariumAppDelegate.m
//  Imaginarium
//
//  Created by CS193p Instructor on 10/19/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "ImaginariumAppDelegate.h"

@implementation ImaginariumAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIImage *image = [UIImage imageNamed:@"ipod.jpg"];
	imageView = [[UIImageView alloc] initWithImage:image];

	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:applicationFrame];
	scrollView.contentSize = image.size;
	[scrollView addSubview:imageView];

	scrollView.bounces = NO;

	scrollView.minimumZoomScale = 0.3;
	scrollView.maximumZoomScale = 3.0;
	scrollView.delegate = self;

	[window addSubview:scrollView];
    [window makeKeyAndVisible];

    return YES;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return imageView;
}

- (void)dealloc
{
	[imageView release];
    [window release];
    [super dealloc];
}

@end
