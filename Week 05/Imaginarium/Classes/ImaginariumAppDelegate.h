//
//  ImaginariumAppDelegate.h
//  Imaginarium
//
//  Created by CS193p Instructor on 10/19/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImaginariumAppDelegate : NSObject <UIApplicationDelegate, UIScrollViewDelegate>
{
    UIWindow *window;
	UIImageView *imageView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
