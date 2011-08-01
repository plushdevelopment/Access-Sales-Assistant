// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Phase.m instead.

#import "_Phase.h"

@implementation PhaseID
@end

@implementation _Phase

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Phase" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Phase";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Phase" inManagedObjectContext:moc_];
}

- (PhaseID*)objectID {
	return (PhaseID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"uidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"uid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic name;






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





@dynamic dailySummary;

	
- (NSMutableSet*)dailySummarySet {
	[self willAccessValueForKey:@"dailySummary"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"dailySummary"];
	[self didAccessValueForKey:@"dailySummary"];
	return result;
}
	





@end
