// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PolicyCountReportData.m instead.

#import "_PolicyCountReportData.h"

@implementation PolicyCountReportDataID
@end

@implementation _PolicyCountReportData

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PolicyCountReportData" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PolicyCountReportData";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PolicyCountReportData" inManagedObjectContext:moc_];
}

- (PolicyCountReportDataID*)objectID {
	return (PolicyCountReportDataID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"orderValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"order"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic count;






@dynamic header;






@dynamic order;



- (short)orderValue {
	NSNumber *result = [self order];
	return [result shortValue];
}

- (void)setOrderValue:(short)value_ {
	[self setOrder:[NSNumber numberWithShort:value_]];
}

- (short)primitiveOrderValue {
	NSNumber *result = [self primitiveOrder];
	return [result shortValue];
}

- (void)setPrimitiveOrderValue:(short)value_ {
	[self setPrimitiveOrder:[NSNumber numberWithShort:value_]];
}





@dynamic auntk;

	





@end
