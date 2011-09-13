// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to QAForm.h instead.

#import <CoreData/CoreData.h>








@interface QAFormID : NSManagedObjectID {}
@end

@interface _QAForm : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (QAFormID*)objectID;




@property (nonatomic, retain) NSString *Description;


//- (BOOL)validateDescription:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *PolicyNumber;


//- (BOOL)validatePolicyNumber:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *ProducerCode;


//- (BOOL)validateProducerCode:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *Request;


//- (BOOL)validateRequest:(id*)value_ error:(NSError**)error_;





@end

@interface _QAForm (CoreDataGeneratedAccessors)

@end

@interface _QAForm (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDescription;
- (void)setPrimitiveDescription:(NSString*)value;




- (NSString*)primitivePolicyNumber;
- (void)setPrimitivePolicyNumber:(NSString*)value;




- (NSString*)primitiveProducerCode;
- (void)setPrimitiveProducerCode:(NSString*)value;




- (NSString*)primitiveRequest;
- (void)setPrimitiveRequest:(NSString*)value;




@end
