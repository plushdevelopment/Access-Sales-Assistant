//
//  ContactsQATimeTableViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactsQATimeTableViewController.h"

#import "QATimeTableObject.h"
@implementation ContactsQATimeTableViewController
@synthesize toolBar = _toolBar;
@synthesize stateChangeButton = _stateChangeButton;
@synthesize stateViewController = _stateViewController;
@synthesize scrollView = _scrollView;
@synthesize currentStateCode = _currentStateCode;
@synthesize currentStateName = _currentStateName ;

#define QA_TIMETABLE_KEYS @"24 Hours",@"48 Hours",@"72 Hours",@"3-5 Business Days",@"10 Days",nil

#define ROW_OFFSET_TIMETABLE 5
#define ROW_HEIGHT 80
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
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
    self.currentStateCode = @"GA";
    self.currentStateName = @"Georgia";
    self.baseToolbar = _toolBar;
    [self selectedState:@"Georgia" :@"GA"];
    
    currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setScrollView:nil];
    [self setToolBar:nil];
    [self setStateChangeButton:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //[self selectedState:self.currentStateName :self.currentStateCode];
    
   // [self.scrollView setNeedsDisplay];
    
    currentOrientation = toInterfaceOrientation;
    [self selectedState:self.currentStateCode :self.currentStateName];
}
-(IBAction)stateChanged:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    if(self.stateViewController == nil)
    {
        self.stateViewController = [[StateSelectionTableViewController alloc] initWithStyle:UITableViewStylePlain];
        
        popOverController  = [[UIPopoverController alloc] initWithContentViewController:self.stateViewController];
    }
    
    self.stateViewController.currentSelectedState = _currentStateName;
    
    [self.stateViewController setContentSizeForViewInPopover:CGSizeMake(300.0, 500.0)];
    
    [popOverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    self.stateViewController.delegate = self;

}

-(void) selectedState:(NSString*) stateName:(NSString *)stateCode
{
    self.currentStateCode = stateCode;
    self.currentStateName = stateName;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"QATimeTable" ofType:@"plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray* contactsQAKeys = [[NSArray alloc] initWithObjects:QA_TIMETABLE_KEYS];
    
    NSMutableArray* timeTableObjArray;
    
    timeTableObjArray = [NSMutableArray array];

    //Read all QA timetables from .plist file 
    for(int cKey = 0; cKey < [plistData count];cKey++)
    {
        NSString* keyValue = [contactsQAKeys objectAtIndex:cKey];
        NSDictionary* cDictionary = [plistData objectForKey:keyValue];
        
        //Title object
        QATimeTableObject* cQATimetableTitleObj = [[QATimeTableObject alloc] init];
        cQATimetableTitleObj.escalation = [[NSString alloc] initWithString:keyValue];
        cQATimetableTitleObj.description = @"";
        cQATimetableTitleObj.bIsTitle = TRUE;
        
        [timeTableObjArray addObject:cQATimetableTitleObj];
        
        //Fetch escalation and description arrays from plist file
        NSArray* cEscalationArray = [cDictionary objectForKey:@"QA Escalation"];
        NSArray* cDescriptionArray = [cDictionary objectForKey:@"Description"];
        
        
        for(int subKey=0;subKey<[cEscalationArray count];subKey++)
        {
            QATimeTableObject* cQATimetableObj = [[QATimeTableObject alloc] init];
            cQATimetableObj.escalation = [cEscalationArray objectAtIndex:subKey];
            cQATimetableObj.description = [cDescriptionArray objectAtIndex:subKey];
            cQATimetableObj.bIsTitle = FALSE;
            [timeTableObjArray addObject:cQATimetableObj];
        }
    }
    
    //Display QA timetable objects on screen
    CGRect scrollRect = _scrollView.bounds;
    
    
    int scrollWidth =0;
//     UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsPortrait(currentOrientation))
        scrollWidth = scrollRect.size.width;
    else
        scrollWidth = 650;
    
//    int scrollWidth = 650;//scrollRect.size.width;
    
    int xPosEsc = scrollRect.origin.x;
    int xPosDescr = scrollWidth/2;
    int yStartPos = scrollRect.origin.y;
    _scrollView.contentSize = CGSizeMake(scrollWidth, [timeTableObjArray count]*ROW_HEIGHT + ([timeTableObjArray count]-1)*ROW_OFFSET_TIMETABLE);
    _scrollView.backgroundColor = [UIColor clearColor];
    
    
    [_scrollView clearsContextBeforeDrawing];
    
    for (UIView *subview in _scrollView.subviews) {
        if([subview isKindOfClass:[UILabel class]])
            [subview removeFromSuperview];
    }
    for(int cLabel = 0; cLabel <[timeTableObjArray count]; cLabel++)
    {
        yStartPos = cLabel * ROW_HEIGHT + ROW_OFFSET_TIMETABLE;
        QATimeTableObject* cQATimetableObj = [timeTableObjArray objectAtIndex:cLabel];
       
       
        
        if(cQATimetableObj.bIsTitle) 
        {
            //Title
             UILabel* escalationLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPosEsc+15, yStartPos, xPosDescr-30, ROW_HEIGHT)];
            escalationLabel.text = cQATimetableObj.escalation;
           escalationLabel.textAlignment=UITextAlignmentLeft;
             escalationLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:22.0];
            escalationLabel.textColor = RGB(60,179,113); //[UIColor orangeColor];
            escalationLabel.backgroundColor = [UIColor  clearColor];
            
            [_scrollView addSubview:escalationLabel];
           

        }
        else
        {
            //QA Escalation
            UILabel* escalationLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPosEsc, yStartPos, xPosDescr-30, ROW_HEIGHT)];
             UILabel* descrLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPosDescr-20, yStartPos, xPosDescr+20, ROW_HEIGHT)];
            escalationLabel.text = cQATimetableObj.escalation;
            escalationLabel.textAlignment = UITextAlignmentRight;
            escalationLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:18.0];
            escalationLabel.numberOfLines =0;
            escalationLabel.textColor = [UIColor whiteColor];
             escalationLabel.backgroundColor = [UIColor  clearColor];
            //Description
            descrLabel.text = cQATimetableObj.description;
            descrLabel.textAlignment = UITextAlignmentLeft;
            descrLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:18.0];
            descrLabel.numberOfLines = 0;
            
            descrLabel.textColor =[UIColor blackColor]; //RGB(0,178,238);
             descrLabel.backgroundColor = [UIColor  clearColor];
            [_scrollView addSubview:escalationLabel];
            [_scrollView addSubview:descrLabel];
        }
    }
   //Change state name to selected state
    [_stateChangeButton setTitle:stateName forState:UIControlStateNormal];

    //Dismiss the state selection pop over
    [popOverController dismissPopoverAnimated:YES];
}
@end
