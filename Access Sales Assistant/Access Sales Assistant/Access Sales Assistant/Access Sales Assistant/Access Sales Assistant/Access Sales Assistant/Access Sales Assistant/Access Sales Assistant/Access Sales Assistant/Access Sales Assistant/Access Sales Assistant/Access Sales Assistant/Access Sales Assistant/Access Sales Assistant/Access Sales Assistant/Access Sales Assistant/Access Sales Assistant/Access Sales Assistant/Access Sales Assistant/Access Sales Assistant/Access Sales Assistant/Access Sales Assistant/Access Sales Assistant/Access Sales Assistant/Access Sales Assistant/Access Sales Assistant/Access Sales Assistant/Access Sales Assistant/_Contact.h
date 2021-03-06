// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.h instead.

#import <CoreData/CoreData.h>


@class EmailListItem;
@class PhoneListItem;
@class Producer;
@class ContactType;







@interface ContactID : NSManagedObjectID {}
@end

@interface _Contact : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ContactID*)objectID;




@property (nonatomic, retain) NSString *firstName;


//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *lastName;


//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *rdFollowUp;


@property BOOL rdFollowUpValue;
- (BOOL)rdFollowUpValue;
- (void)setRdFollowUpValue:(BOOL)value_;

//- (BOOL)validateRdFollowUp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *ssn;


//- (BOOL)validateSsn:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *uid;


//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* emailList;

- (NSMutableSet*)emailListSet;




@property (nonatomic, retain) NSSet* phoneList;

- (NSMutableSet*)phoneListSet;




@property (nonatomic, retain) Producer* producer;

//- (BOOL)validateProducer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) ContactType* type;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;




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


- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSNumber*)primitiveRdFollowUp;
- (void)setPrimitiveRdFollowUp:(NSNumber*)value;

- (BOOL)primitiveRdFollowUpValue;
- (void)setPrimitiveRdFollowUpValue:(BOOL)value_;




- (NSString*)primitiveSsn;
- (void)setPrimitiveSsn:(NSString*)value;




- (NSString*)primitiveUid;
- (void)setPrimitiveUid:(NSString*)value;





- (NSMutableSet*)primitiveEmailList;
- (void)setPrimitiveEmailList:(NSMutableSet*)value;



- (NSMutableSet*)primitivePhoneList;
- (void)setPrimitivePhoneList:(NSMutableSet*)value;



- (Producer*)primitiveProducer;
- (void)setPrimitiveProducer:(Producer*)value;



- (ContactType*)primitiveType;
- (void)setPrimitiveType:(ContactType*)value;


@end
