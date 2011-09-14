// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to QAResolutionForm.h instead.

#import <CoreData/CoreData.h>








@interface QAResolutionFormID : NSManagedObjectID {}
@end

@interface _QAResolutionForm : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (QAResolutionFormID*)objectID;




@property (nonatomic, retain) NSString *descp;


//- (BOOL)validateDescp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *policyNumber;


//- (BOOL)validatePolicyNumber:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *producerCode;


//- (BOOL)validateProducerCode:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *request;


//- (BOOL)validateRequest:(id*)value_ error:(NSError**)error_;





@end

@interface _QAResolutionForm (CoreDataGeneratedAccessors)

@end

@interface _QAResolutionForm (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDescp;
- (void)setPrimitiveDescp:(NSString*)value;




- (NSString*)primitivePolicyNumber;
- (void)setPrimitivePolicyNumber:(NSString*)value;




- (NSString*)primitiveProducerCode;
- (void)setPrimitiveProducerCode:(NSString*)value;




- (NSString*)primitiveRequest;
- (void)setPrimitiveRequest:(NSString*)value;




@end
