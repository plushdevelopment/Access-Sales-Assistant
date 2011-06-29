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



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *updatedBy;

//- (BOOL)validateUpdatedBy:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *guid;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *createdDtm;

//- (BOOL)validateCreatedDtm:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *createdBy;

//- (BOOL)validateCreatedBy:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *updatedDtm;

//- (BOOL)validateUpdatedDtm:(id*)value_ error:(NSError**)error_;




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


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveUpdatedBy;
- (void)setPrimitiveUpdatedBy:(NSString*)value;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSDate*)primitiveCreatedDtm;
- (void)setPrimitiveCreatedDtm:(NSDate*)value;




- (NSString*)primitiveCreatedBy;
- (void)setPrimitiveCreatedBy:(NSString*)value;




- (NSDate*)primitiveUpdatedDtm;
- (void)setPrimitiveUpdatedDtm:(NSDate*)value;





- (NSMutableSet*)primitiveAddresses;
- (void)setPrimitiveAddresses:(NSMutableSet*)value;


@end
