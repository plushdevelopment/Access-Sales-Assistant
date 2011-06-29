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
	

	return keyPaths;
}




@dynamic name;






@dynamic updatedBy;






@dynamic guid;






@dynamic createdDtm;






@dynamic createdBy;






@dynamic updatedDtm;






@dynamic producer;

	





@end
