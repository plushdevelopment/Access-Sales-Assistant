// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PersonSpokeWithTitle.m instead.

#import "_PersonSpokeWithTitle.h"

@implementation PersonSpokeWithTitleID
@end

@implementation _PersonSpokeWithTitle

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PersonSpokeWithTitle" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PersonSpokeWithTitle";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PersonSpokeWithTitle" inManagedObjectContext:moc_];
}

- (PersonSpokeWithTitleID*)objectID {
	return (PersonSpokeWithTitleID*)[super objectID];
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





@dynamic personSpokeWith;

	
- (NSMutableSet*)personSpokeWithSet {
	[self willAccessValueForKey:@"personSpokeWith"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"personSpokeWith"];
	[self didAccessValueForKey:@"personSpokeWith"];
	return result;
}
	





@end
