
/*
     File: SectionHeaderView.m
 Abstract: A view to display a section header, and support opening and closing a section.
 
  Version: 1.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "SectionHeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import "Common.h"

@implementation SectionHeaderView
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@synthesize titleLabel=_titleLabel;
@synthesize disclosureButton, delegate, section;

@synthesize lightColor = _lightColor;
@synthesize darkColor = _darkColor;
@synthesize backgroundImage;

+ (Class)layerClass {
    
    return [CAGradientLayer class];
}


-(id)initWithFrame:(CGRect)frame title:(NSString*)title section:(NSInteger)sectionNumber displayDisclosure:(BOOL)isDisclosure delegate:(id <SectionHeaderViewDelegate>)aDelegate {
    
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        
        // Set up the tap gesture recognizer.
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
        [self addGestureRecognizer:tapGesture];
    //    [tapGesture release];

        delegate = aDelegate;        
        self.userInteractionEnabled = YES;
        
        
        // Create and configure the title label.
        section = sectionNumber;
        
     
       backgroundImage = [[UIImageView alloc] initWithFrame:frame];
        UIImage* image = [UIImage imageNamed:@"MenuButton.png"];
        
        backgroundImage.image =image;
        [self addSubview:backgroundImage];
               
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
             
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, self.frame.origin.y+5, self.frame.size.width-35, self.frame.size.height)];
      //  _titleLabel.
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.text = title;
        _titleLabel.opaque = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
       // _titleLabel.frame = CGRectMake(35, self.frame.origin.y, self.frame.size.width-35, self.frame.size.height);
        [self addSubview:_titleLabel];
        
        self.lightColor = [UIColor colorWithRed:105.0f/255.0f green:179.0f/255.0f blue:216.0f/255.0f alpha:1.0];
        //self.darkColor = [UIColor colorWithRed:21.0/255.0 green:92.0/255.0 blue:136.0/255.0 alpha:1.0];  
        
       // self.lightColor = 
        self.darkColor =RGB(0,111,162);
        
        // Create and configure the disclosure button.
        disclosureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        disclosureButton.frame = CGRectMake(0.0, 15.0, 35.0, 35.0);

        if(isDisclosure)
        {
        [disclosureButton setImage:[UIImage imageNamed:@"CircleArrowRight_sml.png"] forState:UIControlStateNormal];
        [disclosureButton setImage:[UIImage imageNamed:@"CircleArrowDown_sml.png"] forState:UIControlStateSelected];
            disclosureButton.alpha = 0.25;
            
          

        }
               
        [disclosureButton addTarget:self action:@selector(toggleOpen:) forControlEvents:UIControlEventTouchUpInside];
      //  [self addSubview:disclosureButton];
         //self.backgroundColor = RGB(0,111,162);
        
    }
    
    return self;
}


-(IBAction)toggleOpen:(id)sender {
    
    [self toggleOpenWithUserAction:YES];
}


-(void)toggleOpenWithUserAction:(BOOL)userAction {
    
    // Toggle the disclosure button state.
    disclosureButton.selected = !disclosureButton.selected;
    
    // If this was a user action, send the delegate the appropriate message.
    if (userAction) {
        if (disclosureButton.selected) {
            if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
                
               
                [delegate sectionHeaderView:self sectionOpened:section];
                
      /*          self.lightColor = RGB(154,255,154);
                
                self.darkColor = RGB(73,103,22);
                [self setNeedsDisplay];
       */
                //self.backgroundColor = RGB(73,103,22);
                
                //_titleLabel.textColor = RGB(255,255,255);
                
                UIImage* image = [UIImage imageNamed:@"MenuButton_green.png"];
                
                backgroundImage.image =image;
                
            }
        }
        else {
            if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
                [delegate sectionHeaderView:self sectionClosed:section];
                //self.backgroundColor = RGB(0,111,162);
                //_titleLabel.textColor = RGB(230,230,230);
   
                /*self.lightColor =RGB(105,179,216);//[UIColor colorWithRed:105.0f/255.0f green:179.0f/255.0f blue:216.0f/255.0f alpha:1.0];;
                self.darkColor = RGB(0,111,162);
                                [self setNeedsDisplay];
                 */
                
                UIImage* image = [UIImage imageNamed:@"MenuButton.png"];
                
                backgroundImage.image =image;

            }
        }
       
    }
    else
    {
      /*  self.lightColor =RGB(105,179,216);
        self.darkColor =  RGB(0,111,162);
        [self setNeedsDisplay];
       */
        
        UIImage* image = [UIImage imageNamed:@"MenuButton.png"];
        
        backgroundImage.image =image;
         //self.backgroundColor = RGB(0,111,162);
       // _titleLabel.textColor = RGB(230,230,230);
    }
}


-(void) layoutSubviews {
       
    CGFloat coloredBoxMargin = 6.0;
    CGFloat coloredBoxHeight = 40.0;
    _coloredBoxRect = CGRectMake(coloredBoxMargin, 
                                 coloredBoxMargin, 
                                 self.bounds.size.width-coloredBoxMargin*2, 
                                 coloredBoxHeight);
    
    CGFloat paperMargin = 9.0;
    _paperRect = CGRectMake(paperMargin, 
                            CGRectGetMaxY(_coloredBoxRect), 
                            self.bounds.size.width-paperMargin*2, 
                            self.bounds.size.height-CGRectGetMaxY(_coloredBoxRect));
    
    _titleLabel.frame = _coloredBoxRect;
        
}
/*
- (void)drawRect:(CGRect)rect {
          
    CGContextRef context = UIGraphicsGetCurrentContext();    

    CGColorRef whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    CGColorRef lightColor = _lightColor.CGColor;
    CGColorRef darkColor = _darkColor.CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5].CGColor;   
        
    // Draw paper
    CGContextSetFillColorWithColor(context, whiteColor);
    CGContextFillRect(context, _paperRect);

    // Draw shadow
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor);
    CGContextSetFillColorWithColor(context, lightColor);
    CGContextFillRect(context, _coloredBoxRect);
    CGContextRestoreGState(context);
    
    // Draw gloss and gradient
    drawGlossAndGradient(context, _coloredBoxRect, lightColor, darkColor);  

    // Draw stroke
    CGContextSetStrokeColorWithColor(context, darkColor);
    CGContextSetLineWidth(context, 1.0);    
    CGContextStrokeRect(context, rectFor1PxStroke(_coloredBoxRect));    
    
}*/

@end
