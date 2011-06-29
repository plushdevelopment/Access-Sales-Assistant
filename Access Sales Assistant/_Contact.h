// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.h instead.

#import <CoreData/CoreData.h>


@class Type;
@class EmailListItem;
@class Producer;
@class PhoneListItem;










@interface ContactID : NSManagedObjectID {}
@end

@interface _Contact : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ContactID*)objectID;



@property (nonatomic, retain) NSString *createdBy;

//- (BOOL)validateCreatedBy:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *lastName;

//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *guid;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *firstName;

//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *updatedBy;

//- (BOOL)validateUpdatedBy:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *ssn;

//- (BOOL)validateSsn:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *updatedDtm;

//- (BOOL)validateUpdatedDtm:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *createdDtm;

//- (BOOL)validateCreatedDtm:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Type* type;
//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* emailList;
- (NSMutableSet*)emailListSet;



@property (nonatomic, retain) Producer* producer;
//- (BOOL)validateProducer:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* phoneList;
- (NSMutableSet*)phoneListSet;




@end

@interface _Contact (CoreDataGeneratedAccessors)

- (void)addEmailList:(NSSet*)value_;
- (void)removeEmailList:(NSSet*)value_;
- (void)addEmailListObject:(EmailListItem*)value_;
- (void)removeEmailListObject:(EmailListItem*)value_;

- (void)addPhoneList:(NSSet*)value_;
- (void)removePhoneList:(NSSet*)value_;
- (void)addPhoneListObject:(PhoneListItem*)value_;
- (void)removePhoneListObject:(PhoneListItem*)value_;

@end

@interface _Contact (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCreatedBy;
- (void)setPrimitiveCreatedBy:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveUpdatedBy;
- (void)setPrimitiveUpdatedBy:(NSString*)value;




- (NSString*)primitiveSsn;
- (void)setPrimitiveSsn:(NSString*)value;




- (NSDate*)primitiveUpdatedDtm;
- (void)setPrimitiveUpdatedDtm:(NSDate*)value;




- (NSDate*)primitiveCreatedDtm;
- (void)setPrimitiveCreatedDtm:(NSDate*)value;





- (Type*)primitiveType;
- (void)setPrimitiveType:(Type*)value;



- (NSMutableSet*)primitiveEmailList;
- (void)setPrimitiveEmailList:(NSMutableSet*)value;



- (Producer*)primitiveProducer;
- (void)setPrimitiveProducer:(Producer*)value;



- (NSMutableSet*)primitivePhoneList;
- (void)setPrimitivePhoneList:(NSMutableSet*)value;


@end
