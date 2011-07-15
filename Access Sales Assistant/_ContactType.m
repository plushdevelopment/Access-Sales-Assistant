// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ContactType.m instead.

#import "_ContactType.h"

@implementation ContactTypeID
@end

@implementation _ContactType

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ContactType" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ContactType";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ContactType" inManagedObjectContext:moc_];
}

- (ContactTypeID*)objectID {
	return (ContactTypeID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic uid;






@dynamic name;






@dynamic contacts;

	
- (NSMutableSet*)contactsSet {
	[self willAccessValueForKey:@"contacts"];
	NSMutableSet *result = [self mutableSetValueForKey:@"contacts"];
	[self didAccessValueForKey:@"contacts"];
	return result;
}
	





@end
