// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IneligibleReason.m instead.

#import "_IneligibleReason.h"

@implementation IneligibleReasonID
@end

@implementation _IneligibleReason

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"IneligibleReason" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"IneligibleReason";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"IneligibleReason" inManagedObjectContext:moc_];
}

- (IneligibleReasonID*)objectID {
	return (IneligibleReasonID*)[super objectID];
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





@dynamic producer;

	
- (NSMutableSet*)producerSet {
	[self willAccessValueForKey:@"producer"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"producer"];
	[self didAccessValueForKey:@"producer"];
	return result;
}
	





@end
