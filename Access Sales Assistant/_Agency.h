// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Agency.h instead.

#import <CoreData/CoreData.h>































@interface AgencyID : NSManagedObjectID {}
@end

@interface _Agency : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AgencyID*)objectID;



@property (nonatomic, retain) NSString *suspensionReason;

//- (BOOL)validateSuspensionReason:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *eligible;

@property BOOL eligibleValue;
- (BOOL)eligibleValue;
- (void)setEligibleValue:(BOOL)value_;

//- (BOOL)validateEligible:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *subTerritory;

//- (BOOL)validateSubTerritory:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *customerServiceEmail;

//- (BOOL)validateCustomerServiceEmail:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *numberOfEmployees;

@property short numberOfEmployeesValue;
- (short)numberOfEmployeesValue;
- (void)setNumberOfEmployeesValue:(short)value_;

//- (BOOL)validateNumberOfEmployees:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *primaryContact;

//- (BOOL)validatePrimaryContact:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *accessSign;

@property BOOL accessSignValue;
- (BOOL)accessSignValue;
- (void)setAccessSignValue:(BOOL)value_;

//- (BOOL)validateAccessSign:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *fax;

//- (BOOL)validateFax:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *howDoYouMarketYourAgency;

//- (BOOL)validateHowDoYouMarketYourAgency:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *statusDate;

//- (BOOL)validateStatusDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *agencyName;

//- (BOOL)validateAgencyName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *accountingEmail;

//- (BOOL)validateAccountingEmail:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *phone1;

//- (BOOL)validatePhone1:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *mainEmail;

//- (BOOL)validateMainEmail:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *eAndOExpires;

//- (BOOL)validateEAndOExpires:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *appointedDate;

//- (BOOL)validateAppointedDate:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *websiteAddress;

//- (BOOL)validateWebsiteAddress:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *reasonIneligible;

//- (BOOL)validateReasonIneligible:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *dateEstablished;

//- (BOOL)validateDateEstablished:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *guid;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *numberOfLocations;

@property short numberOfLocationsValue;
- (short)numberOfLocationsValue;
- (void)setNumberOfLocationsValue:(short)value_;

//- (BOOL)validateNumberOfLocations:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *rater;

//- (BOOL)validateRater:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *status;

//- (BOOL)validateStatus:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *rater2;

//- (BOOL)validateRater2:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *claimsEmail;

//- (BOOL)validateClaimsEmail:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *producerCode;

//- (BOOL)validateProducerCode:(id*)value_ error:(NSError**)error_;





@end

@interface _Agency (CoreDataGeneratedAccessors)

@end

@interface _Agency (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveSuspensionReason;
- (void)setPrimitiveSuspensionReason:(NSString*)value;




- (NSNumber*)primitiveEligible;
- (void)setPrimitiveEligible:(NSNumber*)value;

- (BOOL)primitiveEligibleValue;
- (void)setPrimitiveEligibleValue:(BOOL)value_;




- (NSString*)primitiveSubTerritory;
- (void)setPrimitiveSubTerritory:(NSString*)value;




- (NSString*)primitiveCustomerServiceEmail;
- (void)setPrimitiveCustomerServiceEmail:(NSString*)value;




- (NSNumber*)primitiveNumberOfEmployees;
- (void)setPrimitiveNumberOfEmployees:(NSNumber*)value;

- (short)primitiveNumberOfEmployeesValue;
- (void)setPrimitiveNumberOfEmployeesValue:(short)value_;




- (NSString*)primitivePrimaryContact;
- (void)setPrimitivePrimaryContact:(NSString*)value;




- (NSNumber*)primitiveAccessSign;
- (void)setPrimitiveAccessSign:(NSNumber*)value;

- (BOOL)primitiveAccessSignValue;
- (void)setPrimitiveAccessSignValue:(BOOL)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveFax;
- (void)setPrimitiveFax:(NSString*)value;




- (NSString*)primitiveHowDoYouMarketYourAgency;
- (void)setPrimitiveHowDoYouMarketYourAgency:(NSString*)value;




- (NSDate*)primitiveStatusDate;
- (void)setPrimitiveStatusDate:(NSDate*)value;




- (NSString*)primitiveAgencyName;
- (void)setPrimitiveAgencyName:(NSString*)value;




- (NSString*)primitiveAccountingEmail;
- (void)setPrimitiveAccountingEmail:(NSString*)value;




- (NSString*)primitivePhone1;
- (void)setPrimitivePhone1:(NSString*)value;




- (NSString*)primitiveMainEmail;
- (void)setPrimitiveMainEmail:(NSString*)value;




- (NSDate*)primitiveEAndOExpires;
- (void)setPrimitiveEAndOExpires:(NSDate*)value;




- (NSDate*)primitiveAppointedDate;
- (void)setPrimitiveAppointedDate:(NSDate*)value;




- (NSString*)primitiveWebsiteAddress;
- (void)setPrimitiveWebsiteAddress:(NSString*)value;




- (NSString*)primitiveReasonIneligible;
- (void)setPrimitiveReasonIneligible:(NSString*)value;




- (NSDate*)primitiveDateEstablished;
- (void)setPrimitiveDateEstablished:(NSDate*)value;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSNumber*)primitiveNumberOfLocations;
- (void)setPrimitiveNumberOfLocations:(NSNumber*)value;

- (short)primitiveNumberOfLocationsValue;
- (void)setPrimitiveNumberOfLocationsValue:(short)value_;




- (NSString*)primitiveRater;
- (void)setPrimitiveRater:(NSString*)value;




- (NSString*)primitiveStatus;
- (void)setPrimitiveStatus:(NSString*)value;




- (NSString*)primitiveRater2;
- (void)setPrimitiveRater2:(NSString*)value;




- (NSString*)primitiveClaimsEmail;
- (void)setPrimitiveClaimsEmail:(NSString*)value;




- (NSString*)primitiveProducerCode;
- (void)setPrimitiveProducerCode:(NSString*)value;




@end
