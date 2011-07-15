// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Competitor.m instead.

#import "_Competitor.h"

@implementation CompetitorID
@end

@implementation _Competitor

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Competitor" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Competitor";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Competitor" inManagedObjectContext:moc_];
}

- (CompetitorID*)objectID {
	return (CompetitorID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"editedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"edited"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"deletedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"deleted"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"appsPerMonthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"appsPerMonth"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic name;






@dynamic edited;



- (BOOL)editedValue {
	NSNumber *result = [self edited];
	return [result boolValue];
}

- (void)setEditedValue:(BOOL)value_ {
	[self setEdited:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveEditedValue {
	NSNumber *result = [self primitiveEdited];
	return [result boolValue];
}

- (void)setPrimitiveEditedValue:(BOOL)value_ {
	[self setPrimitiveEdited:[NSNumber numberWithBool:value_]];
}





@dynamic deleted;



- (BOOL)deletedValue {
	NSNumber *result = [self deleted];
	return [result boolValue];
}

- (void)setDeletedValue:(BOOL)value_ {
	[self setDeleted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveDeletedValue {
	NSNumber *result = [self primitiveDeleted];
	return [result boolValue];
}

- (void)setPrimitiveDeletedValue:(BOOL)value_ {
	[self setPrimitiveDeleted:[NSNumber numberWithBool:value_]];
}





@dynamic uid;






@dynamic appsPerMonth;



- (short)appsPerMonthValue {
	NSNumber *result = [self appsPerMonth];
	return [result shortValue];
}

- (void)setAppsPerMonthValue:(short)value_ {
	[self setAppsPerMonth:[NSNumber numberWithShort:value_]];
}

- (short)primitiveAppsPerMonthValue {
	NSNumber *result = [self primitiveAppsPerMonth];
	return [result shortValue];
}

- (void)setPrimitiveAppsPerMonthValue:(short)value_ {
	[self setPrimitiveAppsPerMonth:[NSNumber numberWithShort:value_]];
}





@dynamic dailySummaries;

	
- (NSMutableSet*)dailySummariesSet {
	[self willAccessValueForKey:@"dailySummaries"];
	NSMutableSet *result = [self mutableSetValueForKey:@"dailySummaries"];
	[self didAccessValueForKey:@"dailySummaries"];
	return result;
}
	





@end
