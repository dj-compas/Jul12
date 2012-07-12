//
//  Jul12AppDelegate.h
//  Jul12
//
//  Created by Michael Compas on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class MasterView;

@interface Jul12AppDelegate : UIResponder <UIApplicationDelegate>
{
	//View *view;
	MasterView *masterView;
	MPMoviePlayerController *movieController;
	UIPickerView *picker;
	NSArray *movieArray;
}

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL awesomeness;

@end
