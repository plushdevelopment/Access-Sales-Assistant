//
//  FlashCardsViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlashCardsViewController.h"
#import "CustomContainerView.h"
#import "FlashCardFlipView.h"
#import "FlashCardTitleView.h"
#import "iCarousel.h"

@implementation FlashCardsViewController
@synthesize firstview;
@synthesize secondview;
@synthesize thirdview;
@synthesize fourthview;
@synthesize fifthview;
@synthesize flipview;
@synthesize containerview;
@synthesize carousel;
@synthesize toolBar;
@synthesize selectedFlashCard;
@synthesize titleLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.baseToolbar = self.toolBar;
    containerArray = [[NSMutableArray alloc] init];
    [carousel setType:iCarouselTypeCoverFlow];
    [self loadFlashCards:selectedFlashCard];
    if([containerArray count])
        [carousel reloadData];
  
    isFlipped = FALSE;
    [flipview removeFromSuperview];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
  //  carousel.frame = self.view.frame;
    [self loadFlashCards:selectedFlashCard];
    [carousel reloadData];
    carousel.clipsToBounds = YES;
}

-(void) loadFlashCards:(int) index
{
    
    
    if(index == 0)
    {
        titleLabel.text = @"Prospect";
    }
    else if(index == 1)
    {
        titleLabel.text = @"Zero Producer";
    }
    else if(index == 2)
    {
        titleLabel.text = @"Producer";
    }
    
      [containerArray removeAllObjects];
    
  
    
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"Flashcards" ofType:@"plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSDictionary* callDictionary = [plistData objectForKey:titleLabel.text];
    
    NSArray* indexTitleArray = [callDictionary objectForKey:@"Questions"];
   
    
    
    
    for(int i=0;i<[indexTitleArray count];i++)
    {
        CGSize containerSize;
        
        UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
        
        UIInterfaceOrientation or = self.interfaceOrientation;
        
        if(orientation == 0)
            orientation = or;
        
        if(UIDeviceOrientationIsPortrait(orientation))
            containerSize = CGSizeMake(350, 500);
        else
            containerSize = CGSizeMake(500, 350);
            
          
        
        CustomContainerView* containerView = [[CustomContainerView alloc] initWithFrame:CGRectMake(0,0,containerSize.width,containerSize.height):selectedFlashCard:i];
        
        [containerArray addObject:containerView];
        
    }

}


#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    int contCount = [containerArray count];
    return contCount;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    UIView * container = [containerArray objectAtIndex:index];
    return container;
   // return nil;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	//note: placeholder views are only displayed if wrapping is disabled
	return 0;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index
{
	//create a placeholder view
    UIImageView* imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page.png"]];
    UIView *view = [[UIView alloc]initWithFrame:imageView.bounds];
	UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
	label.text = (index == 0)? @"[": @"]";
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	label.font = [label.font fontWithSize:50];
    [view addSubview:imageView];
	[view addSubview:label];
	return view;
}

- (float)carouselItemWidth:(iCarousel *)carousel
{
    //slightly wider than item view
      
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    UIInterfaceOrientation or = self.interfaceOrientation;
    
    if(orientation==0)
        orientation = or;
   
        if(UIDeviceOrientationIsPortrait(orientation))
            return 400;
        else
            return 550;
  }

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(float)offset
{
    //implement 'flip3D' style carousel
    
    //set opacity based on distance from camera
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    //do 3d transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    //wrap all carousels
    return NO;
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel
{
	NSLog(@"Carousel will begin dragging");
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate
{
	NSLog(@"Carousel did end dragging and %@ decelerate", decelerate? @"will": @"won't");
}

- (void)carouselWillBeginDecelerating:(iCarousel *)carousel
{
	NSLog(@"Carousel will begin decelerating");
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel
{
	NSLog(@"Carousel did end decelerating");
}

- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel
{
	NSLog(@"Carousel will begin scrolling");
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
	NSLog(@"Carousel did end scrolling");
}

- (void)carousel:(iCarousel *)_carousel didSelectItemAtIndex:(NSInteger)index
{
	if (index == carousel.currentItemIndex)
	{
		//note, this will only ever happen if USE_BUTTONS == NO
		//otherwise the button intercepts the tap event
		NSLog(@"Selected current item");
      //  CustomContainerView* view = (CustomContainerView*)[_carousel viewAtIndex:index];
        
        for(int cContainer = 0; cContainer<[containerArray count];cContainer++)
        {
            CustomContainerView* view = [containerArray objectAtIndex:cContainer];
            if(index == cContainer)
            {
                [view flipCurrentView:YES];
            }
            else
            {
                if(view.flipped)
                    [view flipCurrentView:YES];
                
            }
        }
        
	}
	else
	{
		NSLog(@"Selected item number %i", index);
	}
}

#pragma mark -
#pragma mark Button tap event




@end
