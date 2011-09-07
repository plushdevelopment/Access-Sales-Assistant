// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DailySummary.m instead.

#import "_DailySummary.h"

@implementation DailySummaryID
@end

@implementation _DailySummary

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"DailySummary" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"DailySummary";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"DailySummary" inManagedObjectContext:moc_];
}

- (DailySummaryID*)objectID {
	return (DailySummaryID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"commissionPercentNewValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"commissionPercentNew"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"commissionPercentRenewalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"commissionPercentRenewal"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"deletedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"deleted"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"editedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"edited"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"nsbsFdlValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nsbsFdl"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"nsbsMonthlyGoalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nsbsMonthlyGoal"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"nsbsPercentLiabValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nsbsPercentLiab"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"nsbsTotAppsPerMonthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nsbsTotAppsPerMonth"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"rdFollowUpValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rdFollowUp"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"visitNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"visitNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic commissionPercentNew;



- (short)commissionPercentNewValue {
	NSNumber *result = [self commissionPercentNew];
	return [result shortValue];
}

- (void)setCommissionPercentNewValue:(short)value_ {
	[self setCommissionPercentNew:[NSNumber numberWithShort:value_]];
}

- (short)primitiveCommissionPercentNewValue {
	NSNumber *result = [self primitiveCommissionPercentNew];
	return [result shortValue];
}

- (void)setPrimitiveCommissionPercentNewValue:(short)value_ {
	[self setPrimitiveCommissionPercentNew:[NSNumber numberWithShort:value_]];
}





@dynamic commissionPercentRenewal;



- (short)commissionPercentRenewalValue {
	NSNumber *result = [self commissionPercentRenewal];
	return [result shortValue];
}

- (void)setCommissionPercentRenewalValue:(short)value_ {
	[self setCommissionPercentRenewal:[NSNumber numberWithShort:value_]];
}

- (short)primitiveCommissionPercentRenewalValue {
	NSNumber *result = [self primitiveCommissionPercentRenewal];
	return [result shortValue];
}

- (void)setPrimitiveCommissionPercentRenewalValue:(short)value_ {
	[self setPrimitiveCommissionPercentRenewal:[NSNumber numberWithShort:value_]];
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





@dynamic nsbsFdl;



- (int)nsbsFdlValue {
	NSNumber *result = [self nsbsFdl];
	return [result intValue];
}

- (void)setNsbsFdlValue:(int)value_ {
	[self setNsbsFdl:[NSNumber numberWithInt:value_]];
}

- (int)primitiveNsbsFdlValue {
	NSNumber *result = [self primitiveNsbsFdl];
	return [result intValue];
}

- (void)setPrimitiveNsbsFdlValue:(int)value_ {
	[self setPrimitiveNsbsFdl:[NSNumber numberWithInt:value_]];
}





@dynamic nsbsMonthlyGoal;



- (int)nsbsMonthlyGoalValue {
	NSNumber *result = [self nsbsMonthlyGoal];
	return [result intValue];
}

- (void)setNsbsMonthlyGoalValue:(int)value_ {
	[self setNsbsMonthlyGoal:[NSNumber numberWithInt:value_]];
}

- (int)primitiveNsbsMonthlyGoalValue {
	NSNumber *result = [self primitiveNsbsMonthlyGoal];
	return [result intValue];
}

- (void)setPrimitiveNsbsMonthlyGoalValue:(int)value_ {
	[self setPrimitiveNsbsMonthlyGoal:[NSNumber numberWithInt:value_]];
}





@dynamic nsbsPercentLiab;



- (short)nsbsPercentLiabValue {
	NSNumber *result = [self nsbsPercentLiab];
	return [result shortValue];
}

- (void)setNsbsPercentLiabValue:(short)value_ {
	[self setNsbsPercentLiab:[NSNumber numberWithShort:value_]];
}

- (short)primitiveNsbsPercentLiabValue {
	NSNumber *result = [self primitiveNsbsPercentLiab];
	return [result shortValue];
}

- (void)setPrimitiveNsbsPercentLiabValue:(short)value_ {
	[self setPrimitiveNsbsPercentLiab:[NSNumber numberWithShort:value_]];
}





@dynamic nsbsTotAppsPerMonth;



- (short)nsbsTotAppsPerMonthValue {
	NSNumber *result = [self nsbsTotAppsPerMonth];
	return [result shortValue];
}

- (void)setNsbsTotAppsPerMonthValue:(short)value_ {
	[self setNsbsTotAppsPerMonth:[NSNumber numberWithShort:value_]];
}

- (short)primitiveNsbsTotAppsPerMonthValue {
	NSNumber *result = [self primitiveNsbsTotAppsPerMonth];
	return [result shortValue];
}

- (void)setPrimitiveNsbsTotAppsPerMonthValue:(short)value_ {
	[self setPrimitiveNsbsTotAppsPerMonth:[NSNumber numberWithShort:value_]];
}





@dynamic rdFollowUp;



- (short)rdFollowUpValue {
	NSNumber *result = [self rdFollowUp];
	return [result shortValue];
}

- (void)setRdFollowUpValue:(short)value_ {
	[self setRdFollowUp:[NSNumber numberWithShort:value_]];
}

- (short)primitiveRdFollowUpValue {
	NSNumber *result = [self primitiveRdFollowUp];
	return [result shortValue];
}

- (void)setPrimitiveRdFollowUpValue:(short)value_ {
	[self setPrimitiveRdFollowUp:[NSNumber numberWithShort:value_]];
}





@dynamic realSubmissionDate;






@dynamic reportDate;






@dynamic uid;






@dynamic visitNumber;



- (short)visitNumberValue {
	NSNumber *result = [self visitNumber];
	return [result shortValue];
}

- (void)setVisitNumberValue:(short)value_ {
	[self setVisitNumber:[NSNumber numberWithShort:value_]];
}

- (short)primitiveVisitNumberValue {
	NSNumber *result = [self primitiveVisitNumber];
	return [result shortValue];
}

- (void)setPrimitiveVisitNumberValue:(short)value_ {
	[self setPrimitiveVisitNumber:[NSNumber numberWithShort:value_]];
}





@dynamic barriersToBusiness;

	
- (NSMutableSet*)barriersToBusinessSet {
	[self willAccessValueForKey:@"barriersToBusiness"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"barriersToBusiness"];
	[self didAccessValueForKey:@"barriersToBusiness"];
	return result;
}
	

@dynamic commissionStructure;

	

@dynamic competitors;

	
- (NSMutableSet*)competitorsSet {
	[self willAccessValueForKey:@"competitors"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"competitors"];
	[self didAccessValueForKey:@"competitors"];
	return result;
}
	

@dynamic notes;

	
- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:@"notes"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"notes"];
	[self didAccessValueForKey:@"notes"];
	return result;
}
	

@dynamic nsbsQuestions;

	
- (NSMutableSet*)nsbsQuestionsSet {
	[self willAccessValueForKey:@"nsbsQuestions"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"nsbsQuestions"];
	[self didAccessValueForKey:@"nsbsQuestions"];
	return result;
}
	

@dynamic personsSpokeWith;

	
- (NSMutableSet*)personsSpokeWithSet {
	[self willAccessValueForKey:@"personsSpokeWith"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"personsSpokeWith"];
	[self didAccessValueForKey:@"personsSpokeWith"];
	return result;
}
	

@dynamic phase;

	

@dynamic producerAddOn;

	

@dynamic producerId;

	

@dynamic purposeOfCall;

	

@dynamic reasonNotSeen;

	





@end
