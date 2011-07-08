// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AddressListItem.h instead.

#import <CoreData/CoreData.h>


@class Producer;
@class State;











@interface AddressListItemID : NSManagedObjectID {}
@end

@interface _AddressListItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AddressListItemID*)objectID;



@property (nonatomic, retain) NSNumber *addressType;

@property short addressTypeValue;
- (short)addressTypeValue;
- (void)setAddressTypeValue:(short)value_;

//- (BOOL)validateAddressType:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *postalCode;

//- (BOOL)validatePostalCode:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *guid;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *city;

//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *addressLine1;

//- (BOOL)validateAddressLine1:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *longitude;

@property double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *latitude;

@property double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *addressLine3;

//- (BOOL)validateAddressLine3:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *addressLine2;

//- (BOOL)validateAddressLine2:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Producer* producer;
//- (BOOL)validateProducer:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) State* state;
//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;




@end

@interface _AddressListItem (CoreDataGeneratedAccessors)

@end

@interface _AddressListItem (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAddressType;
- (void)setPrimitiveAddressType:(NSNumber*)value;

- (short)primitiveAddressTypeValue;
- (void)setPrimitiveAddressTypeValue:(short)value_;




- (NSString*)primitivePostalCode;
- (void)setPrimitivePostalCode:(NSString*)value;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSString*)primitiveAddressLine1;
- (void)setPrimitiveAddressLine1:(NSString*)value;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;




- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;




- (NSString*)primitiveAddressLine3;
- (void)setPrimitiveAddressLine3:(NSString*)value;




- (NSString*)primitiveAddressLine2;
- (void)setPrimitiveAddressLine2:(NSString*)value;





- (Producer*)primitiveProducer;
- (void)setPrimitiveProducer:(Producer*)value;



- (State*)primitiveState;
- (void)setPrimitiveState:(State*)value;


@end
