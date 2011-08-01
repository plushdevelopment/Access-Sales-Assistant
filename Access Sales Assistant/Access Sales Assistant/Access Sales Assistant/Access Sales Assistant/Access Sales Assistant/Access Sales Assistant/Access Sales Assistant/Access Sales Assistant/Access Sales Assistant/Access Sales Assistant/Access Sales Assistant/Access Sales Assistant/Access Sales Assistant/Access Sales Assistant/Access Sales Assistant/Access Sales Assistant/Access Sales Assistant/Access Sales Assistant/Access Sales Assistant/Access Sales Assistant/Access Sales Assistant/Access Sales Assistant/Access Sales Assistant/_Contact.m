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
	
	if ([key isEqualToString:@"rdFollowUpValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rdFollowUp"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic firstName;






@dynamic lastName;






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






@dynamic emailList;

	
- (NSMutableSet*)emailListSet {
	[self willAccessValueForKey:@"emailList"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"emailList"];
	[self didAccessValueForKey:@"emailList"];
	return result;
}
	

@dynamic phoneList;

	
- (NSMutableSet*)phoneListSet {
	[self willAccessValueForKey:@"phoneList"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"phoneList"];
	[self didAccessValueForKey:@"phoneList"];
	return result;
}
	

@dynamic producer;

	

@dynamic type;

	





@end
