//
//  PlacesAppDelegate.h
//  Places
//
//  Created by Michael McGlynn on 2/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlacesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tbc;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (retain) UITabBarController *tbc;
@end

