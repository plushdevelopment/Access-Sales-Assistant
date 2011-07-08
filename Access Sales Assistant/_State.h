// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to State.h instead.

#import <CoreData/CoreData.h>


@class AddressListItem;




@interface StateID : NSManagedObjectID {}
@end

@interface _State : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (StateID*)objectID;



@property (nonatomic, retain) NSNumber *guid;

@property short guidValue;
- (short)guidValue;
- (void)setGuidValue:(short)value_;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* addresses;
- (NSMutableSet*)addressesSet;




@end

@interface _State (CoreDataGeneratedAccessors)

- (void)addAddresses:(NSSet*)value_;
- (void)removeAddresses:(NSSet*)value_;
- (void)addAddressesObject:(AddressListItem*)value_;
- (void)removeAddressesObject:(AddressListItem*)value_;

@end

@interface _State (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveGuid;
- (void)setPrimitiveGuid:(NSNumber*)value;

- (short)primitiveGuidValue;
- (void)setPrimitiveGuidValue:(short)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveAddresses;
- (void)setPrimitiveAddresses:(NSMutableSet*)value;


@end
