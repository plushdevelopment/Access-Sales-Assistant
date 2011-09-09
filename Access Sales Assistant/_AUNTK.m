// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AUNTK.m instead.

#import "_AUNTK.h"

@implementation AUNTKID
@end

@implementation _AUNTK

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AUNTK" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AUNTK";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AUNTK" inManagedObjectContext:moc_];
}

- (AUNTKID*)objectID {
	return (AUNTKID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic key;






@dynamic chainProducer;

	

@dynamic claimFrequecyTrendReportData;

	
- (NSMutableSet*)claimFrequecyTrendReportDataSet {
	[self willAccessValueForKey:@"claimFrequecyTrendReportData"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"claimFrequecyTrendReportData"];
	[self didAccessValueForKey:@"claimFrequecyTrendReportData"];
	return result;
}
	

@dynamic lossRatioTrendReportData;

	
- (NSMutableSet*)lossRatioTrendReportDataSet {
	[self willAccessValueForKey:@"lossRatioTrendReportData"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"lossRatioTrendReportData"];
	[self didAccessValueForKey:@"lossRatioTrendReportData"];
	return result;
}
	

@dynamic policyCountReportData;

	
- (NSMutableSet*)policyCountReportDataSet {
	[self willAccessValueForKey:@"policyCountReportData"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"policyCountReportData"];
	[self didAccessValueForKey:@"policyCountReportData"];
	return result;
}
	

@dynamic producer;

	

@dynamic productionReportData;

	
- (NSMutableSet*)productionReportDataSet {
	[self willAccessValueForKey:@"productionReportData"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"productionReportData"];
	[self didAccessValueForKey:@"productionReportData"];
	return result;
}
	





@end
