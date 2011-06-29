// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IneligibleReason.h instead.

#import <CoreData/CoreData.h>


@class Producer;








@interface IneligibleReasonID : NSManagedObjectID {}
@end

@interface _IneligibleReason : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (IneligibleReasonID*)objectID;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *updatedBy;

//- (BOOL)validateUpdatedBy:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *guid;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *createdDtm;

//- (BOOL)validateCreatedDtm:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *createdBy;

//- (BOOL)validateCreatedBy:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *updatedDtm;

//- (BOOL)validateUpdatedDtm:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* producer;
- (NSMutableSet*)producerSet;




@end

@interface _IneligibleReason (CoreDataGeneratedAccessors)

- (void)addProducer:(NSSet*)value_;
- (void)removeProducer:(NSSet*)value_;
- (void)addProducerObject:(Producer*)value_;
- (void)removeProducerObject:(Producer*)value_;

@end

@interface _IneligibleReason (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveUpdatedBy;
- (void)setPrimitiveUpdatedBy:(NSString*)value;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSDate*)primitiveCreatedDtm;
- (void)setPrimitiveCreatedDtm:(NSDate*)value;




- (NSString*)primitiveCreatedBy;
- (void)setPrimitiveCreatedBy:(NSString*)value;




- (NSDate*)primitiveUpdatedDtm;
- (void)setPrimitiveUpdatedDtm:(NSDate*)value;





- (NSMutableSet*)primitiveProducer;
- (void)setPrimitiveProducer:(NSMutableSet*)value;


@end
