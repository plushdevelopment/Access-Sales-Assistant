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
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"neverVisitValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"neverVisit"];
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
	if ([key isEqualToString:@"submittedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"submitted"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic address;






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





@dynamic lastVisit;






@dynamic latitude;



- (float)latitudeValue {
	NSNumber *result = [self latitude];
	return [result floatValue];
}

- (void)setLatitudeValue:(float)value_ {
	[self setLatitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result floatValue];
}

- (void)setPrimitiveLatitudeValue:(float)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithFloat:value_]];
}





@dynamic longitude;



- (float)longitudeValue {
	NSNumber *result = [self longitude];
	return [result floatValue];
}

- (void)setLongitudeValue:(float)value_ {
	[self setLongitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result floatValue];
}

- (void)setPrimitiveLongitudeValue:(float)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithFloat:value_]];
}





@dynamic name;






@dynamic neverVisit;



- (BOOL)neverVisitValue {
	NSNumber *result = [self neverVisit];
	return [result boolValue];
}

- (void)setNeverVisitValue:(BOOL)value_ {
	[self setNeverVisit:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveNeverVisitValue {
	NSNumber *result = [self primitiveNeverVisit];
	return [result boolValue];
}

- (void)setPrimitiveNeverVisitValue:(BOOL)value_ {
	[self setPrimitiveNeverVisit:[NSNumber numberWithBool:value_]];
}





@dynamic nextScheduledVisit;






@dynamic nextScheduledVisitDate;






@dynamic nextScheduledVisitTime;






@dynamic numberOfEmployees;



- (int)numberOfEmployeesValue {
	NSNumber *result = [self numberOfEmployees];
	return [result intValue];
}

- (void)setNumberOfEmployeesValue:(int)value_ {
	[self setNumberOfEmployees:[NSNumber numberWithInt:value_]];
}

- (int)primitiveNumberOfEmployeesValue {
	NSNumber *result = [self primitiveNumberOfEmployees];
	return [result intValue];
}

- (void)setPrimitiveNumberOfEmployeesValue:(int)value_ {
	[self setPrimitiveNumberOfEmployees:[NSNumber numberWithInt:value_]];
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






@dynamic submitted;



- (BOOL)submittedValue {
	NSNumber *result = [self submitted];
	return [result boolValue];
}

- (void)setSubmittedValue:(BOOL)value_ {
	[self setSubmitted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveSubmittedValue {
	NSNumber *result = [self primitiveSubmitted];
	return [result boolValue];
}

- (void)setPrimitiveSubmittedValue:(BOOL)value_ {
	[self setPrimitiveSubmitted:[NSNumber numberWithBool:value_]];
}





@dynamic uid;






@dynamic webAddress;






@dynamic addresses;

	
- (NSMutableSet*)addressesSet {
	[self willAccessValueForKey:@"addresses"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"addresses"];
	[self didAccessValueForKey:@"addresses"];
	return result;
}
	

@dynamic auntk;

	

@dynamic chainAuntk;

	

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
