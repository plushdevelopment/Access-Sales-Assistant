// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DailySummary.h instead.

#import <CoreData/CoreData.h>


@class BarrierToBusiness;
@class CommissionStructure;
@class Competitor;
@class Note;
@class QuestionListItem;
@class PersonSpokeWith;
@class Phase;
@class ProducerAddOn;
@class Producer;
@class PurposeOfCall;
@class ReasonNotSeen;















@interface DailySummaryID : NSManagedObjectID {}
@end

@interface _DailySummary : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (DailySummaryID*)objectID;




@property (nonatomic, retain) NSNumber *commissionPercentNew;


@property short commissionPercentNewValue;
- (short)commissionPercentNewValue;
- (void)setCommissionPercentNewValue:(short)value_;

//- (BOOL)validateCommissionPercentNew:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *commissionPercentRenewal;


@property short commissionPercentRenewalValue;
- (short)commissionPercentRenewalValue;
- (void)setCommissionPercentRenewalValue:(short)value_;

//- (BOOL)validateCommissionPercentRenewal:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *deleted;


@property BOOL deletedValue;
- (BOOL)deletedValue;
- (void)setDeletedValue:(BOOL)value_;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *edited;


@property BOOL editedValue;
- (BOOL)editedValue;
- (void)setEditedValue:(BOOL)value_;

//- (BOOL)validateEdited:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *nsbsFdl;


@property int nsbsFdlValue;
- (int)nsbsFdlValue;
- (void)setNsbsFdlValue:(int)value_;

//- (BOOL)validateNsbsFdl:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *nsbsMonthlyGoal;


@property int nsbsMonthlyGoalValue;
- (int)nsbsMonthlyGoalValue;
- (void)setNsbsMonthlyGoalValue:(int)value_;

//- (BOOL)validateNsbsMonthlyGoal:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *nsbsPercentLiab;


@property short nsbsPercentLiabValue;
- (short)nsbsPercentLiabValue;
- (void)setNsbsPercentLiabValue:(short)value_;

//- (BOOL)validateNsbsPercentLiab:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *nsbsTotAppsPerMonth;


@property short nsbsTotAppsPerMonthValue;
- (short)nsbsTotAppsPerMonthValue;
- (void)setNsbsTotAppsPerMonthValue:(short)value_;

//- (BOOL)validateNsbsTotAppsPerMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *rdFollowUp;


@property short rdFollowUpValue;
- (short)rdFollowUpValue;
- (void)setRdFollowUpValue:(short)value_;

//- (BOOL)validateRdFollowUp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSDate *realSubmissionDate;


//- (BOOL)validateRealSubmissionDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSDate *reportDate;


//- (BOOL)validateReportDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *uid;


//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *visitNumber;


@property short visitNumberValue;
- (short)visitNumberValue;
- (void)setVisitNumberValue:(short)value_;

//- (BOOL)validateVisitNumber:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* barriersToBusiness;

- (NSMutableSet*)barriersToBusinessSet;




@property (nonatomic, retain) CommissionStructure* commissionStructure;

//- (BOOL)validateCommissionStructure:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* competitors;

- (NSMutableSet*)competitorsSet;




@property (nonatomic, retain) NSSet* notes;

- (NSMutableSet*)notesSet;




@property (nonatomic, retain) NSSet* nsbsQuestions;

- (NSMutableSet*)nsbsQuestionsSet;




@property (nonatomic, retain) NSSet* personsSpokeWith;

- (NSMutableSet*)personsSpokeWithSet;




@property (nonatomic, retain) Phase* phase;

//- (BOOL)validatePhase:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) ProducerAddOn* producerAddOn;

//- (BOOL)validateProducerAddOn:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Producer* producerId;

//- (BOOL)validateProducerId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) PurposeOfCall* purposeOfCall;

//- (BOOL)validatePurposeOfCall:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) ReasonNotSeen* reasonNotSeen;

//- (BOOL)validateReasonNotSeen:(id*)value_ error:(NSError**)error_;




@end

@interface _DailySummary (CoreDataGeneratedAccessors)

- (void)addBarriersToBusiness:(NSSet*)value_;
- (void)removeBarriersToBusiness:(NSSet*)value_;
- (void)addBarriersToBusinessObject:(BarrierToBusiness*)value_;
- (void)removeBarriersToBusinessObject:(BarrierToBusiness*)value_;

- (void)addCompetitors:(NSSet*)value_;
- (void)removeCompetitors:(NSSet*)value_;
- (void)addCompetitorsObject:(Competitor*)value_;
- (void)removeCompetitorsObject:(Competitor*)value_;

- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(Note*)value_;
- (void)removeNotesObject:(Note*)value_;

