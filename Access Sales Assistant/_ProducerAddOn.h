// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ProducerAddOn.h instead.

#import <CoreData/CoreData.h>


@class DailySummary;




@interface ProducerAddOnID : NSManagedObjectID {}
@end

@interface _ProducerAddOn : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ProducerAddOnID*)objectID;



@property (nonatomic, retain) NSNumber *uid;

@property short uidValue;
- (short)uidValue;
- (void)setUidValue:(short)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* dailySummaries;
- (NSMutableSet*)dailySummariesSet;




@end

@interface _ProducerAddOn (CoreDataGeneratedAccessors)

- (void)addDailySummaries:(NSSet*)value_;
- (void)removeDailySummaries:(NSSet*)value_;
- (void)addDailySummariesObject:(DailySummary*)value_;
- (void)removeDailySummariesObject:(DailySummary*)value_;

@end

@interface _ProducerAddOn (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (short)primitiveUidValue;
- (void)setPrimitiveUidValue:(short)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveDailySummaries;
- (void)setPrimitiveDailySummaries:(NSMutableSet*)value;


@end
