// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to QuestionListItem.m instead.

#import "_QuestionListItem.h"

@implementation QuestionListItemID
@end

@implementation _QuestionListItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"QuestionListItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"QuestionListItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"QuestionListItem" inManagedObjectContext:moc_];
}

- (QuestionListItemID*)objectID {
	return (QuestionListItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic answer;






@dynamic guid;






@dynamic text;






@dynamic producers;

	
- (NSMutableSet*)producersSet {
	[self willAccessValueForKey:@"producers"];
	NSMutableSet *result = [self mutableSetValueForKey:@"producers"];
	[self didAccessValueForKey:@"producers"];
	return result;
}
	





@end
