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




@dynamic fridayCloseTime;






@dynamic fridayOpenTime;






@dynamic mondayCloseTime;






@dynamic mondayOpenTime;






@dynamic saturdayCloseTime;






@dynamic saturdayOpenTime;






@dynamic sundayCloseTime;






@dynamic sundayOpenTime;






@dynamic thursdayCloseTime;






@dynamic thursdayOpenTime;






@dynamic tuesdayCloseTime;






@dynamic tuesdayOpenTime;






@dynamic wednesdayCloseTime;






@dynamic wednesdayOpenTime;






@dynamic producer;

	
- (NSMutableSet*)producerSet {
	[self willAccessValueForKey:@"producer"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"producer"];
	[self didAccessValueForKey:@"producer"];
	return result;
}
	





@end
