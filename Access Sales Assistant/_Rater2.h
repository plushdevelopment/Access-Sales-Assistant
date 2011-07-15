// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Rater2.h instead.

#import <CoreData/CoreData.h>


@class Producer;




@interface Rater2ID : NSManagedObjectID {}
@end

@interface _Rater2 : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (Rater2ID*)objectID;



@property (nonatomic, retain) NSNumber *uid;

@property short uidValue;
- (short)uidValue;
- (void)setUidValue:(short)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* producer;
- (NSMutableSet*)producerSet;




@end

@interface _Rater2 (CoreDataGeneratedAccessors)

- (void)addProducer:(NSSet*)value_;
- (void)removeProducer:(NSSet*)value_;
- (void)addProducerObject:(Producer*)value_;
- (void)removeProducerObject:(Producer*)value_;

@end

@interface _Rater2 (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (short)primitiveUidValue;
- (void)setPrimitiveUidValue:(short)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveProducer;
- (void)setPrimitiveProducer:(NSMutableSet*)value;


@end
