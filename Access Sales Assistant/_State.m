// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to State.m instead.

#import "_State.h"

@implementation StateID
@end

@implementation _State

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"State" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"State";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"State" inManagedObjectContext:moc_];
}

- (StateID*)objectID {
	return (StateID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic guid;






@dynamic name;






@dynamic addresses;

	
- (NSMutableSet*)addressesSet {
	[self willAccessValueForKey:@"addresses"];
	NSMutableSet *result = [self mutableSetValueForKey:@"addresses"];
	[self didAccessValueForKey:@"addresses"];
	return result;
}
	





@end
