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
	

	return keyPaths;
}




@dynamic guid;






@dynamic name;






@dynamic producer;

	
- (NSMutableSet*)producerSet {
	[self willAccessValueForKey:@"producer"];
	NSMutableSet *result = [self mutableSetValueForKey:@"producer"];
	[self didAccessValueForKey:@"producer"];
	return result;
}
	





@end
