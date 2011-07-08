// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to QuestionListItem.h instead.

#import <CoreData/CoreData.h>


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



@property (nonatomic, retain) NSString *guid;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* producers;
- (NSMutableSet*)producersSet;




@end

@interface _QuestionListItem (CoreDataGeneratedAccessors)

- (void)addProducers:(NSSet*)value_;
- (void)removeProducers:(NSSet*)value_;
- (void)addProducersObject:(Producer*)value_;
- (void)removeProducersObject:(Producer*)value_;

@end

@interface _QuestionListItem (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAnswer;
- (void)setPrimitiveAnswer:(NSString*)value;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;





- (NSMutableSet*)primitiveProducers;
- (void)setPrimitiveProducers:(NSMutableSet*)value;


@end
