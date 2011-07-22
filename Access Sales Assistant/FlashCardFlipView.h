//
//  FlashCardFlipView.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedRectView.h"
@interface FlashCardFlipView : RoundedRectView
{
    NSArray *callTitleArray;
    NSArray *flashTitleArray;
}

- (id)initWithFrame:(CGRect)frame:(int) forFlashCard:(int) forIndex;

@end
