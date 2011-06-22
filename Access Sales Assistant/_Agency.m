// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Agency.m instead.

#import "_Agency.h"

@implementation AgencyID
@end

@implementation _Agency

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Agency" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Agency";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Agency" inManagedObjectContext:moc_];
}

- (AgencyID*)objectID {
	return (AgencyID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic guid;






@dynamic name;










@end
