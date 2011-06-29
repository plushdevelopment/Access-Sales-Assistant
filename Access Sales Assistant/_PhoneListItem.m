// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PhoneListItem.m instead.

#import "_PhoneListItem.h"

@implementation PhoneListItemID
@end

@implementation _PhoneListItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PhoneListItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PhoneListItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PhoneListItem" inManagedObjectContext:moc_];
}

- (PhoneListItemID*)objectID {
	return (PhoneListItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"typeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"type"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic number;






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






@dynamic updatedBy;






@dynamic updatedDtm;






@dynamic createdDtm;






@dynamic createdBy;






@dynamic producer;

	

@dynamic contact;

	





@end
