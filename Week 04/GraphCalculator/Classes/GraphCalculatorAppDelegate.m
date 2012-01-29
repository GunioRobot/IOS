//
//  GraphCalculatorAppDelegate.m
//  GraphCalculator
//
//  Created by Michael Work on 16/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphCalculatorAppDelegate.h"
#import "CalculatorViewController.h"
@implementation GraphCalculatorAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

-(BOOL)iPad
{
	return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	// Set up UINavigationView Controller as root view controller
	// & push  CalculatorViewController on as starting view (and release)

    UINavigationController *nvc = [[UINavigationController alloc] init];
	CalculatorViewController *cvc = [[CalculatorViewController alloc] init];
	cvc.title = @"Calculator";
	[nvc pushViewController:cvc animated:NO];

	if(self.iPad)
	{
		NSLog(@"iPad");
		UISplitViewController *svc = [[UISplitViewController alloc] init];
		UINavigationController *rightNav = [[UINavigationController alloc] init];
		[rightNav pushViewController:cvc.graphViewController animated:NO];
		svc.delegate = cvc.graphViewController;
		svc.viewControllers = [NSArray arrayWithObjects:nvc, rightNav, nil];
		[nvc release]; [rightNav release];
		[window addSubview:svc.view];
	}
	else
	{
		NSLog(@"iPhone");
		[window addSubview:nvc.view];
	}

	[cvc release];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)saveState
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults synchronize];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	[self saveState];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	[self saveState];
}



#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
