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



@property (nonatomic, retain) NSNumber *guid;

@property short guidValue;
- (short)guidValue;
- (void)setGuidValue:(short)value_;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




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


- (NSNumber*)primitiveGuid;
- (void)setPrimitiveGuid:(NSNumber*)value;

- (short)primitiveGuidValue;
- (void)setPrimitiveGuidValue:(short)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveProducer;
- (void)setPrimitiveProducer:(NSMutableSet*)value;


@end
