// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Type.m instead.

#import "_Type.h"

@implementation TypeID
@end

@implementation _Type

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Type";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Type" inManagedObjectContext:moc_];
}

- (TypeID*)objectID {
	return (TypeID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic guid;






@dynamic name;






@dynamic contacts;

	
- (NSMutableSet*)contactsSet {
	[self willAccessValueForKey:@"contacts"];
	NSMutableSet *result = [self mutableSetValueForKey:@"contacts"];
	[self didAccessValueForKey:@"contacts"];
	return result;
}
	





@end
