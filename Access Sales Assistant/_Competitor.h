// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Competitor.h instead.

#import <CoreData/CoreData.h>


@class DailySummary;







@interface CompetitorID : NSManagedObjectID {}
@end

@interface _Competitor : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CompetitorID*)objectID;




@property (nonatomic, retain) NSNumber *appsPerMonth;


@property short appsPerMonthValue;
- (short)appsPerMonthValue;
- (void)setAppsPerMonthValue:(short)value_;

//- (BOOL)validateAppsPerMonth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *deleted;


@property BOOL deletedValue;
- (BOOL)deletedValue;
- (void)setDeletedValue:(BOOL)value_;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *edited;


@property BOOL editedValue;
- (BOOL)editedValue;
- (void)setEditedValue:(BOOL)value_;

//- (BOOL)validateEdited:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *uid;


//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* dailySummaries;

- (NSMutableSet*)dailySummariesSet;




@end

@interface _Competitor (CoreDataGeneratedAccessors)

- (void)addDailySummaries:(NSSet*)value_;
- (void)removeDailySummaries:(NSSet*)value_;
- (void)addDailySummariesObject:(DailySummary*)value_;
- (void)removeDailySummariesObject:(DailySummary*)value_;

@end

@interface _Competitor (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAppsPerMonth;
- (void)setPrimitiveAppsPerMonth:(NSNumber*)value;

- (short)primitiveAppsPerMonthValue;
- (void)setPrimitiveAppsPerMonthValue:(short)value_;




- (NSNumber*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSNumber*)value;

- (BOOL)primitiveDeletedValue;
- (void)setPrimitiveDeletedValue:(BOOL)value_;




- (NSNumber*)primitiveEdited;
- (void)setPrimitiveEdited:(NSNumber*)value;

- (BOOL)primitiveEditedValue;
- (void)setPrimitiveEditedValue:(BOOL)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveUid;
- (void)setPrimitiveUid:(NSString*)value;





- (NSMutableSet*)primitiveDailySummaries;
- (void)setPrimitiveDailySummaries:(NSMutableSet*)value;


@end
