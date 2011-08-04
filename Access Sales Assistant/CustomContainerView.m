//
//  CustomContainerView.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomContainerView.h"

@implementation CustomContainerView

@synthesize mainView;
@synthesize flipView;
@synthesize flipped;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        mainView = [[FlashCardTitleView alloc] initWithFrame:frame];
        flipView = [[FlashCardFlipView alloc] initWithFrame:frame];

        // Initialization code
        [self addSubview:mainView];
    }
    return self;
}
-(id) initWithFrame:(CGRect)frame :(int)forFlashCard :(int)forIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        
        mainView = [[FlashCardTitleView alloc] initWithFrame:frame:forFlashCard:forIndex];
        flipView = [[FlashCardFlipView alloc] initWithFrame:frame:forFlashCard:forIndex];
        
        // Initialization code
        [self addSubview:mainView];
    }
    return self;
}

-(void) flipCurrentView:(BOOL)isFlipped
{
    flipped = !flipped;
    if(flipped)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
        
      //  [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:YES];
        
        [mainView removeFromSuperview];
        [self addSubview:flipView];
        
        [UIView commitAnimations];

    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
      //  [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:YES];
        
        [flipView removeFromSuperview];
        [self addSubview:mainView];
        
        [UIView commitAnimations];

        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
