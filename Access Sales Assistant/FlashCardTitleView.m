//
//  FlashCardTitleView.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlashCardTitleView.h"

@implementation FlashCardTitleView

//#define FLASH_PROSPECT_TITLES @"OVERVIEW & OBJECTIVE",@"ACCESS SALES PITCH",@"VISIT QUESTIONS",@"CLOSE",nil

#define FLASH_PROSPECT_TITLES @"Objective",@"Overview",@"Access Sales Pitch",@"Visit Questions",@"Close",nil
#define RGB(r, g, b)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
       // self.backgroundColor = [UIColor yellowColor];
        // Initialization code
    }
    return self;
}


-(id) initWithFrame:(CGRect)frame :(int)forFlashCard :(int)forIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        
      //  self.backgroundColor = RGB(238,224,229);
        
        
        
     //   self.rectColor = [UIColor clearColor];//RGB(238,224,229);
        
        
         prospectFlashTitleArray = [[NSArray alloc] initWithObjects:FLASH_PROSPECT_TITLES];
        
        
        UIImageView* background = [[UIImageView alloc] initWithFrame:frame];
    //    UIImage* bgImage = [UIImage imageNamed:@"ipad background - cars (black).png"];
       //  UIImage* bgImage = [UIImage imageNamed:@"calls-background.png"];
        //background.image = bgImage;

        //[self addSubview:background];
        self.backgroundColor = [UIColor clearColor];

        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:frame];
        UIImage* image = [UIImage imageNamed:@"indexCard.png"];
        imageView.image = image;
      //  imageView.alpha = 0.9;
        [self addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text = [prospectFlashTitleArray objectAtIndex:forIndex];
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
//        label.font = [UIFont fontWithName:@"Trebuchet MS" size:25];//[label.font fontWithSize:15];
        // label.font = [UIFont fontWithName:@"SnellRoundhand-Bold" size:50];//[label.font fontWithSize:15];
         label.font = [UIFont fontWithName:@"BradleyHandITCTT-Bold" size:50];//[label.font fontWithSize:15];
        
        [self addSubview:label];

           }
    return self;
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
