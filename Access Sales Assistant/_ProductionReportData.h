// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ProductionReportData.h instead.

#import <CoreData/CoreData.h>


@class AUNTK;






















@interface ProductionReportDataID : NSManagedObjectID {}
@end

@interface _ProductionReportData : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ProductionReportDataID*)objectID;




@property (nonatomic, retain) NSNumber *avgCarsDriver;


@property float avgCarsDriverValue;
- (float)avgCarsDriverValue;
- (void)setAvgCarsDriverValue:(float)value_;

//- (BOOL)validateAvgCarsDriver:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *avgDriverAge;


@property int avgDriverAgeValue;
- (int)avgDriverAgeValue;
- (void)setAvgDriverAgeValue:(int)value_;

//- (BOOL)validateAvgDriverAge:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *avgIncLossITD;


@property int avgIncLossITDValue;
- (int)avgIncLossITDValue;
- (void)setAvgIncLossITDValue:(int)value_;

//- (BOOL)validateAvgIncLossITD:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *avgWPITD;


@property int avgWPITDValue;
- (int)avgWPITDValue;
- (void)setAvgWPITDValue:(int)value_;

//- (BOOL)validateAvgWPITD:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *cancel30dMonth;


@property int cancel30dMonthValue;
- (int)cancel30dMonthValue;
- (void)setCancel30dMonthValue:(int)value_;

//- (BOOL)validateCancel30dMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *currentPoliciesMonth;


@property int currentPoliciesMonthValue;
- (int)currentPoliciesMonthValue;
- (void)setCurrentPoliciesMonthValue:(int)value_;

//- (BOOL)validateCurrentPoliciesMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *epTotalITD;


@property int epTotalITDValue;
- (int)epTotalITDValue;
- (void)setEpTotalITDValue:(int)value_;

//- (BOOL)validateEpTotalITD:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *frequencyITD;


@property float frequencyITDValue;
- (float)frequencyITDValue;
- (void)setFrequencyITDValue:(float)value_;

//- (BOOL)validateFrequencyITD:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *lrTotalITD;


@property float lrTotalITDValue;
- (float)lrTotalITDValue;
- (void)setLrTotalITDValue:(float)value_;

//- (BOOL)validateLrTotalITD:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *month;


//- (BOOL)validateMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSDate *monthEndDate;


//- (BOOL)validateMonthEndDate:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *nbrClaims30dMonth;


@property int nbrClaims30dMonthValue;
- (int)nbrClaims30dMonthValue;
- (void)setNbrClaims30dMonthValue:(int)value_;

//- (BOOL)validateNbrClaims30dMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *nbrClaimsITD;


@property int nbrClaimsITDValue;
- (int)nbrClaimsITDValue;
- (void)setNbrClaimsITDValue:(int)value_;

//- (BOOL)validateNbrClaimsITD:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *nbrClaimsMonth;


@property int nbrClaimsMonthValue;
- (int)nbrClaimsMonthValue;
- (void)setNbrClaimsMonthValue:(int)value_;

//- (BOOL)validateNbrClaimsMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *percentFDLMonth;


@property short percentFDLMonthValue;
- (short)percentFDLMonthValue;
- (void)setPercentFDLMonthValue:(short)value_;

//- (BOOL)validatePercentFDLMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *percentLiabilityOnlyITD;


@property short percentLiabilityOnlyITDValue;
- (short)percentLiabilityOnlyITDValue;
- (void)setPercentLiabilityOnlyITDValue:(short)value_;

//- (BOOL)validatePercentLiabilityOnlyITD:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *policiesInForce;


@property int policiesInForceValue;
- (int)policiesInForceValue;
- (void)setPoliciesInForceValue:(int)value_;

//- (BOOL)validatePoliciesInForce:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *policiesWrittenITD;


@property int policiesWrittenITDValue;
- (int)policiesWrittenITDValue;
- (void)setPoliciesWrittenITDValue:(int)value_;

//- (BOOL)validatePoliciesWrittenITD:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *wpTotalITD;


@property int wpTotalITDValue;
- (int)wpTotalITDValue;
- (void)setWpTotalITDValue:(int)value_;

//- (BOOL)validateWpTotalITD:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *year;


@property short yearValue;
- (short)yearValue;
- (void)setYearValue:(short)value_;

//- (BOOL)validateYear:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) AUNTK* auntk;

//- (BOOL)validateAuntk:(id*)value_ error:(NSError**)error_;




@end

@interface _ProductionReportData (CoreDataGeneratedAccessors)

@end

