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
	
	if ([key isEqualToString:@"countValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"count"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic count;



- (int)countValue {
	NSNumber *result = [self count];
	return [result intValue];
}

- (void)setCountValue:(int)value_ {
	[self setCount:[NSNumber numberWithInt:value_]];
}

- (int)primitiveCountValue {
	NSNumber *result = [self primitiveCount];
	return [result intValue];
}

- (void)setPrimitiveCountValue:(int)value_ {
	[self setPrimitiveCount:[NSNumber numberWithInt:value_]];
}





@dynamic header;






@dynamic auntk;

	





@end
