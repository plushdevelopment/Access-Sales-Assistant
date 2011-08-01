//
//  FlashCardsViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseDetailViewController.h"
#import "iCarousel.h"
@interface FlashCardsViewController : BaseDetailViewController<iCarouselDataSource, iCarouselDelegate>
{
    BOOL isFlipped;
    
    
    NSMutableArray *containerArray;
}

@property(nonatomic,strong) IBOutlet UIView* firstview;
@property(nonatomic,strong) IBOutlet UIView* secondview;
@property(nonatomic,strong) IBOutlet UIView* thirdview;
@property(nonatomic,strong) IBOutlet UIView* fourthview;
@property(nonatomic,strong) IBOutlet UIView* fifthview;
@property(nonatomic,strong) IBOutlet UIView* flipview;
@property(nonatomic,strong) IBOutlet UILabel* titleLabel;
@property(nonatomic,strong) IBOutlet UIView* containerview;
@property(nonatomic,strong) IBOutlet UIToolbar *toolBar;

@property(nonatomic) NSInteger selectedFlashCard;
@property(nonatomic,strong) IBOutlet iCarousel* carousel;
-(void) loadFlashCards:(int) index;


@end
