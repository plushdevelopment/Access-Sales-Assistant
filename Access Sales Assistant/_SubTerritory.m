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
	
	if ([key isEqualToString:@"guidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"guid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic guid;



- (short)guidValue {
	NSNumber *result = [self guid];
	return [result shortValue];
}

- (void)setGuidValue:(short)value_ {
	[self setGuid:[NSNumber numberWithShort:value_]];
}

- (short)primitiveGuidValue {
	NSNumber *result = [self primitiveGuid];
	return [result shortValue];
}

- (void)setPrimitiveGuidValue:(short)value_ {
	[self setPrimitiveGuid:[NSNumber numberWithShort:value_]];
}





@dynamic producers;

	
- (NSMutableSet*)producersSet {
	[self willAccessValueForKey:@"producers"];
	NSMutableSet *result = [self mutableSetValueForKey:@"producers"];
	[self didAccessValueForKey:@"producers"];
	return result;
}
	





@end
