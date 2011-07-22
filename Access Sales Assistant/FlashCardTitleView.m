//
//  FlashCardTitleView.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlashCardTitleView.h"

@implementation FlashCardTitleView

#define FLASH_PROSPECT_TITLES @"OVERVIEW & OBJECTIVE",@"ACCESS SALES PITCH",@"VISIT QUESTIONS",@"CLOSE",nil
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
        
        
        
        self.rectColor = RGB(238,224,229);
        
        
         prospectFlashTitleArray = [[NSArray alloc] initWithObjects:FLASH_PROSPECT_TITLES];
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text = [prospectFlashTitleArray objectAtIndex:forIndex];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:15];
        
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
