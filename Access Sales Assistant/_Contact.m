// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.m instead.

#import "_Contact.h"

@implementation ContactID
@end

@implementation _Contact

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Contact";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:moc_];
}

- (ContactID*)objectID {
	return (ContactID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"editedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"edited"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"rdFollowUpValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rdFollowUp"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




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





@dynamic firstName;






@dynamic lastName;






@dynamic producerId;






@dynamic rdFollowUp;



- (BOOL)rdFollowUpValue {
	NSNumber *result = [self rdFollowUp];
	return [result boolValue];
}

- (void)setRdFollowUpValue:(BOOL)value_ {
	[self setRdFollowUp:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveRdFollowUpValue {
	NSNumber *result = [self primitiveRdFollowUp];
	return [result boolValue];
}

- (void)setPrimitiveRdFollowUpValue:(BOOL)value_ {
	[self setPrimitiveRdFollowUp:[NSNumber numberWithBool:value_]];
}





@dynamic ssn;






@dynamic uid;






@dynamic emails;

	
- (NSMutableSet*)emailsSet {
	[self willAccessValueForKey:@"emails"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"emails"];
	[self didAccessValueForKey:@"emails"];
	return result;
}
	

@dynamic phoneNumbers;

	
- (NSMutableSet*)phoneNumbersSet {
	[self willAccessValueForKey:@"phoneNumbers"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"phoneNumbers"];
	[self didAccessValueForKey:@"phoneNumbers"];
	return result;
}
	

@dynamic producer;

	

@dynamic type;

	





@end
