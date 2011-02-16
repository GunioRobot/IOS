//
//  HappinessAppDelegate.h
//  Happiness
//
//  Created by CS193p Instructor on 10/5/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HappinessViewController;

@interface HappinessAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HappinessViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HappinessViewController *viewController;

@end

