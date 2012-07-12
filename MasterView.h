//
//  MasterView.h
//  Jul12
//
//  Created by Michael Compas on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SubView;

@interface MasterView : UIView
{
	UIPageControl *pageControl;
	int viewIndex;
	NSArray *views;
	SubView *subViewContainer;
}

@end
