//
//  StateSelectionTableViewController.h
//  AccessSalesAssistantNewFeatures
//
//  Created by Easwara Reddy Illuri on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol stateChangedDelegate <NSObject>

-(void) selectedState:(NSString*) stateName;

@end

@interface StateSelectionTableViewController : UITableViewController
{
    NSMutableArray* array;
    NSDictionary* dictionary;
    
}

@property (nonatomic,assign) id<stateChangedDelegate> delegate;
@end
