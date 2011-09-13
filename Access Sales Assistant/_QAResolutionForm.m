// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to QAResolutionForm.m instead.

#import "_QAResolutionForm.h"

@implementation QAResolutionFormID
@end

@implementation _QAResolutionForm

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"QAResolutionForm" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"QAResolutionForm";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"QAResolutionForm" inManagedObjectContext:moc_];
}

- (QAResolutionFormID*)objectID {
	return (QAResolutionFormID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic descp;






@dynamic policyNumber;






@dynamic producerCode;






@dynamic request;










@end
