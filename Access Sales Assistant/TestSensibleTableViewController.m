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
	
	
	// Set up the edit and add buttons.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
	self.navigationItem.rightBarButtonItem = addButton;
	
	// Get managedObjectContext from application delegate
	NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext defaultContext];
	
	// Create a class definition for Producer
	SCClassDefinition *producerDef = [SCClassDefinition definitionWithEntityName:@"Producer" withManagedObjectContext:managedObjectContext autoGeneratePropertyDefinitions:YES];
	producerDef.orderAttributeName = @"producerCode";
	
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
	
	SCPropertyDefinition *tsdescPropertyDef = [taskStepDef propertyDefinitionWithName:@"desc"];
	tsdescPropertyDef.title = @"Description";
	tsdescPropertyDef.type = SCPropertyTypeTextView;
	
	
	// Create a class definition for TaskEntity
	SCClassDefinition *taskDef = 
	[SCClassDefinition definitionWithEntityName:@"TaskEntity" withManagedObjectContext:managedObjectContext
							  withPropertyNames: [NSArray arrayWithObjects:@"name", @"desc", @"dueDate", @"active", @"priority", 
												  @"category", @"assignedTo", @"taskSteps", nil]];
	taskDef.requireEditingModeToEditPropertyValues = TRUE; // lock all property values until put in editing mode
	taskDef.orderAttributeName = @"order";
	// Create a special group for task steps
	SCPropertyGroup *stepsGroup = [SCPropertyGroup groupWithHeaderTitle:@"Task Steps" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"taskSteps", nil]];
	[taskDef.propertyGroups addGroup:stepsGroup];
	// Do some property definition customization
	SCPropertyDefinition *descPropertyDef = [taskDef propertyDefinitionWithName:@"desc"];
	descPropertyDef.title = @"Description";
	descPropertyDef.type = SCPropertyTypeTextView;
	SCPropertyDefinition *priorityPropertyDef = [taskDef propertyDefinitionWithName:@"priority"];
	priorityPropertyDef.type = SCPropertyTypeSegmented;
	priorityPropertyDef.attributes = [SCSegmentedAttributes 
									  attributesWithSegmentTitlesArray:[NSArray arrayWithObjects:@"Low", @"Medium", @"High", nil]];
	SCPropertyDefinition *categoryPropertyDef = [taskDef propertyDefinitionWithName:@"category"];
	categoryPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *selectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:categoryDef allowMultipleSelection:NO allowNoSelection:NO];
	selectionAttribs.allowAddingItems = YES;
	selectionAttribs.allowDeletingItems = YES;
	selectionAttribs.allowMovingItems = YES;
	selectionAttribs.allowEditingItems = YES;
	selectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(no categories defined)"];
	selectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new category"];
	categoryPropertyDef.attributes = selectionAttribs;
	SCPropertyDefinition *assignedToPropertyDef = [taskDef propertyDefinitionWithName:@"assignedTo"];
	assignedToPropertyDef.type = SCPropertyTypeObjectSelection;
	assignedToPropertyDef.attributes = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:personDef
																					  allowMultipleSelection:NO
																							allowNoSelection:NO];
	SCPropertyDefinition *taskStepsPropertyDef = [taskDef propertyDefinitionWithName:@"taskSteps"];
	taskStepsPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:taskStepDef
																					 allowAddingItems:YES
																				   allowDeletingItems:YES
																					 allowMovingItems:YES
																		   expandContentInCurrentView:YES 
																				 placeholderuiElement:[SCTableViewCell cellWithText:@"(no steps defined)"] 
																				addNewObjectuiElement:[SCTableViewCell cellWithText:@"Add step"] 
															  addNewObjectuiElementExistsInNormalMode:NO addNewObjectuiElementExistsInEditingMode:YES];
	
	// Instantiate the tabel model
	tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];
	
	// Create and add the objects section
	SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil
																	withEntityClassDefinition:taskDef];
	objectsSection.addButtonItem = self.navigationItem.rightBarButtonItem;
	[tableModel addSection:objectsSection];
}


@end
