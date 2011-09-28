
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
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
        [self addGestureRecognizer:tapGesture];
        
        delegate = aDelegate;        
        self.userInteractionEnabled = YES;
        
        section = sectionNumber;
        
        
        backgroundImage = [[UIImageView alloc] initWithFrame:frame];
        UIImage* image = [UIImage imageNamed:@"MenuButton.png"];
        
        backgroundImage.image =image;
        [self addSubview:backgroundImage];
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, self.frame.origin.y+5, self.frame.size.width-35, self.frame.size.height)];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.text = title;
        _titleLabel.opaque = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:_titleLabel];
        
        self.lightColor = [UIColor colorWithRed:105.0f/255.0f green:179.0f/255.0f blue:216.0f/255.0f alpha:1.0];
        
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
                
                UIImage* image = [UIImage imageNamed:@"MenuButton_green.png"];
                
                backgroundImage.image =image;
                
            }
        }
        else {
            if ([delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
                [delegate sectionHeaderView:self sectionClosed:section];                
                UIImage* image = [UIImage imageNamed:@"MenuButton.png"];
                
                backgroundImage.image =image;
                
            }
        }
        
    }
    else
    {
        
        UIImage* image = [UIImage imageNamed:@"MenuButton.png"];
        
        backgroundImage.image =image;
    }
}


-(void) layoutSubviews {
    
    CGFloat coloredBoxMargin = 0;
    CGFloat coloredBoxHeight = 44.0;
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
@end
