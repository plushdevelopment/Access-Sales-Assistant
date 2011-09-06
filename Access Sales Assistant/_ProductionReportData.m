// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ProductionReportData.m instead.

#import "_ProductionReportData.h"

@implementation ProductionReportDataID
@end

@implementation _ProductionReportData

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ProductionReportData" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ProductionReportData";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ProductionReportData" inManagedObjectContext:moc_];
}

- (ProductionReportDataID*)objectID {
	return (ProductionReportDataID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"avgCarsDriverValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"avgCarsDriver"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"avgDriverAgeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"avgDriverAge"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"avgIncLossITDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"avgIncLossITD"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"avgWPITDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"avgWPITD"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"epTotalITDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"epTotalITD"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"frequencyITDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"frequencyITD"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"nbrClaims30dMonthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nbrClaims30dMonth"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"nbrClaimsITDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nbrClaimsITD"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"nbrClaimsMonthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"nbrClaimsMonth"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"newPoliciesMonthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"newPoliciesMonth"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"policiesInForceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"policiesInForce"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"policiesWrittenITDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"policiesWrittenITD"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"wpTotalITDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"wpTotalITD"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"yearValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"year"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic avgCarsDriver;



- (float)avgCarsDriverValue {
	NSNumber *result = [self avgCarsDriver];
	return [result floatValue];
}

- (void)setAvgCarsDriverValue:(float)value_ {
	[self setAvgCarsDriver:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveAvgCarsDriverValue {
	NSNumber *result = [self primitiveAvgCarsDriver];
	return [result floatValue];
}

- (void)setPrimitiveAvgCarsDriverValue:(float)value_ {
	[self setPrimitiveAvgCarsDriver:[NSNumber numberWithFloat:value_]];
}





@dynamic avgDriverAge;



- (int)avgDriverAgeValue {
	NSNumber *result = [self avgDriverAge];
	return [result intValue];
}

- (void)setAvgDriverAgeValue:(int)value_ {
	[self setAvgDriverAge:[NSNumber numberWithInt:value_]];
}

- (int)primitiveAvgDriverAgeValue {
	NSNumber *result = [self primitiveAvgDriverAge];
	return [result intValue];
}

- (void)setPrimitiveAvgDriverAgeValue:(int)value_ {
	[self setPrimitiveAvgDriverAge:[NSNumber numberWithInt:value_]];
}





@dynamic avgIncLossITD;



- (int)avgIncLossITDValue {
	NSNumber *result = [self avgIncLossITD];
	return [result intValue];
}

- (void)setAvgIncLossITDValue:(int)value_ {
	[self setAvgIncLossITD:[NSNumber numberWithInt:value_]];
}

- (int)primitiveAvgIncLossITDValue {
	NSNumber *result = [self primitiveAvgIncLossITD];
	return [result intValue];
}

- (void)setPrimitiveAvgIncLossITDValue:(int)value_ {
	[self setPrimitiveAvgIncLossITD:[NSNumber numberWithInt:value_]];
}





@dynamic avgWPITD;



- (int)avgWPITDValue {
	NSNumber *result = [self avgWPITD];
	return [result intValue];
}

- (void)setAvgWPITDValue:(int)value_ {
	[self setAvgWPITD:[NSNumber numberWithInt:value_]];
}

- (int)primitiveAvgWPITDValue {
	NSNumber *result = [self primitiveAvgWPITD];
	return [result intValue];
}

- (void)setPrimitiveAvgWPITDValue:(int)value_ {
	[self setPrimitiveAvgWPITD:[NSNumber numberWithInt:value_]];
}





@dynamic cancel30dMonth;






@dynamic epTotalITD;



- (int)epTotalITDValue {
	NSNumber *result = [self epTotalITD];
	return [result intValue];
}

- (void)setEpTotalITDValue:(int)value_ {
	[self setEpTotalITD:[NSNumber numberWithInt:value_]];
}

- (int)primitiveEpTotalITDValue {
	NSNumber *result = [self primitiveEpTotalITD];
	return [result intValue];
}

- (void)setPrimitiveEpTotalITDValue:(int)value_ {
	[self setPrimitiveEpTotalITD:[NSNumber numberWithInt:value_]];
}





@dynamic frequencyITD;



- (float)frequencyITDValue {
	NSNumber *result = [self frequencyITD];
	return [result floatValue];
}

- (void)setFrequencyITDValue:(float)value_ {
	[self setFrequencyITD:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveFrequencyITDValue {
	NSNumber *result = [self primitiveFrequencyITD];
	return [result floatValue];
}

- (void)setPrimitiveFrequencyITDValue:(float)value_ {
	[self setPrimitiveFrequencyITD:[NSNumber numberWithFloat:value_]];
}





@dynamic lrTotalITD;






@dynamic month;






@dynamic monthEndDate;






@dynamic nbrClaims30dMonth;



- (int)nbrClaims30dMonthValue {
	NSNumber *result = [self nbrClaims30dMonth];
	return [result intValue];
}

- (void)setNbrClaims30dMonthValue:(int)value_ {
	[self setNbrClaims30dMonth:[NSNumber numberWithInt:value_]];
}

- (int)primitiveNbrClaims30dMonthValue {
	NSNumber *result = [self primitiveNbrClaims30dMonth];
	return [result intValue];
}

- (void)setPrimitiveNbrClaims30dMonthValue:(int)value_ {
	[self setPrimitiveNbrClaims30dMonth:[NSNumber numberWithInt:value_]];
}





@dynamic nbrClaimsITD;



- (int)nbrClaimsITDValue {
	NSNumber *result = [self nbrClaimsITD];
	return [result intValue];
}

- (void)setNbrClaimsITDValue:(int)value_ {
	[self setNbrClaimsITD:[NSNumber numberWithInt:value_]];
}

- (int)primitiveNbrClaimsITDValue {
	NSNumber *result = [self primitiveNbrClaimsITD];
	return [result intValue];
}

- (void)setPrimitiveNbrClaimsITDValue:(int)value_ {
	[self setPrimitiveNbrClaimsITD:[NSNumber numberWithInt:value_]];
}





@dynamic nbrClaimsMonth;



- (int)nbrClaimsMonthValue {
	NSNumber *result = [self nbrClaimsMonth];
	return [result intValue];
}

- (void)setNbrClaimsMonthValue:(int)value_ {
	[self setNbrClaimsMonth:[NSNumber numberWithInt:value_]];
}

- (int)primitiveNbrClaimsMonthValue {
	NSNumber *result = [self primitiveNbrClaimsMonth];
	return [result intValue];
}

- (void)setPrimitiveNbrClaimsMonthValue:(int)value_ {
	[self setPrimitiveNbrClaimsMonth:[NSNumber numberWithInt:value_]];
}





@dynamic newPoliciesMonth;



- (int)newPoliciesMonthValue {
	NSNumber *result = [self newPoliciesMonth];
	return [result intValue];
}

- (void)setNewPoliciesMonthValue:(int)value_ {
	[self setNewPoliciesMonth:[NSNumber numberWithInt:value_]];
}

- (int)primitiveNewPoliciesMonthValue {
	NSNumber *result = [self primitiveNewPoliciesMonth];
	return [result intValue];
}

- (void)setPrimitiveNewPoliciesMonthValue:(int)value_ {
	[self setPrimitiveNewPoliciesMonth:[NSNumber numberWithInt:value_]];
}





@dynamic percentFDLMonth;






@dynamic percentLiabilityOnlyITD;






@dynamic policiesInForce;



- (int)policiesInForceValue {
	NSNumber *result = [self policiesInForce];
	return [result intValue];
}

- (void)setPoliciesInForceValue:(int)value_ {
	[self setPoliciesInForce:[NSNumber numberWithInt:value_]];
}

- (int)primitivePoliciesInForceValue {
	NSNumber *result = [self primitivePoliciesInForce];
	return [result intValue];
}

- (void)setPrimitivePoliciesInForceValue:(int)value_ {
	[self setPrimitivePoliciesInForce:[NSNumber numberWithInt:value_]];
}





@dynamic policiesWrittenITD;



- (int)policiesWrittenITDValue {
	NSNumber *result = [self policiesWrittenITD];
	return [result intValue];
}

- (void)setPoliciesWrittenITDValue:(int)value_ {
	[self setPoliciesWrittenITD:[NSNumber numberWithInt:value_]];
}

- (int)primitivePoliciesWrittenITDValue {
	NSNumber *result = [self primitivePoliciesWrittenITD];
	return [result intValue];
}

- (void)setPrimitivePoliciesWrittenITDValue:(int)value_ {
	[self setPrimitivePoliciesWrittenITD:[NSNumber numberWithInt:value_]];
}





@dynamic wpTotalITD;



- (int)wpTotalITDValue {
	NSNumber *result = [self wpTotalITD];
	return [result intValue];
}

- (void)setWpTotalITDValue:(int)value_ {
	[self setWpTotalITD:[NSNumber numberWithInt:value_]];
}

- (int)primitiveWpTotalITDValue {
	NSNumber *result = [self primitiveWpTotalITD];
	return [result intValue];
}

- (void)setPrimitiveWpTotalITDValue:(int)value_ {
	[self setPrimitiveWpTotalITD:[NSNumber numberWithInt:value_]];
}





@dynamic year;



- (short)yearValue {
	NSNumber *result = [self year];
	return [result shortValue];
}

- (void)setYearValue:(short)value_ {
	[self setYear:[NSNumber numberWithShort:value_]];
}

- (short)primitiveYearValue {
	NSNumber *result = [self primitiveYear];
	return [result shortValue];
}

- (void)setPrimitiveYearValue:(short)value_ {
	[self setPrimitiveYear:[NSNumber numberWithShort:value_]];
}





@dynamic auntk;

	





@end
