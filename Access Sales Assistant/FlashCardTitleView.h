//
//  FlashCardTitleView.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RoundedRectView.h"
@interface FlashCardTitleView : RoundedRectView

{
    UILabel* flashCardTitle;
    NSArray *prospectFlashTitleArray;
    NSArray *producerFlashTitleArray;
    NSArray *zeroproducerFlashTitleArray;
    
}
- (id)initWithFrame:(CGRect)frame:(int) forFlashCard:(int) forIndex;

@end