- (void)addNsbsQuestions:(NSSet*)value_;
- (void)removeNsbsQuestions:(NSSet*)value_;
- (void)addNsbsQuestionsObject:(QuestionListItem*)value_;
- (void)removeNsbsQuestionsObject:(QuestionListItem*)value_;

- (void)addPersonsSpokeWith:(NSSet*)value_;
- (void)removePersonsSpokeWith:(NSSet*)value_;
- (void)addPersonsSpokeWithObject:(PersonSpokeWith*)value_;
- (void)removePersonsSpokeWithObject:(PersonSpokeWith*)value_;

@end

@interface _DailySummary (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCommissionPercentNew;
- (void)setPrimitiveCommissionPercentNew:(NSNumber*)value;

- (short)primitiveCommissionPercentNewValue;
- (void)setPrimitiveCommissionPercentNewValue:(short)value_;




- (NSNumber*)primitiveCommissionPercentRenewal;
- (void)setPrimitiveCommissionPercentRenewal:(NSNumber*)value;

- (short)primitiveCommissionPercentRenewalValue;
- (void)setPrimitiveCommissionPercentRenewalValue:(short)value_;




- (NSNumber*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSNumber*)value;

- (BOOL)primitiveDeletedValue;
- (void)setPrimitiveDeletedValue:(BOOL)value_;




- (NSNumber*)primitiveEdited;
- (void)setPrimitiveEdited:(NSNumber*)value;

- (BOOL)primitiveEditedValue;
- (void)setPrimitiveEditedValue:(BOOL)value_;




- (NSNumber*)primitiveNsbsFdl;
- (void)setPrimitiveNsbsFdl:(NSNumber*)value;

- (int)primitiveNsbsFdlValue;
- (void)setPrimitiveNsbsFdlValue:(int)value_;




- (NSNumber*)primitiveNsbsMonthlyGoal;
- (void)setPrimitiveNsbsMonthlyGoal:(NSNumber*)value;

- (int)primitiveNsbsMonthlyGoalValue;
- (void)setPrimitiveNsbsMonthlyGoalValue:(int)value_;




- (NSNumber*)primitiveNsbsPercentLiab;
- (void)setPrimitiveNsbsPercentLiab:(NSNumber*)value;

- (short)primitiveNsbsPercentLiabValue;
- (void)setPrimitiveNsbsPercentLiabValue:(short)value_;




- (NSNumber*)primitiveNsbsTotAppsPerMonth;
- (void)setPrimitiveNsbsTotAppsPerMonth:(NSNumber*)value;

- (short)primitiveNsbsTotAppsPerMonthValue;
- (void)setPrimitiveNsbsTotAppsPerMonthValue:(short)value_;




- (NSNumber*)primitiveRdFollowUp;
- (void)setPrimitiveRdFollowUp:(NSNumber*)value;

- (short)primitiveRdFollowUpValue;
- (void)setPrimitiveRdFollowUpValue:(short)value_;




- (NSDate*)primitiveRealSubmissionDate;
- (void)setPrimitiveRealSubmissionDate:(NSDate*)value;




- (NSDate*)primitiveReportDate;
- (void)setPrimitiveReportDate:(NSDate*)value;




- (NSString*)primitiveUid;
- (void)setPrimitiveUid:(NSString*)value;




- (NSNumber*)primitiveVisitNumber;
- (void)setPrimitiveVisitNumber:(NSNumber*)value;

- (short)primitiveVisitNumberValue;
- (void)setPrimitiveVisitNumberValue:(short)value_;





- (NSMutableSet*)primitiveBarriersToBusiness;
- (void)setPrimitiveBarriersToBusiness:(NSMutableSet*)value;



- (CommissionStructure*)primitiveCommissionStructure;
- (void)setPrimitiveCommissionStructure:(CommissionStructure*)value;



- (NSMutableSet*)primitiveCompetitors;
- (void)setPrimitiveCompetitors:(NSMutableSet*)value;



- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;



- (NSMutableSet*)primitiveNsbsQuestions;
- (void)setPrimitiveNsbsQuestions:(NSMutableSet*)value;



- (NSMutableSet*)primitivePersonsSpokeWith;
- (void)setPrimitivePersonsSpokeWith:(NSMutableSet*)value;



- (Phase*)primitivePhase;
- (void)setPrimitivePhase:(Phase*)value;



- (ProducerAddOn*)primitiveProducerAddOn;
- (void)setPrimitiveProducerAddOn:(ProducerAddOn*)value;



- (Producer*)primitiveProducerId;
- (void)setPrimitiveProducerId:(Producer*)value;



- (PurposeOfCall*)primitivePurposeOfCall;
- (void)setPrimitivePurposeOfCall:(PurposeOfCall*)value;



- (ReasonNotSeen*)primitiveReasonNotSeen;
- (void)setPrimitiveReasonNotSeen:(ReasonNotSeen*)value;


@end
