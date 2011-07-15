// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Phase.h instead.

#import <CoreData/CoreData.h>


@class DailySummary;




@interface PhaseID : NSManagedObjectID {}
@end

@interface _Phase : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PhaseID*)objectID;



@property (nonatomic, retain) NSNumber *uid;

@property short uidValue;
- (short)uidValue;
- (void)setUidValue:(short)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* dailySummary;
- (NSMutableSet*)dailySummarySet;




@end

@interface _Phase (CoreDataGeneratedAccessors)

- (void)addDailySummary:(NSSet*)value_;
- (void)removeDailySummary:(NSSet*)value_;
- (void)addDailySummaryObject:(DailySummary*)value_;
- (void)removeDailySummaryObject:(DailySummary*)value_;

@end

@interface _Phase (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (short)primitiveUidValue;
- (void)setPrimitiveUidValue:(short)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveDailySummary;
- (void)setPrimitiveDailySummary:(NSMutableSet*)value;


@end
