    //
//  PhotoScrollViewController.m
//  Places
//
//  Created by Michael McGlynn on 8/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoScrollViewController.h"
#import "FlickrFetcher.h"

@implementation PhotoScrollViewController
@synthesize photoInfo, photoView;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];

	UIImage *image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithFlickrInfo:photoInfo format:FlickrFetcherPhotoFormatLarge]];
	self.photoView = [[UIImageView alloc] initWithImage:image];

	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:applicationFrame];
	scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

	scrollView.contentSize = image.size;
	[scrollView addSubview:self.photoView];

	scrollView.bounces = NO;

	scrollView.minimumZoomScale = 0.3;
	scrollView.maximumZoomScale = 3.0;
	scrollView.delegate = self;

	[self.view addSubview:scrollView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.photoView;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[photoInfo release];
	[photoView release];
    [super dealloc];
}


@end
