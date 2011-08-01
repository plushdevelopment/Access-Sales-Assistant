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




@property (nonatomic, retain) NSNumber *uid;


@property short uidValue;
- (short)uidValue;
- (void)setUidValue:(short)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





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




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (short)primitiveUidValue;
- (void)setPrimitiveUidValue:(short)value_;





- (NSMutableSet*)primitiveProducer;
- (void)setPrimitiveProducer:(NSMutableSet*)value;


@end
