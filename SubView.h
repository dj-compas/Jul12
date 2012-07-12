//
//  SubView.h
//  Jul12
//
//  Created by Michael Compas on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface SubView : UIView <UIPickerViewDelegate, UIPickerViewDataSource, AVAudioPlayerDelegate>
{
	UILabel *labelAwesomeness;
	UISwitch *awesomeSwitch;
	UIButton *movieButton;
	UIPickerView *picker;
	NSArray *pickerData;
	NSString *musicPreference;
	UISegmentedControl *segmentedControl;
	AVAudioPlayer *musicPlayer;
	NSArray *musicArray;
	UISlider *volumeSlider;
}

-(void)setControlInterface1;
-(void)setMoviePlayer;
-(void)setControlInterface2;

@end
