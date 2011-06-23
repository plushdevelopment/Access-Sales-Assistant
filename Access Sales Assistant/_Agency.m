// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Agency.m instead.

#import "_Agency.h"

@implementation AgencyID
@end

@implementation _Agency

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Agency" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Agency";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Agency" inManagedObjectContext:moc_];
}

- (AgencyID*)objectID {
	return (AgencyID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"eligibleValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"eligible"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"numberOfEmployeesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numberOfEmployees"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"accessSignValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"accessSign"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"numberOfLocationsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"numberOfLocations"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic suspensionReason;






@dynamic eligible;



- (BOOL)eligibleValue {
	NSNumber *result = [self eligible];
	return [result boolValue];
}

- (void)setEligibleValue:(BOOL)value_ {
	[self setEligible:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveEligibleValue {
	NSNumber *result = [self primitiveEligible];
	return [result boolValue];
}

- (void)setPrimitiveEligibleValue:(BOOL)value_ {
	[self setPrimitiveEligible:[NSNumber numberWithBool:value_]];
}





@dynamic subTerritory;






@dynamic customerServiceEmail;






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





@dynamic primaryContact;






@dynamic accessSign;



- (BOOL)accessSignValue {
	NSNumber *result = [self accessSign];
	return [result boolValue];
}

- (void)setAccessSignValue:(BOOL)value_ {
	[self setAccessSign:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveAccessSignValue {
	NSNumber *result = [self primitiveAccessSign];
	return [result boolValue];
}

- (void)setPrimitiveAccessSignValue:(BOOL)value_ {
	[self setPrimitiveAccessSign:[NSNumber numberWithBool:value_]];
}





@dynamic name;






@dynamic fax;






@dynamic howDoYouMarketYourAgency;






@dynamic statusDate;






@dynamic agencyName;






@dynamic accountingEmail;






@dynamic phone1;






@dynamic mainEmail;






@dynamic eAndOExpires;






@dynamic appointedDate;






@dynamic websiteAddress;






@dynamic reasonIneligible;






@dynamic dateEstablished;






@dynamic guid;






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





@dynamic rater;






@dynamic status;






@dynamic rater2;






@dynamic claimsEmail;






@dynamic producerCode;










@end
