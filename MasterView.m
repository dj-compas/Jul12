//
//  MasterView.m
//  Jul12
//
//  Created by Michael Compas on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterView.h"
#import "SubView.h"

@implementation MasterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor grayColor];
		
		// add page control to the bottom of master view
		int numberOfPages = 3;
		CGFloat w = (numberOfPages*20)*2;
		CGFloat h = 20;
		CGFloat x = frame.size.width/2 - w/2;
		CGFloat y = frame.size.height - 20 - 20;
		
		CGRect pageControlFrame = CGRectMake(x, y, w, h);
		pageControl = [[UIPageControl alloc] initWithFrame:pageControlFrame];
		pageControl.numberOfPages = numberOfPages;
		[pageControl addTarget:self action:@selector(pageControlHandler) forControlEvents:UIControlEventValueChanged];
		
		// create subviews
		subViewContainer = [[SubView alloc] initWithFrame:self.frame];
		
		SubView *sub1 = [[SubView alloc] initWithFrame:self.frame];
		sub1.backgroundColor = [UIColor redColor];
		[sub1 setControlInterface1];
		
		SubView *sub2 = [[SubView alloc] initWithFrame:self.frame];
		sub2.backgroundColor = [UIColor colorWithRed:0 green:.5 blue:0 alpha:1];
		[sub2 setMoviePlayer];
		
		SubView *sub3 = [[SubView alloc] initWithFrame:self.frame];
		sub3.backgroundColor = [UIColor blueColor];
		[sub3 setControlInterface2];
		
		views = [NSArray arrayWithObjects:sub1, sub2, sub3, nil];
		
		[self addSubview:subViewContainer];
		[subViewContainer addSubview:[views objectAtIndex:viewIndex]];
		[self addSubview:pageControl];
		
		NSLog(@"%@", NSStringFromCGRect(pageControlFrame));
    }
    return self;
}

-(void)pageControlHandler
{
	int currentPage = pageControl.currentPage;
	//NSLog(@"currentPage:%i", currentPage);
	SubView *old = [views objectAtIndex:viewIndex];
	SubView *new = [views objectAtIndex:currentPage];
	
	// if music is playing in subview3, stop it
	if (viewIndex == [views	count]-1)
	{
		[old performSelector:@selector(killMusic)];
	}
	
	[SubView transitionFromView:old
						toView:new
					  duration:.5
						options:(currentPage > viewIndex ? UIViewAnimationOptionTransitionCurlUp : UIViewAnimationOptionTransitionCurlDown)
					completion:^(BOOL finished){
						if(finished)
						{
							viewIndex = currentPage;
						}
					}
	 ];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
