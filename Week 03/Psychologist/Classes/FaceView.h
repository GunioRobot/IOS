//
//  FaceView.h
//  Happiness
//
//  Created by CS193p Instructor on 10/5/10.
//  Copyright 2010 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDelegate
- (float)smileForFaceView:(FaceView *)requestor;  // -1.0 (frown) to 1.0 (smile)
@end

@interface FaceView : UIView {
    id <FaceViewDelegate> delegate;
}

@property (assign) id <FaceViewDelegate> delegate;

@end
