// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LossRatioTrendReportData.m instead.

#import "_LossRatioTrendReportData.h"

@implementation LossRatioTrendReportDataID
@end

@implementation _LossRatioTrendReportData

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LossRatioTrendReportData" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"LossRatioTrendReportData";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"LossRatioTrendReportData" inManagedObjectContext:moc_];
}

- (LossRatioTrendReportDataID*)objectID {
	return (LossRatioTrendReportDataID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic lossRatio;






@dynamic monthYear;






@dynamic auntk;

	





@end
