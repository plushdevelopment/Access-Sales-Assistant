// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Rater.h instead.

#import <CoreData/CoreData.h>


@class Producer;








@interface RaterID : NSManagedObjectID {}
@end

@interface _Rater : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RaterID*)objectID;



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




@property (nonatomic, retain) Producer* producer;
//- (BOOL)validateProducer:(id*)value_ error:(NSError**)error_;




@end

@interface _Rater (CoreDataGeneratedAccessors)

@end

@interface _Rater (CoreDataGeneratedPrimitiveAccessors)


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





- (Producer*)primitiveProducer;
- (void)setPrimitiveProducer:(Producer*)value;


@end
