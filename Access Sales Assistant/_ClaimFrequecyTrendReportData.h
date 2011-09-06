// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ClaimFrequecyTrendReportData.h instead.

#import <CoreData/CoreData.h>


@class AUNTK;




@interface ClaimFrequecyTrendReportDataID : NSManagedObjectID {}
@end

@interface _ClaimFrequecyTrendReportData : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ClaimFrequecyTrendReportDataID*)objectID;




@property (nonatomic, retain) NSString *claimsFrequency;


//- (BOOL)validateClaimsFrequency:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *monthYear;


//- (BOOL)validateMonthYear:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) AUNTK* auntk;

//- (BOOL)validateAuntk:(id*)value_ error:(NSError**)error_;




@end

@interface _ClaimFrequecyTrendReportData (CoreDataGeneratedAccessors)

@end

@interface _ClaimFrequecyTrendReportData (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveClaimsFrequency;
- (void)setPrimitiveClaimsFrequency:(NSString*)value;




- (NSString*)primitiveMonthYear;
- (void)setPrimitiveMonthYear:(NSString*)value;





- (AUNTK*)primitiveAuntk;
- (void)setPrimitiveAuntk:(AUNTK*)value;


@end
