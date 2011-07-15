// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Producer.h instead.

#import <CoreData/CoreData.h>


@class SubTerritory;
@class DailySummary;
@class Rater2;
@class Contact;
@class SuspensionReason;
@class IneligibleReason;
@class QuestionListItem;
@class HoursOfOperation;
@class AddressListItem;
@class EmailListItem;
@class PhoneListItem;
@class Rater;
@class Status;
















@interface ProducerID : NSManagedObjectID {}
@end

@interface _Producer : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ProducerID*)objectID;



@property (nonatomic, retain) NSDate *eAndOExpires;

//- (BOOL)validateEAndOExpires:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *uid;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *edited;

@property BOOL editedValue;
- (BOOL)editedValue;
- (void)setEditedValue:(BOOL)value_;

//- (BOOL)validateEdited:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *dateEstablished;

//- (BOOL)validateDateEstablished:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *isEligible;

@property BOOL isEligibleValue;
- (BOOL)isEligibleValue;
- (void)setIsEligibleValue:(BOOL)value_;

//- (BOOL)validateIsEligible:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *hasAccessSign;

@property BOOL hasAccessSignValue;
- (BOOL)hasAccessSignValue;
- (void)setHasAccessSignValue:(BOOL)value_;

//- (BOOL)validateHasAccessSign:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *producerCode;

//- (BOOL)validateProducerCode:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *statusDate;

//- (BOOL)validateStatusDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *primaryContact;

//- (BOOL)validatePrimaryContact:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *webAddress;

//- (BOOL)validateWebAddress:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *numberOfLocations;

@property short numberOfLocationsValue;
- (short)numberOfLocationsValue;
- (void)setNumberOfLocationsValue:(short)value_;

//- (BOOL)validateNumberOfLocations:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *appointedDate;

//- (BOOL)validateAppointedDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *numberOfEmployees;

@property short numberOfEmployeesValue;
- (short)numberOfEmployeesValue;
- (void)setNumberOfEmployeesValue:(short)value_;

//- (BOOL)validateNumberOfEmployees:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) SubTerritory* subTerritory;
//- (BOOL)validateSubTerritory:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) DailySummary* dailySummary;
//- (BOOL)validateDailySummary:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Rater2* rater2;
//- (BOOL)validateRater2:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* contacts;
- (NSMutableSet*)contactsSet;



@property (nonatomic, retain) SuspensionReason* suspensionReason;
//- (BOOL)validateSuspensionReason:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) IneligibleReason* ineligibleReason;
//- (BOOL)validateIneligibleReason:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* questions;
- (NSMutableSet*)questionsSet;



@property (nonatomic, retain) HoursOfOperation* hoursOfOperation;
//- (BOOL)validateHoursOfOperation:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* addresses;
- (NSMutableSet*)addressesSet;



@property (nonatomic, retain) NSSet* emails;
- (NSMutableSet*)emailsSet;



@property (nonatomic, retain) NSSet* phoneNumbers;
- (NSMutableSet*)phoneNumbersSet;



@property (nonatomic, retain) Rater* rater;
//- (BOOL)validateRater:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Status* status;
//- (BOOL)validateStatus:(id*)value_ error:(NSError**)error_;




@end

@interface _Producer (CoreDataGeneratedAccessors)

- (void)addContacts:(NSSet*)value_;
- (void)removeContacts:(NSSet*)value_;
- (void)addContactsObject:(Contact*)value_;
- (void)removeContactsObject:(Contact*)value_;

- (void)addQuestions:(NSSet*)value_;
- (void)removeQuestions:(NSSet*)value_;
- (void)addQuestionsObject:(QuestionListItem*)value_;
- (void)removeQuestionsObject:(QuestionListItem*)value_;

- (void)addAddresses:(NSSet*)value_;
- (void)removeAddresses:(NSSet*)value_;
- (void)addAddressesObject:(AddressListItem*)value_;
- (void)removeAddressesObject:(AddressListItem*)value_;

- (void)addEmails:(NSSet*)value_;
- (void)removeEmails:(NSSet*)value_;
- (void)addEmailsObject:(EmailListItem*)value_;
- (void)removeEmailsObject:(EmailListItem*)value_;

