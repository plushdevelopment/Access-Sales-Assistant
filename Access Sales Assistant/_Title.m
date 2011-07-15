// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Title.m instead.

#import "_Title.h"

@implementation TitleID
@end

@implementation _Title

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Title" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Title";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Title" inManagedObjectContext:moc_];
}

- (TitleID*)objectID {
	return (TitleID*)[super objectID];
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






@dynamic contact;

	
- (NSMutableSet*)contactSet {
	[self willAccessValueForKey:@"contact"];
	NSMutableSet *result = [self mutableSetValueForKey:@"contact"];
	[self didAccessValueForKey:@"contact"];
	return result;
}
	

@dynamic personSpokeWith;

	
- (NSMutableSet*)personSpokeWithSet {
	[self willAccessValueForKey:@"personSpokeWith"];
	NSMutableSet *result = [self mutableSetValueForKey:@"personSpokeWith"];
	[self didAccessValueForKey:@"personSpokeWith"];
	return result;
}
	





@end
