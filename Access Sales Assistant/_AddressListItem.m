// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AddressListItem.m instead.

#import "_AddressListItem.h"

@implementation AddressListItemID
@end

@implementation _AddressListItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AddressListItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AddressListItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AddressListItem" inManagedObjectContext:moc_];
}

- (AddressListItemID*)objectID {
	return (AddressListItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"addressTypeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"addressType"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic addressType;



- (short)addressTypeValue {
	NSNumber *result = [self addressType];
	return [result shortValue];
}

- (void)setAddressTypeValue:(short)value_ {
	[self setAddressType:[NSNumber numberWithShort:value_]];
}

- (short)primitiveAddressTypeValue {
	NSNumber *result = [self primitiveAddressType];
	return [result shortValue];
}

- (void)setPrimitiveAddressTypeValue:(short)value_ {
	[self setPrimitiveAddressType:[NSNumber numberWithShort:value_]];
}





@dynamic postalCode;






@dynamic city;






@dynamic addressLine1;






@dynamic longitude;



- (double)longitudeValue {
	NSNumber *result = [self longitude];
	return [result doubleValue];
}

- (void)setLongitudeValue:(double)value_ {
	[self setLongitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result doubleValue];
}

- (void)setPrimitiveLongitudeValue:(double)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithDouble:value_]];
}





@dynamic latitude;



- (double)latitudeValue {
	NSNumber *result = [self latitude];
	return [result doubleValue];
}

- (void)setLatitudeValue:(double)value_ {
	[self setLatitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result doubleValue];
}

- (void)setPrimitiveLatitudeValue:(double)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithDouble:value_]];
}





@dynamic addressLine2;






@dynamic addressLine3;






@dynamic producer;

	

@dynamic state;

	





@end
