// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TrainingVideo.m instead.

#import "_TrainingVideo.h"

@implementation TrainingVideoID
@end

@implementation _TrainingVideo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TrainingVideo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TrainingVideo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TrainingVideo" inManagedObjectContext:moc_];
}

- (TrainingVideoID*)objectID {
	return (TrainingVideoID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic Title;






@dynamic URL;










@end
