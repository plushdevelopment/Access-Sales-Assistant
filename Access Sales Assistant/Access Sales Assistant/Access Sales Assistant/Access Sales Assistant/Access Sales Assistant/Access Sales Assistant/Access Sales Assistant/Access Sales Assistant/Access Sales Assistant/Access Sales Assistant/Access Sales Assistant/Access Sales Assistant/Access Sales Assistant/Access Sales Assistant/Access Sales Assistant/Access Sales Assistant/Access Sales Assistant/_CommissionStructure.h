// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CommissionStructure.h instead.

#import <CoreData/CoreData.h>


@class DailySummary;




@interface CommissionStructureID : NSManagedObjectID {}
@end

@interface _CommissionStructure : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CommissionStructureID*)objectID;




@property (nonatomic, retain) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *uid;


@property short uidValue;
- (short)uidValue;
- (void)setUidValue:(short)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* dailySummaries;

- (NSMutableSet*)dailySummariesSet;




@end

@interface _CommissionStructure (CoreDataGeneratedAccessors)

- (void)addDailySummaries:(NSSet*)value_;
- (void)removeDailySummaries:(NSSet*)value_;
- (void)addDailySummariesObject:(DailySummary*)value_;
- (void)removeDailySummariesObject:(DailySummary*)value_;

@end

@interface _CommissionStructure (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (short)primitiveUidValue;
- (void)setPrimitiveUidValue:(short)value_;





- (NSMutableSet*)primitiveDailySummaries;
- (void)setPrimitiveDailySummaries:(NSMutableSet*)value;


@end
