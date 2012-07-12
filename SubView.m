//
//  SubView.m
//  Jul12
//
//  Created by Michael Compas on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubView.h"

@implementation SubView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		// set defaults
		musicPreference = @"House";
    }
    return self;
}

-(void)setControlInterface1
{
	NSLog(@"this view is control interface 1");
	
	// =================================================================
	// create awesome uilabel
	CGRect labelAwesomenessFrame = CGRectZero;
	labelAwesomeness = [[UILabel alloc] initWithFrame:labelAwesomenessFrame];
	labelAwesomeness.text = @"Awesomeness:";
	labelAwesomeness.backgroundColor = [UIColor clearColor];
	//labelAwesomeness.textColor = [UIColor whiteColor];
	[labelAwesomeness sizeToFit];
	[labelAwesomeness setFrame:CGRectMake(self.frame.size.width/2 - labelAwesomeness.frame.size.width, 20, labelAwesomeness.frame.size.width, labelAwesomeness.frame.size.height)];
	
	[self addSubview:labelAwesomeness];
	
	
	// =================================================================
	// create uiswitch
	awesomeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
	CGRect switchFrame = CGRectMake(labelAwesomeness.frame.origin.x + labelAwesomeness.frame.size.width + 10, ABS((labelAwesomeness.frame.origin.y + labelAwesomeness.frame.size.height/2) - awesomeSwitch.frame.size.height/2), 0, 0);
	[awesomeSwitch setFrame:switchFrame];
	
	[awesomeSwitch addTarget:[UIApplication sharedApplication].delegate
					  action:@selector(awesomeSwitchHandler:)
			forControlEvents:UIControlEventValueChanged
	 ];
	
	[self addSubview:awesomeSwitch];
	
	
	// =================================================================
	// create sub text
	UILabel *subText = [[UILabel alloc] initWithFrame:CGRectZero];
	subText.lineBreakMode = UILineBreakModeWordWrap;
	subText.numberOfLines = 0; // allows unlimited number of lines; line break won't work without this
	subText.text = @"Awesomeness is bound to happen\nregardless of your choice.\n\n** Your choice affects the video on the next page **";
	subText.textAlignment = UITextAlignmentCenter;
	subText.font = [UIFont systemFontOfSize:72*.18];
	subText.textColor = [UIColor whiteColor];
	subText.backgroundColor = [UIColor clearColor];
	[subText sizeToFit];
	CGRect labelSubtextFrame = CGRectMake(floorf(self.frame.size.width/2 - subText.frame.size.width/2), floorf(awesomeSwitch.frame.origin.y + awesomeSwitch.frame.size.height + 10), subText.frame.size.width, subText.frame.size.height);
	[subText setFrame:labelSubtextFrame];
	
	[self addSubview:subText];
}

-(void)setMoviePlayer
{
	NSLog(@"this view is the movie player");
	
	CGFloat w = 200;
	CGFloat h = 30;
	CGFloat x = self.frame.size.width/2 - w/2;
	CGFloat y = self.frame.size.height/2 - h/2;
	CGRect movieButtonFrame = CGRectMake(x, y, w, h);
	movieButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	movieButton.frame = movieButtonFrame;
	[movieButton setTitle:@"Play Movie" forState:UIControlStateNormal];
	
	[movieButton addTarget:[UIApplication sharedApplication].delegate
					action:@selector(movieButtonPressed)
		  forControlEvents:UIControlEventTouchUpInside
	 ];
	
	[self addSubview:movieButton];
}

-(void)setControlInterface2
{
	// create picker
	pickerData = [NSArray arrayWithObjects:@"House", @"Drum and Bass", nil];
	
	picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
	picker.showsSelectionIndicator = YES;
	
	// this line is MANDATORY in order for the data to show up in the UIPickerView
	picker.delegate = self;
	
	// =================================================================
	// create segment control, including audio player instance
	NSArray *segmentArray = [NSArray arrayWithObjects:@"Stop", @"Play", nil];
	segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentArray];
	
	CGFloat w = segmentedControl.frame.size.width;
	CGFloat h = segmentedControl.frame.size.height;
	CGFloat x = floorf(self.frame.size.width/2 - segmentedControl.frame.size.width/2);
	CGFloat y = floorf(picker.frame.size.height + 20);
	
	CGRect segmentFrame = CGRectMake(x, y, w, h);
	[segmentedControl setFrame:segmentFrame];
	
	// disable stop button since no audio is playing at start
	[segmentedControl setEnabled:NO forSegmentAtIndex:0];
	
	[segmentedControl addTarget:self action:@selector(segmentedControlHandler) forControlEvents:UIControlEventValueChanged];
	
	// for audio player
	musicArray = [NSArray arrayWithObjects:@"Demarkus Lewis - Hustler", @"Random Movement - She Dont Get It (sample)", nil];
	NSURL *url = [self getURLForIndex:[picker selectedRowInComponent:0]];
	musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
	[musicPlayer prepareToPlay];
	
	// =================================================================
	// create volume slider
	
	CGFloat sw = 200;
	CGFloat sh = 0;
	CGFloat sx = floorf(self.frame.size.width/2 - sw/2);
	CGFloat sy = floorf(segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 20);
	
	volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(sx, sy, sw, sh)];
	volumeSlider.minimumValue = 0;
	volumeSlider.maximumValue = 1;
	
	volumeSlider.value = musicPlayer.volume;
	[volumeSlider addTarget:self action:@selector(changeVolume) forControlEvents:UIControlEventValueChanged];
	
	[self addSubview:volumeSlider];
	[self addSubview:segmentedControl];
	[self addSubview:picker];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)changeLabelColorTo:(UIColor *) col
{
	labelAwesomeness.textColor = col;
}

-(void)segmentedControlHandler
{
	if (segmentedControl.selectedSegmentIndex == 1) {
		[musicPlayer play];
		
		// enable stop button since audio is playing
		[segmentedControl setEnabled:YES forSegmentAtIndex:0];
	}
	else if (segmentedControl.selectedSegmentIndex == 0) {
		[musicPlayer stop];
		musicPlayer.currentTime = 0; // rewind audio
		[segmentedControl setEnabled:NO forSegmentAtIndex:0];
	}
}

-(void)changeVolume
{
	musicPlayer.volume = volumeSlider.value;
}

-(NSURL *)getURLForIndex:(NSUInteger)index
{
	return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[musicArray objectAtIndex:index] ofType:@"mp3"]];
}

-(void)resetSegmentedControl
{
	segmentedControl.selectedSegmentIndex = -1;
	[segmentedControl setEnabled:NO forSegmentAtIndex:0];
}

// ===============================================================
// ===============================================================
// mandatory methods needed for picker's delegate, which is self

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if(musicPlayer.currentTime > 0)
	{
		NSLog(@"music is playing, stop it...");
		[musicPlayer stop];
		[self resetSegmentedControl];
	}
	
	musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[self getURLForIndex:row] error:nil];
	[self changeVolume];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
	// sets 1 component in picker
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [pickerData count];
	// sets the number of rows in the picker
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [pickerData objectAtIndex:row];
}

// ===============================================================
// ===============================================================
// methods needed for AVAudioPlayer's delegate, which is self

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	
}

@end
