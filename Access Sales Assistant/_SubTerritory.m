// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SubTerritory.m instead.

#import "_SubTerritory.h"

@implementation SubTerritoryID
@end

@implementation _SubTerritory

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SubTerritory" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SubTerritory";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SubTerritory" inManagedObjectContext:moc_];
}

- (SubTerritoryID*)objectID {
	return (SubTerritoryID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic guid;






@dynamic name;






@dynamic producers;

	
- (NSMutableSet*)producersSet {
	[self willAccessValueForKey:@"producers"];
	NSMutableSet *result = [self mutableSetValueForKey:@"producers"];
	[self didAccessValueForKey:@"producers"];
	return result;
}
	





@end
