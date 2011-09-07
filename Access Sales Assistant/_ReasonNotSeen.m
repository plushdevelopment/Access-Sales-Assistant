// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ReasonNotSeen.m instead.

#import "_ReasonNotSeen.h"

@implementation ReasonNotSeenID
@end

@implementation _ReasonNotSeen

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ReasonNotSeen" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ReasonNotSeen";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ReasonNotSeen" inManagedObjectContext:moc_];
}

- (ReasonNotSeenID*)objectID {
	return (ReasonNotSeenID*)[super objectID];
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





@dynamic dailySummaries;

	
- (NSMutableSet*)dailySummariesSet {
	[self willAccessValueForKey:@"dailySummaries"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"dailySummaries"];
	[self didAccessValueForKey:@"dailySummaries"];
	return result;
}
	





@end
