// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ProducerImage.m instead.

#import "_ProducerImage.h"

@implementation ProducerImageID
@end

@implementation _ProducerImage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ProducerImage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ProducerImage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ProducerImage" inManagedObjectContext:moc_];
}

- (ProducerImageID*)objectID {
	return (ProducerImageID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic imageName;






@dynamic imagePath;






@dynamic producer;

	





@end