@interface _ProductionReportData (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAvgCarsDriver;
- (void)setPrimitiveAvgCarsDriver:(NSNumber*)value;

- (float)primitiveAvgCarsDriverValue;
- (void)setPrimitiveAvgCarsDriverValue:(float)value_;




- (NSNumber*)primitiveAvgDriverAge;
- (void)setPrimitiveAvgDriverAge:(NSNumber*)value;

- (int)primitiveAvgDriverAgeValue;
- (void)setPrimitiveAvgDriverAgeValue:(int)value_;




- (NSNumber*)primitiveAvgIncLossITD;
- (void)setPrimitiveAvgIncLossITD:(NSNumber*)value;

- (int)primitiveAvgIncLossITDValue;
- (void)setPrimitiveAvgIncLossITDValue:(int)value_;




- (NSNumber*)primitiveAvgWPITD;
- (void)setPrimitiveAvgWPITD:(NSNumber*)value;

- (int)primitiveAvgWPITDValue;
- (void)setPrimitiveAvgWPITDValue:(int)value_;




- (NSNumber*)primitiveCancel30dMonth;
- (void)setPrimitiveCancel30dMonth:(NSNumber*)value;

- (int)primitiveCancel30dMonthValue;
- (void)setPrimitiveCancel30dMonthValue:(int)value_;




- (NSNumber*)primitiveCurrentPoliciesMonth;
- (void)setPrimitiveCurrentPoliciesMonth:(NSNumber*)value;

- (int)primitiveCurrentPoliciesMonthValue;
- (void)setPrimitiveCurrentPoliciesMonthValue:(int)value_;




- (NSNumber*)primitiveEpTotalITD;
- (void)setPrimitiveEpTotalITD:(NSNumber*)value;

- (int)primitiveEpTotalITDValue;
- (void)setPrimitiveEpTotalITDValue:(int)value_;




- (NSNumber*)primitiveFrequencyITD;
- (void)setPrimitiveFrequencyITD:(NSNumber*)value;

- (float)primitiveFrequencyITDValue;
- (void)setPrimitiveFrequencyITDValue:(float)value_;




- (NSNumber*)primitiveLrTotalITD;
- (void)setPrimitiveLrTotalITD:(NSNumber*)value;

- (float)primitiveLrTotalITDValue;
- (void)setPrimitiveLrTotalITDValue:(float)value_;




- (NSString*)primitiveMonth;
- (void)setPrimitiveMonth:(NSString*)value;




- (NSDate*)primitiveMonthEndDate;
- (void)setPrimitiveMonthEndDate:(NSDate*)value;




- (NSNumber*)primitiveNbrClaims30dMonth;
- (void)setPrimitiveNbrClaims30dMonth:(NSNumber*)value;

- (int)primitiveNbrClaims30dMonthValue;
- (void)setPrimitiveNbrClaims30dMonthValue:(int)value_;




- (NSNumber*)primitiveNbrClaimsITD;
- (void)setPrimitiveNbrClaimsITD:(NSNumber*)value;

- (int)primitiveNbrClaimsITDValue;
- (void)setPrimitiveNbrClaimsITDValue:(int)value_;




- (NSNumber*)primitiveNbrClaimsMonth;
- (void)setPrimitiveNbrClaimsMonth:(NSNumber*)value;

- (int)primitiveNbrClaimsMonthValue;
- (void)setPrimitiveNbrClaimsMonthValue:(int)value_;




- (NSNumber*)primitivePercentFDLMonth;
- (void)setPrimitivePercentFDLMonth:(NSNumber*)value;

- (short)primitivePercentFDLMonthValue;
- (void)setPrimitivePercentFDLMonthValue:(short)value_;




- (NSNumber*)primitivePercentLiabilityOnlyITD;
- (void)setPrimitivePercentLiabilityOnlyITD:(NSNumber*)value;

- (short)primitivePercentLiabilityOnlyITDValue;
- (void)setPrimitivePercentLiabilityOnlyITDValue:(short)value_;




- (NSNumber*)primitivePoliciesInForce;
- (void)setPrimitivePoliciesInForce:(NSNumber*)value;

- (int)primitivePoliciesInForceValue;
- (void)setPrimitivePoliciesInForceValue:(int)value_;




- (NSNumber*)primitivePoliciesWrittenITD;
- (void)setPrimitivePoliciesWrittenITD:(NSNumber*)value;

- (int)primitivePoliciesWrittenITDValue;
- (void)setPrimitivePoliciesWrittenITDValue:(int)value_;




- (NSNumber*)primitiveWpTotalITD;
- (void)setPrimitiveWpTotalITD:(NSNumber*)value;

- (int)primitiveWpTotalITDValue;
- (void)setPrimitiveWpTotalITDValue:(int)value_;




- (NSNumber*)primitiveYear;
- (void)setPrimitiveYear:(NSNumber*)value;

- (short)primitiveYearValue;
- (void)setPrimitiveYearValue:(short)value_;





- (AUNTK*)primitiveAuntk;
- (void)setPrimitiveAuntk:(AUNTK*)value;


@end
