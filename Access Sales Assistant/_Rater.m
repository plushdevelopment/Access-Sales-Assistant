// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Rater.m instead.

#import "_Rater.h"

@implementation RaterID
@end

@implementation _Rater

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Rater" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Rater";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Rater" inManagedObjectContext:moc_];
}

- (RaterID*)objectID {
	return (RaterID*)[super objectID];
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





@dynamic name;






@dynamic producer;

	





@end
