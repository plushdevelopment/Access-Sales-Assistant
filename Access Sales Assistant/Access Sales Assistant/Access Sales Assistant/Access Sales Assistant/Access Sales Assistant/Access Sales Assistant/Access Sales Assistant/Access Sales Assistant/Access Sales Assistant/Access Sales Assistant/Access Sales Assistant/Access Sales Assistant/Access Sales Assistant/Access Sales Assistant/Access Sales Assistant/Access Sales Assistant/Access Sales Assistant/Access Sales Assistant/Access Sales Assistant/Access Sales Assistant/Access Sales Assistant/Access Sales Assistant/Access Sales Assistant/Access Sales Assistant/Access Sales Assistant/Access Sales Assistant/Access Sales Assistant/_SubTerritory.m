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
	
	if ([key isEqualToString:@"uidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"uid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic uid;



- (short)uidValue {
	NSNumber *result = [self uid];
	return [result shortValue];
}

- (void)setUidValue:(short)value_ {
	[self setUid:[NSNumber numberWithShort:value_]];
}

- (short)primitiveUidValue {
	NSNumber *result = [self primitiveUid];
	return [result shortValue];
}

- (void)setPrimitiveUidValue:(short)value_ {
	[self setPrimitiveUid:[NSNumber numberWithShort:value_]];
}





@dynamic producers;

	
- (NSMutableSet*)producersSet {
	[self willAccessValueForKey:@"producers"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"producers"];
	[self didAccessValueForKey:@"producers"];
	return result;
}
	





@end
