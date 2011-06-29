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
	

	return keyPaths;
}




@dynamic createdBy;






@dynamic lastName;






@dynamic guid;






@dynamic firstName;






@dynamic updatedBy;






@dynamic ssn;






@dynamic updatedDtm;






@dynamic createdDtm;






@dynamic type;

	

@dynamic emailList;

	
- (NSMutableSet*)emailListSet {
	[self willAccessValueForKey:@"emailList"];
	NSMutableSet *result = [self mutableSetValueForKey:@"emailList"];
	[self didAccessValueForKey:@"emailList"];
	return result;
}
	

@dynamic producer;

	

@dynamic phoneList;

	
- (NSMutableSet*)phoneListSet {
	[self willAccessValueForKey:@"phoneList"];
	NSMutableSet *result = [self mutableSetValueForKey:@"phoneList"];
	[self didAccessValueForKey:@"phoneList"];
	return result;
}
	





@end
