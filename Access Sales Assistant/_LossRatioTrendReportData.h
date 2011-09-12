// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LossRatioTrendReportData.h instead.

#import <CoreData/CoreData.h>


@class AUNTK;




@interface LossRatioTrendReportDataID : NSManagedObjectID {}
@end

@interface _LossRatioTrendReportData : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LossRatioTrendReportDataID*)objectID;




@property (nonatomic, retain) NSDecimalNumber *lossRatio;


//- (BOOL)validateLossRatio:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *monthYear;


//- (BOOL)validateMonthYear:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) AUNTK* auntk;

//- (BOOL)validateAuntk:(id*)value_ error:(NSError**)error_;




@end

@interface _LossRatioTrendReportData (CoreDataGeneratedAccessors)

@end

@interface _LossRatioTrendReportData (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveLossRatio;
- (void)setPrimitiveLossRatio:(NSDecimalNumber*)value;




- (NSString*)primitiveMonthYear;
- (void)setPrimitiveMonthYear:(NSString*)value;





- (AUNTK*)primitiveAuntk;
- (void)setPrimitiveAuntk:(AUNTK*)value;


@end