- (void)addPhoneNumbers:(NSSet*)value_;
- (void)removePhoneNumbers:(NSSet*)value_;
- (void)addPhoneNumbersObject:(PhoneListItem*)value_;
- (void)removePhoneNumbersObject:(PhoneListItem*)value_;

@end

@interface _Producer (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveEAndOExpires;
- (void)setPrimitiveEAndOExpires:(NSDate*)value;




- (NSString*)primitiveUid;
- (void)setPrimitiveUid:(NSString*)value;




- (NSNumber*)primitiveEdited;
- (void)setPrimitiveEdited:(NSNumber*)value;

- (BOOL)primitiveEditedValue;
- (void)setPrimitiveEditedValue:(BOOL)value_;




- (NSDate*)primitiveDateEstablished;
- (void)setPrimitiveDateEstablished:(NSDate*)value;




- (NSNumber*)primitiveIsEligible;
- (void)setPrimitiveIsEligible:(NSNumber*)value;

- (BOOL)primitiveIsEligibleValue;
- (void)setPrimitiveIsEligibleValue:(BOOL)value_;




- (NSNumber*)primitiveHasAccessSign;
- (void)setPrimitiveHasAccessSign:(NSNumber*)value;

- (BOOL)primitiveHasAccessSignValue;
- (void)setPrimitiveHasAccessSignValue:(BOOL)value_;




- (NSString*)primitiveProducerCode;
- (void)setPrimitiveProducerCode:(NSString*)value;




- (NSDate*)primitiveStatusDate;
- (void)setPrimitiveStatusDate:(NSDate*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePrimaryContact;
- (void)setPrimitivePrimaryContact:(NSString*)value;




- (NSString*)primitiveWebAddress;
- (void)setPrimitiveWebAddress:(NSString*)value;




- (NSNumber*)primitiveNumberOfLocations;
- (void)setPrimitiveNumberOfLocations:(NSNumber*)value;

- (short)primitiveNumberOfLocationsValue;
- (void)setPrimitiveNumberOfLocationsValue:(short)value_;




- (NSDate*)primitiveAppointedDate;
- (void)setPrimitiveAppointedDate:(NSDate*)value;




- (NSNumber*)primitiveNumberOfEmployees;
- (void)setPrimitiveNumberOfEmployees:(NSNumber*)value;

- (short)primitiveNumberOfEmployeesValue;
- (void)setPrimitiveNumberOfEmployeesValue:(short)value_;





- (SubTerritory*)primitiveSubTerritory;
- (void)setPrimitiveSubTerritory:(SubTerritory*)value;



- (DailySummary*)primitiveDailySummary;
- (void)setPrimitiveDailySummary:(DailySummary*)value;



- (Rater2*)primitiveRater2;
- (void)setPrimitiveRater2:(Rater2*)value;



- (NSMutableSet*)primitiveContacts;
- (void)setPrimitiveContacts:(NSMutableSet*)value;



- (SuspensionReason*)primitiveSuspensionReason;
- (void)setPrimitiveSuspensionReason:(SuspensionReason*)value;



- (IneligibleReason*)primitiveIneligibleReason;
- (void)setPrimitiveIneligibleReason:(IneligibleReason*)value;



- (NSMutableSet*)primitiveQuestions;
- (void)setPrimitiveQuestions:(NSMutableSet*)value;



- (HoursOfOperation*)primitiveHoursOfOperation;
- (void)setPrimitiveHoursOfOperation:(HoursOfOperation*)value;



- (NSMutableSet*)primitiveAddresses;
- (void)setPrimitiveAddresses:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEmails;
- (void)setPrimitiveEmails:(NSMutableSet*)value;



- (NSMutableSet*)primitivePhoneNumbers;
- (void)setPrimitivePhoneNumbers:(NSMutableSet*)value;



- (Rater*)primitiveRater;
- (void)setPrimitiveRater:(Rater*)value;



- (Status*)primitiveStatus;
- (void)setPrimitiveStatus:(Status*)value;


@end
