//
//  Jul12AppDelegate.m
//  Jul12
//
//  Created by Michael Compas on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Jul12AppDelegate.h"
#import "MasterView.h"
#import "SubView.h"

@implementation Jul12AppDelegate

@synthesize window = _window;
@synthesize awesomeness;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIScreen *screen = [UIScreen mainScreen];
	CGRect applicationFrame = screen.applicationFrame;
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	
	masterView = [[MasterView alloc] initWithFrame:applicationFrame];
	
	// for movie player
	movieArray = [NSArray arrayWithObjects: @"Robert Palmer short", @"NI - Traktor Pro 2 teaser short", nil];
	NSLog(@"awesomeness? %@", awesomeness);
	NSURL *url = [self getURLForIndex:0];
	
	movieController = [[MPMoviePlayerController alloc] initWithContentURL:url];
	movieController.shouldAutoplay = NO;
	movieController.allowsAirPlay = YES;
	//[movieController prepareToPlay];
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self
			   selector:@selector(movieFinished)
				   name:MPMoviePlayerPlaybackDidFinishNotification
				 object:movieController
	 ];
	
	// create picker
	picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
	
	// add sub views
	[self.window addSubview:masterView];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)awesomeSwitchHandler:(UISwitch *) switchControl
{
	if (switchControl.isOn) {
		[switchControl.superview performSelector:@selector(changeLabelColorTo:) withObject:[UIColor whiteColor]];
		movieController.contentURL = [self getURLForIndex:1];
	}
	else {
		[switchControl.superview performSelector:@selector(changeLabelColorTo:) withObject:[UIColor blackColor]];
		movieController.contentURL = [self getURLForIndex:0];
	}
	
	NSLog(@"movie url: %@", movieController.contentURL);
}

-(NSURL *)getURLForIndex:(NSUInteger)index
{
	return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[movieArray objectAtIndex:index] ofType:@"m4v"]];
}

-(void)movieButtonPressed
{
	
	movieController.view.frame = self.window.frame;
	movieController.controlStyle =  MPMovieControlStyleFullscreen;
	[self.window addSubview:movieController.view];
	[movieController play];
}

-(void)movieFinished
{
	[movieController.view removeFromSuperview];
	[UIApplication sharedApplication].statusBarHidden = YES;
}


// ===============================================================
// ===============================================================

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
