// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AUNTK.h instead.

#import <CoreData/CoreData.h>


@class Producer;
@class ClaimFrequecyTrendReportData;
@class LossRatioTrendReportData;
@class PolicyCountReportData;
@class Producer;
@class ProductionReportData;



@interface AUNTKID : NSManagedObjectID {}
@end

@interface _AUNTK : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AUNTKID*)objectID;




@property (nonatomic, retain) NSString *key;


//- (BOOL)validateKey:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) Producer* chainProducer;

//- (BOOL)validateChainProducer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* claimFrequecyTrendReportData;

- (NSMutableSet*)claimFrequecyTrendReportDataSet;




@property (nonatomic, retain) NSSet* lossRatioTrendReportData;

- (NSMutableSet*)lossRatioTrendReportDataSet;




@property (nonatomic, retain) NSSet* policyCountReportData;

- (NSMutableSet*)policyCountReportDataSet;




@property (nonatomic, retain) Producer* producer;

//- (BOOL)validateProducer:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* productionReportData;

- (NSMutableSet*)productionReportDataSet;




@end

@interface _AUNTK (CoreDataGeneratedAccessors)

- (void)addClaimFrequecyTrendReportData:(NSSet*)value_;
- (void)removeClaimFrequecyTrendReportData:(NSSet*)value_;
- (void)addClaimFrequecyTrendReportDataObject:(ClaimFrequecyTrendReportData*)value_;
- (void)removeClaimFrequecyTrendReportDataObject:(ClaimFrequecyTrendReportData*)value_;

- (void)addLossRatioTrendReportData:(NSSet*)value_;
- (void)removeLossRatioTrendReportData:(NSSet*)value_;
- (void)addLossRatioTrendReportDataObject:(LossRatioTrendReportData*)value_;
- (void)removeLossRatioTrendReportDataObject:(LossRatioTrendReportData*)value_;

- (void)addPolicyCountReportData:(NSSet*)value_;
- (void)removePolicyCountReportData:(NSSet*)value_;
- (void)addPolicyCountReportDataObject:(PolicyCountReportData*)value_;
- (void)removePolicyCountReportDataObject:(PolicyCountReportData*)value_;

- (void)addProductionReportData:(NSSet*)value_;
- (void)removeProductionReportData:(NSSet*)value_;
- (void)addProductionReportDataObject:(ProductionReportData*)value_;
- (void)removeProductionReportDataObject:(ProductionReportData*)value_;

@end

@interface _AUNTK (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveKey;
- (void)setPrimitiveKey:(NSString*)value;





- (Producer*)primitiveChainProducer;
- (void)setPrimitiveChainProducer:(Producer*)value;



- (NSMutableSet*)primitiveClaimFrequecyTrendReportData;
- (void)setPrimitiveClaimFrequecyTrendReportData:(NSMutableSet*)value;



- (NSMutableSet*)primitiveLossRatioTrendReportData;
- (void)setPrimitiveLossRatioTrendReportData:(NSMutableSet*)value;



- (NSMutableSet*)primitivePolicyCountReportData;
- (void)setPrimitivePolicyCountReportData:(NSMutableSet*)value;



- (Producer*)primitiveProducer;
- (void)setPrimitiveProducer:(Producer*)value;



- (NSMutableSet*)primitiveProductionReportData;
- (void)setPrimitiveProductionReportData:(NSMutableSet*)value;


@end
