// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to QAForm.m instead.

#import "_QAForm.h"

@implementation QAFormID
@end

@implementation _QAForm

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"QAForm" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"QAForm";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"QAForm" inManagedObjectContext:moc_];
}

- (QAFormID*)objectID {
	return (QAFormID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic Description;






@dynamic PolicyNumber;






@dynamic ProducerCode;






@dynamic Request;










@end
