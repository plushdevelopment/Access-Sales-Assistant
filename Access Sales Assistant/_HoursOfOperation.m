// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HoursOfOperation.m instead.

#import "_HoursOfOperation.h"

@implementation HoursOfOperationID
@end

@implementation _HoursOfOperation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"HoursOfOperation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"HoursOfOperation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"HoursOfOperation" inManagedObjectContext:moc_];
}

- (HoursOfOperationID*)objectID {
	return (HoursOfOperationID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic saturdayOpenTime;






@dynamic wednesdayCloseTime;






@dynamic mondayOpenTime;






@dynamic tuesdayOpenTime;






@dynamic mondayCloseTime;






@dynamic thursdayOpenTime;






@dynamic saturdayCloseTime;






@dynamic tuesdayCloseTime;






@dynamic fridayOpenTime;






@dynamic sundayCloseTime;






@dynamic sundayOpenTime;






@dynamic thursdayCloseTime;






@dynamic fridayCloseTime;






@dynamic wednesdayOpenTime;






@dynamic producer;

	
- (NSMutableSet*)producerSet {
	[self willAccessValueForKey:@"producer"];
	NSMutableSet *result = [self mutableSetValueForKey:@"producer"];
	[self didAccessValueForKey:@"producer"];
	return result;
}
	





@end
