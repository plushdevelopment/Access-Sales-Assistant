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




@property (nonatomic, retain) NSNumber *edited;


@property BOOL editedValue;
- (BOOL)editedValue;
- (void)setEditedValue:(BOOL)value_;

//- (BOOL)validateEdited:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *firstName;


//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *lastName;


//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *producerId;


//- (BOOL)validateProducerId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *rdFollowUp;


@property BOOL rdFollowUpValue;
- (BOOL)rdFollowUpValue;
- (void)setRdFollowUpValue:(BOOL)value_;

//- (BOOL)validateRdFollowUp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *ssn;


//- (BOOL)validateSsn:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *uid;


//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* emails;

- (NSMutableSet*)emailsSet;




@property (nonatomic, retain) NSSet* phoneNumbers;

- (NSMutableSet*)phoneNumbersSet;




@property (nonatomic, retain) Producer* producer;

//- (BOOL)validateProducer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) ContactType* type;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;




@end

@interface _Contact (CoreDataGeneratedAccessors)

- (void)addEmails:(NSSet*)value_;
- (void)removeEmails:(NSSet*)value_;
- (void)addEmailsObject:(EmailListItem*)value_;
- (void)removeEmailsObject:(EmailListItem*)value_;

- (void)addPhoneNumbers:(NSSet*)value_;
- (void)removePhoneNumbers:(NSSet*)value_;
- (void)addPhoneNumbersObject:(PhoneListItem*)value_;
- (void)removePhoneNumbersObject:(PhoneListItem*)value_;

@end

@interface _Contact (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveEdited;
- (void)setPrimitiveEdited:(NSNumber*)value;

- (BOOL)primitiveEditedValue;
- (void)setPrimitiveEditedValue:(BOOL)value_;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSString*)primitiveProducerId;
- (void)setPrimitiveProducerId:(NSString*)value;




- (NSNumber*)primitiveRdFollowUp;
- (void)setPrimitiveRdFollowUp:(NSNumber*)value;

- (BOOL)primitiveRdFollowUpValue;
- (void)setPrimitiveRdFollowUpValue:(BOOL)value_;




- (NSString*)primitiveSsn;
- (void)setPrimitiveSsn:(NSString*)value;




- (NSString*)primitiveUid;
- (void)setPrimitiveUid:(NSString*)value;





- (NSMutableSet*)primitiveEmails;
- (void)setPrimitiveEmails:(NSMutableSet*)value;



- (NSMutableSet*)primitivePhoneNumbers;
- (void)setPrimitivePhoneNumbers:(NSMutableSet*)value;



- (Producer*)primitiveProducer;
- (void)setPrimitiveProducer:(Producer*)value;



- (ContactType*)primitiveType;
- (void)setPrimitiveType:(ContactType*)value;


@end
