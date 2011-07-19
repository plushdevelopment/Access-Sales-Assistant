//
//  ProfileTableViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProfileTableViewController.h"

@implementation ProfileTableViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Gracefully handle reloading the view controller after a memory warning
    tableModel = [[SCModelCenter sharedModelCenter] modelForViewController:self];
    if(tableModel)
    {
        [tableModel replaceModeledTableViewWith:self.tableView];
        return;
    }
    
	
    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    self.navigationItem.rightBarButtonItem = addButton;
	
	// Get managedObjectContext from application delegate
	NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext defaultContext];
	
    // Create a class definition for CategoryEntity
    SCClassDefinition *producerClassDef = [SCClassDefinition definitionWithEntityName:@"Producer" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
    producerClassDef.orderAttributeName = @"name";
	
	// Instantiate the tabel model
	tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
	
	// Create and add the objects section
	SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil
																	withEntityClassDefinition:producerClassDef];
	objectsSection.addButtonItem = self.navigationItem.rightBarButtonItem;
	[tableModel addSection:objectsSection];
}

@end
