// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SuspensionReason.h instead.

#import <CoreData/CoreData.h>


@class Producer;




@interface SuspensionReasonID : NSManagedObjectID {}
@end

@interface _SuspensionReason : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SuspensionReasonID*)objectID;



@property (nonatomic, retain) NSString *guid;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* producers;
- (NSMutableSet*)producersSet;




@end

@interface _SuspensionReason (CoreDataGeneratedAccessors)

- (void)addProducers:(NSSet*)value_;
- (void)removeProducers:(NSSet*)value_;
- (void)addProducersObject:(Producer*)value_;
- (void)removeProducersObject:(Producer*)value_;

@end

@interface _SuspensionReason (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveProducers;
- (void)setPrimitiveProducers:(NSMutableSet*)value;


@end
