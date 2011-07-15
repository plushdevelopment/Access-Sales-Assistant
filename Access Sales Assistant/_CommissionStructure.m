// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CommissionStructure.m instead.

#import "_CommissionStructure.h"

@implementation CommissionStructureID
@end

@implementation _CommissionStructure

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CommissionStructure" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CommissionStructure";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CommissionStructure" inManagedObjectContext:moc_];
}

- (CommissionStructureID*)objectID {
	return (CommissionStructureID*)[super objectID];
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





@dynamic name;






@dynamic dailySummaries;

	
- (NSMutableSet*)dailySummariesSet {
	[self willAccessValueForKey:@"dailySummaries"];
	NSMutableSet *result = [self mutableSetValueForKey:@"dailySummaries"];
	[self didAccessValueForKey:@"dailySummaries"];
	return result;
}
	





@end
