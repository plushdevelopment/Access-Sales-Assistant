// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Rater2.m instead.

#import "_Rater2.h"

@implementation Rater2ID
@end

@implementation _Rater2

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Rater2" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Rater2";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Rater2" inManagedObjectContext:moc_];
}

- (Rater2ID*)objectID {
	return (Rater2ID*)[super objectID];
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
