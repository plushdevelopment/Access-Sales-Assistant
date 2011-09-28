//
//  CustomContainerView.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FlashCardTitleView.h"
#import "FlashCardFlipView.h"
@interface CustomContainerView : UIView
{
    BOOL flipped;
}

@property(nonatomic,strong) FlashCardTitleView* mainView;
@property(nonatomic,strong) FlashCardFlipView* flipView;
@property(nonatomic) BOOL flipped;
-(void) flipCurrentView:(BOOL)isFlipped;
- (id)initWithFrame:(CGRect)frame forFlashcardType:(int) forFlashCard forFlashcardIndex:(int) forIndex;



@end
