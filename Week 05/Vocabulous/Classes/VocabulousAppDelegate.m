//
//  VocabulousAppDelegate.m
//  Vocabulous
//
//  Created by CS193p Instructor on 10/21/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import "VocabulousAppDelegate.h"
#import "WordListTableViewController.h"

@implementation VocabulousAppDelegate

@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    WordListTableViewController *wltvc = [[WordListTableViewController alloc] init];
	UINavigationController *nav = [[UINavigationController alloc] init];
	[nav pushViewController:wltvc animated:NO];
	[wltvc release];
	[window addSubview:nav.view];

    [window makeKeyAndVisible];
    return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
    [window release];
    [super dealloc];
}


@end
