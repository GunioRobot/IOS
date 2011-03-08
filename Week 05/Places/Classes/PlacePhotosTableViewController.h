//
//  PlacePhotosTableViewController.h
//  Places
//
//  Created by Michael McGlynn on 8/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlacePhotosTableViewController : UITableViewController {
	NSString *place_id;
	NSArray *photos;
}

@property (retain) NSString *place_id;
@end
