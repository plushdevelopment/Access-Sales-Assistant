// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Status.m instead.

#import "_Status.h"

@implementation StatusID
@end

@implementation _Status

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Status" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Status";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Status" inManagedObjectContext:moc_];
}

- (StatusID*)objectID {
	return (StatusID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic updatedBy;






@dynamic guid;






@dynamic createdDtm;






@dynamic createdBy;






@dynamic updatedDtm;






@dynamic producers;

	
- (NSMutableSet*)producersSet {
	[self willAccessValueForKey:@"producers"];
	NSMutableSet *result = [self mutableSetValueForKey:@"producers"];
	[self didAccessValueForKey:@"producers"];
	return result;
}
	





@end
