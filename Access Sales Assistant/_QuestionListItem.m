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
	
	if ([key isEqualToString:@"deletedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"deleted"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"editedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"edited"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic answer;






@dynamic deleted;



- (BOOL)deletedValue {
	NSNumber *result = [self deleted];
	return [result boolValue];
}

- (void)setDeletedValue:(BOOL)value_ {
	[self setDeleted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveDeletedValue {
	NSNumber *result = [self primitiveDeleted];
	return [result boolValue];
}

- (void)setPrimitiveDeletedValue:(BOOL)value_ {
	[self setPrimitiveDeleted:[NSNumber numberWithBool:value_]];
}





@dynamic edited;



- (BOOL)editedValue {
	NSNumber *result = [self edited];
	return [result boolValue];
}

- (void)setEditedValue:(BOOL)value_ {
	[self setEdited:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveEditedValue {
	NSNumber *result = [self primitiveEdited];
	return [result boolValue];
}

- (void)setPrimitiveEditedValue:(BOOL)value_ {
	[self setPrimitiveEdited:[NSNumber numberWithBool:value_]];
}





@dynamic text;






@dynamic dailySummaries;

	
- (NSMutableSet*)dailySummariesSet {
	[self willAccessValueForKey:@"dailySummaries"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"dailySummaries"];
	[self didAccessValueForKey:@"dailySummaries"];
	return result;
}
	

@dynamic producer;

	





@end
