// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SuspensionReason.m instead.

#import "_SuspensionReason.h"

@implementation SuspensionReasonID
@end

@implementation _SuspensionReason

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SuspensionReason" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SuspensionReason";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SuspensionReason" inManagedObjectContext:moc_];
}

- (SuspensionReasonID*)objectID {
	return (SuspensionReasonID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic guid;






@dynamic name;






@dynamic producers;

	
- (NSMutableSet*)producersSet {
	[self willAccessValueForKey:@"producers"];
	NSMutableSet *result = [self mutableSetValueForKey:@"producers"];
	[self didAccessValueForKey:@"producers"];
	return result;
}
	





@end
