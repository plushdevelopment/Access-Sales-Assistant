// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to QuestionListItem.h instead.

#import <CoreData/CoreData.h>


@class DailySummary;
@class Producer;






@interface QuestionListItemID : NSManagedObjectID {}
@end

@interface _QuestionListItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (QuestionListItemID*)objectID;




@property (nonatomic, retain) NSString *answer;


//- (BOOL)validateAnswer:(id*)value_ error:(NSError**)error_;




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




@property (nonatomic, retain) NSString *text;


//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* dailySummaries;

- (NSMutableSet*)dailySummariesSet;




@property (nonatomic, retain) NSSet* producers;

- (NSMutableSet*)producersSet;




@end

@interface _QuestionListItem (CoreDataGeneratedAccessors)

- (void)addDailySummaries:(NSSet*)value_;
- (void)removeDailySummaries:(NSSet*)value_;
- (void)addDailySummariesObject:(DailySummary*)value_;
- (void)removeDailySummariesObject:(DailySummary*)value_;

- (void)addProducers:(NSSet*)value_;
- (void)removeProducers:(NSSet*)value_;
- (void)addProducersObject:(Producer*)value_;
- (void)removeProducersObject:(Producer*)value_;

@end

@interface _QuestionListItem (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAnswer;
- (void)setPrimitiveAnswer:(NSString*)value;




- (NSNumber*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSNumber*)value;

- (BOOL)primitiveDeletedValue;
- (void)setPrimitiveDeletedValue:(BOOL)value_;




- (NSNumber*)primitiveEdited;
- (void)setPrimitiveEdited:(NSNumber*)value;

- (BOOL)primitiveEditedValue;
- (void)setPrimitiveEditedValue:(BOOL)value_;




- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;





- (NSMutableSet*)primitiveDailySummaries;
- (void)setPrimitiveDailySummaries:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProducers;
- (void)setPrimitiveProducers:(NSMutableSet*)value;


@end
