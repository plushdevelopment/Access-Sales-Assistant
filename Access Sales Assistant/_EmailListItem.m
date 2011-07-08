// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EmailListItem.m instead.

#import "_EmailListItem.h"

@implementation EmailListItemID
@end

@implementation _EmailListItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EmailListItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EmailListItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EmailListItem" inManagedObjectContext:moc_];
}

- (EmailListItemID*)objectID {
	return (EmailListItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"typeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"type"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic address;






@dynamic type;



- (short)typeValue {
	NSNumber *result = [self type];
	return [result shortValue];
}

- (void)setTypeValue:(short)value_ {
	[self setType:[NSNumber numberWithShort:value_]];
}

- (short)primitiveTypeValue {
	NSNumber *result = [self primitiveType];
	return [result shortValue];
}

- (void)setPrimitiveTypeValue:(short)value_ {
	[self setPrimitiveType:[NSNumber numberWithShort:value_]];
}





@dynamic guid;






@dynamic producer;

	

@dynamic contact;

	





@end
