// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Producer.m instead.

#import "_Producer.h"

@implementation ProducerID
@end

@implementation _Producer

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Producer" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Producer";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Producer" inManagedObjectContext:moc_];
}

- (ProducerID*)objectID {
	return (ProducerID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"editedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"edited"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"hasAccessSignValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasAccessSign"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"isEligibleValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isEligible"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"numberOfEmployeesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numberOfEmployees"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"numberOfLocationsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numberOfLocations"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic appointedDate;






@dynamic dateEstablished;






@dynamic eAndOExpires;






@dynamic edited;



- (BOOL)editedValue {
	NSNumber *result = [self edited];
	return [result boolValue];
}

- (void)setEditedValue:(BOOL)value_ {
	[self setEdited:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveEditedValue {
	NSNumber *result = [self primitiveEdited];
	return [result boolValue];
}

- (void)setPrimitiveEditedValue:(BOOL)value_ {
	[self setPrimitiveEdited:[NSNumber numberWithBool:value_]];
}





@dynamic hasAccessSign;



- (BOOL)hasAccessSignValue {
	NSNumber *result = [self hasAccessSign];
	return [result boolValue];
}

- (void)setHasAccessSignValue:(BOOL)value_ {
	[self setHasAccessSign:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasAccessSignValue {
	NSNumber *result = [self primitiveHasAccessSign];
	return [result boolValue];
}

- (void)setPrimitiveHasAccessSignValue:(BOOL)value_ {
	[self setPrimitiveHasAccessSign:[NSNumber numberWithBool:value_]];
}





@dynamic isEligible;



- (BOOL)isEligibleValue {
	NSNumber *result = [self isEligible];
	return [result boolValue];
}

- (void)setIsEligibleValue:(BOOL)value_ {
	[self setIsEligible:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsEligibleValue {
	NSNumber *result = [self primitiveIsEligible];
	return [result boolValue];
}

- (void)setPrimitiveIsEligibleValue:(BOOL)value_ {
	[self setPrimitiveIsEligible:[NSNumber numberWithBool:value_]];
}





@dynamic name;






@dynamic numberOfEmployees;



- (short)numberOfEmployeesValue {
	NSNumber *result = [self numberOfEmployees];
	return [result shortValue];
}

- (void)setNumberOfEmployeesValue:(short)value_ {
	[self setNumberOfEmployees:[NSNumber numberWithShort:value_]];
}

- (short)primitiveNumberOfEmployeesValue {
	NSNumber *result = [self primitiveNumberOfEmployees];
	return [result shortValue];
}

- (void)setPrimitiveNumberOfEmployeesValue:(short)value_ {
	[self setPrimitiveNumberOfEmployees:[NSNumber numberWithShort:value_]];
}





@dynamic numberOfLocations;



- (short)numberOfLocationsValue {
	NSNumber *result = [self numberOfLocations];
	return [result shortValue];
}

- (void)setNumberOfLocationsValue:(short)value_ {
	[self setNumberOfLocations:[NSNumber numberWithShort:value_]];
}

- (short)primitiveNumberOfLocationsValue {
	NSNumber *result = [self primitiveNumberOfLocations];
	return [result shortValue];
}

- (void)setPrimitiveNumberOfLocationsValue:(short)value_ {
	[self setPrimitiveNumberOfLocations:[NSNumber numberWithShort:value_]];
}





@dynamic primaryContact;






@dynamic producerCode;






@dynamic statusDate;






@dynamic uid;






@dynamic webAddress;






@dynamic addresses;

	
- (NSMutableSet*)addressesSet {
	[self willAccessValueForKey:@"addresses"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"addresses"];
	[self didAccessValueForKey:@"addresses"];
	return result;
}
	

@dynamic contacts;

	
- (NSMutableSet*)contactsSet {
	[self willAccessValueForKey:@"contacts"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"contacts"];
	[self didAccessValueForKey:@"contacts"];
	return result;
}
	

@dynamic dailySummary;

	

@dynamic emails;

	
- (NSMutableSet*)emailsSet {
	[self willAccessValueForKey:@"emails"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"emails"];
	[self didAccessValueForKey:@"emails"];
	return result;
}
	

@dynamic hoursOfOperation;

	

@dynamic images;

	
- (NSMutableSet*)imagesSet {
	[self willAccessValueForKey:@"images"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"images"];
	[self didAccessValueForKey:@"images"];
	return result;
}
	

@dynamic ineligibleReason;

	

@dynamic phoneNumbers;

	
- (NSMutableSet*)phoneNumbersSet {
	[self willAccessValueForKey:@"phoneNumbers"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"phoneNumbers"];
	[self didAccessValueForKey:@"phoneNumbers"];
	return result;
}
	

@dynamic questions;

	
- (NSMutableSet*)questionsSet {
	[self willAccessValueForKey:@"questions"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"questions"];
	[self didAccessValueForKey:@"questions"];
	return result;
}
	

@dynamic rater;

	

@dynamic rater2;

	

@dynamic status;

	

@dynamic subTerritory;

	

@dynamic suspensionReason;

	





@end
