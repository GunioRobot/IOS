//
//  PhotoScrollViewController.h
//  Places
//
//  Created by Michael McGlynn on 8/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoScrollViewController : UIViewController <UIScrollViewDelegate>{
	NSDictionary *photoInfo;
	UIImageView *photoView;
}
@property (retain) NSDictionary *photoInfo;
@property (retain) UIImageView *photoView;
@end
