//
//  StateSelectionTableViewController.h
//  AccessSalesAssistantNewFeatures
//
//  Created by Easwara Reddy Illuri on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol stateChangedDelegate <NSObject>

-(void) selectedState:(NSString*) stateName selectedStateCode:(NSString*) stateCode;

@end

@interface StateSelectionTableViewController : UITableViewController
{
    NSMutableArray* array;
    NSMutableArray* stateCodeArray;
    NSDictionary* dictionary;
    BOOL isColorChanged;
    int selectedIndexPath;
    
}

@property (nonatomic,assign) id<stateChangedDelegate> delegate;
@property (nonatomic,strong) NSString* currentSelectedState;
@end
