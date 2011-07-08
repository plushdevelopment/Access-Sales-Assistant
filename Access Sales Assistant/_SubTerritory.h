// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SubTerritory.h instead.

#import <CoreData/CoreData.h>


@class Producer;



@interface SubTerritoryID : NSManagedObjectID {}
@end

@interface _SubTerritory : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SubTerritoryID*)objectID;



@property (nonatomic, retain) NSNumber *guid;

@property short guidValue;
- (short)guidValue;
- (void)setGuidValue:(short)value_;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* producers;
- (NSMutableSet*)producersSet;




@end

@interface _SubTerritory (CoreDataGeneratedAccessors)

- (void)addProducers:(NSSet*)value_;
- (void)removeProducers:(NSSet*)value_;
- (void)addProducersObject:(Producer*)value_;
- (void)removeProducersObject:(Producer*)value_;

@end

@interface _SubTerritory (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveGuid;
- (void)setPrimitiveGuid:(NSNumber*)value;

- (short)primitiveGuidValue;
- (void)setPrimitiveGuidValue:(short)value_;





- (NSMutableSet*)primitiveProducers;
- (void)setPrimitiveProducers:(NSMutableSet*)value;


@end
