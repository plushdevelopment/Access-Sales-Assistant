// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ClaimFrequecyTrendReportData.m instead.

#import "_ClaimFrequecyTrendReportData.h"

@implementation ClaimFrequecyTrendReportDataID
@end

@implementation _ClaimFrequecyTrendReportData

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ClaimFrequecyTrendReportData" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ClaimFrequecyTrendReportData";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ClaimFrequecyTrendReportData" inManagedObjectContext:moc_];
}

- (ClaimFrequecyTrendReportDataID*)objectID {
	return (ClaimFrequecyTrendReportDataID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic claimsFrequency;






@dynamic monthYear;






@dynamic auntk;

	





@end
