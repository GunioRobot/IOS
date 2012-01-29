//
//  HappinessViewController.h
//  Happiness
//
//  Created by CS193p Instructor on 10/5/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"

@interface HappinessViewController : UIViewController <FaceViewDelegate>
{
	int happiness; // 0 to 100
	UISlider *slider;
	FaceView *faceView;
}

@property int happiness;

@property (retain) IBOutlet UISlider *slider;
@property (retain) IBOutlet FaceView *faceView;

- (IBAction)happinessChanged:(UISlider *)sender;

@end

