// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BarrierToBusiness.m instead.

#import "_BarrierToBusiness.h"

@implementation BarrierToBusinessID
@end

@implementation _BarrierToBusiness

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BarrierToBusiness" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BarrierToBusiness";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BarrierToBusiness" inManagedObjectContext:moc_];
}

- (BarrierToBusinessID*)objectID {
	return (BarrierToBusinessID*)[super objectID];
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
