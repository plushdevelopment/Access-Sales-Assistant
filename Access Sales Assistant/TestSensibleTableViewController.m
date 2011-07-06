//
//  TestSensibleTableViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestSensibleTableViewController.h"

@implementation TestSensibleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Gracefully handle reloading the view controller after a memory warning
	tableModel = [[SCModelCenter sharedModelCenter] modelForViewController:self];
	if(tableModel)
	{
		[tableModel replaceModeledTableViewWith:self.tableView];
		return;
	}
	
	// Get managedObjectContext from application delegate
	NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext defaultContext];
	
	// Create a class definition for Producer
	SCClassDefinition *producerDef = [SCClassDefinition definitionWithEntityName:@"Producer" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	producerDef.orderAttributeName = @"name";
	
	// Create a class definition for AddressListItem
	SCClassDefinition *addressListItemDef =
	[SCClassDefinition definitionWithEntityName:@"AddressListItem" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for Contact
	SCClassDefinition *contactDef =
	[SCClassDefinition definitionWithEntityName:@"Contact" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for EmailListItem
	SCClassDefinition *emailListItemDef = [SCClassDefinition definitionWithEntityName:@"EmailListItem" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for AddressListItem
	SCClassDefinition *hoursOfOperationDef =
	[SCClassDefinition definitionWithEntityName:@"HoursOfOperation" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for Contact
	SCClassDefinition *ineligibleReasonDef =
	[SCClassDefinition definitionWithEntityName:@"IneligibleReason" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for Contact
	SCClassDefinition *phoneListItemDef =
	[SCClassDefinition definitionWithEntityName:@"PhoneListItem" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for Producer
	SCClassDefinition *questionListItemDef = [SCClassDefinition definitionWithEntityName:@"QuestionListItem" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for AddressListItem
	SCClassDefinition *raterDef =
	[SCClassDefinition definitionWithEntityName:@"Rater" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for Contact
	SCClassDefinition *stateDef =
	[SCClassDefinition definitionWithEntityName:@"State" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for EmailListItem
	SCClassDefinition *statusDef = [SCClassDefinition definitionWithEntityName:@"Status" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for AddressListItem
	SCClassDefinition *subTerritoryDef =
	[SCClassDefinition definitionWithEntityName:@"SubTerritory" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for Contact
	SCClassDefinition *suspensionReasonDef =
	[SCClassDefinition definitionWithEntityName:@"SuspensionReason" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	// Create a class definition for Contact
	SCClassDefinition *typeDef =
	[SCClassDefinition definitionWithEntityName:@"Type" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	
	
	// Instantiate the tabel model
	tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
	
	// Create and add the objects section
	SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil
																	withEntityClassDefinition:producerDef];
	objectsSection.addButtonItem = self.navigationItem.rightBarButtonItem;
	[tableModel addSection:objectsSection];
}


@end
