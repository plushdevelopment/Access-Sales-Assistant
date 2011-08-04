// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OperationHour.m instead.

#import "_OperationHour.h"

@implementation OperationHourID
@end

@implementation _OperationHour

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"OperationHour" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"OperationHour";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"OperationHour" inManagedObjectContext:moc_];
}

- (OperationHourID*)objectID {
	return (OperationHourID*)[super objectID];
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





@dynamic fridayCloseTime;

	
- (NSMutableSet*)fridayCloseTimeSet {
	[self willAccessValueForKey:@"fridayCloseTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fridayCloseTime"];
	[self didAccessValueForKey:@"fridayCloseTime"];
	return result;
}
	

@dynamic fridayOpenTime;

	
- (NSMutableSet*)fridayOpenTimeSet {
	[self willAccessValueForKey:@"fridayOpenTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fridayOpenTime"];
	[self didAccessValueForKey:@"fridayOpenTime"];
	return result;
}
	

@dynamic mondayCloseTime;

	
- (NSMutableSet*)mondayCloseTimeSet {
	[self willAccessValueForKey:@"mondayCloseTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"mondayCloseTime"];
	[self didAccessValueForKey:@"mondayCloseTime"];
	return result;
}
	

@dynamic mondayOpenTime;

	
- (NSMutableSet*)mondayOpenTimeSet {
	[self willAccessValueForKey:@"mondayOpenTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"mondayOpenTime"];
	[self didAccessValueForKey:@"mondayOpenTime"];
	return result;
}
	

@dynamic saturdayCloseTime;

	
- (NSMutableSet*)saturdayCloseTimeSet {
	[self willAccessValueForKey:@"saturdayCloseTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"saturdayCloseTime"];
	[self didAccessValueForKey:@"saturdayCloseTime"];
	return result;
}
	

@dynamic saturdayOpenTime;

	
- (NSMutableSet*)saturdayOpenTimeSet {
	[self willAccessValueForKey:@"saturdayOpenTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"saturdayOpenTime"];
	[self didAccessValueForKey:@"saturdayOpenTime"];
	return result;
}
	

@dynamic sundayCloseTime;

	
- (NSMutableSet*)sundayCloseTimeSet {
	[self willAccessValueForKey:@"sundayCloseTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"sundayCloseTime"];
	[self didAccessValueForKey:@"sundayCloseTime"];
	return result;
}
	

@dynamic sundayOpenTime;

	
- (NSMutableSet*)sundayOpenTimeSet {
	[self willAccessValueForKey:@"sundayOpenTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"sundayOpenTime"];
	[self didAccessValueForKey:@"sundayOpenTime"];
	return result;
}
	

@dynamic thursdayCloseTime;

	
- (NSMutableSet*)thursdayCloseTimeSet {
	[self willAccessValueForKey:@"thursdayCloseTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"thursdayCloseTime"];
	[self didAccessValueForKey:@"thursdayCloseTime"];
	return result;
}
	

@dynamic thursdayOpenTime;

	
- (NSMutableSet*)thursdayOpenTimeSet {
	[self willAccessValueForKey:@"thursdayOpenTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"thursdayOpenTime"];
	[self didAccessValueForKey:@"thursdayOpenTime"];
	return result;
}
	

@dynamic tuesdayCloseTime;

	
- (NSMutableSet*)tuesdayCloseTimeSet {
	[self willAccessValueForKey:@"tuesdayCloseTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tuesdayCloseTime"];
	[self didAccessValueForKey:@"tuesdayCloseTime"];
	return result;
}
	

@dynamic tuesdayOpenTime;

	
- (NSMutableSet*)tuesdayOpenTimeSet {
	[self willAccessValueForKey:@"tuesdayOpenTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tuesdayOpenTime"];
	[self didAccessValueForKey:@"tuesdayOpenTime"];
	return result;
}
	

@dynamic wednesdayCloseTime;

	
- (NSMutableSet*)wednesdayCloseTimeSet {
	[self willAccessValueForKey:@"wednesdayCloseTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wednesdayCloseTime"];
	[self didAccessValueForKey:@"wednesdayCloseTime"];
	return result;
}
	

@dynamic wednesdayOpenTime;

	
- (NSMutableSet*)wednesdayOpenTimeSet {
	[self willAccessValueForKey:@"wednesdayOpenTime"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"wednesdayOpenTime"];
	[self didAccessValueForKey:@"wednesdayOpenTime"];
	return result;
}
	





@end
