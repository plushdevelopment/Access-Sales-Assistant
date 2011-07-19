// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PersonSpokeWith.h instead.

#import <CoreData/CoreData.h>


@class DailySummary;
@class PersonSpokeWithTitle;








@interface PersonSpokeWithID : NSManagedObjectID {}
@end

@interface _PersonSpokeWith : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PersonSpokeWithID*)objectID;



@property (nonatomic, retain) NSString *email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *deleted;

@property BOOL deletedValue;
- (BOOL)deletedValue;
- (void)setDeletedValue:(BOOL)value_;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *uid;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *lastName;

//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *edited;

@property BOOL editedValue;
- (BOOL)editedValue;
- (void)setEditedValue:(BOOL)value_;

//- (BOOL)validateEdited:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *firstName;

//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* dailySummaries;
- (NSMutableSet*)dailySummariesSet;



@property (nonatomic, retain) PersonSpokeWithTitle* title;
//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;




@end

@interface _PersonSpokeWith (CoreDataGeneratedAccessors)

- (void)addDailySummaries:(NSSet*)value_;
- (void)removeDailySummaries:(NSSet*)value_;
- (void)addDailySummariesObject:(DailySummary*)value_;
- (void)removeDailySummariesObject:(DailySummary*)value_;

@end

@interface _PersonSpokeWith (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSNumber*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSNumber*)value;

- (BOOL)primitiveDeletedValue;
- (void)setPrimitiveDeletedValue:(BOOL)value_;




- (NSString*)primitiveUid;
- (void)setPrimitiveUid:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSNumber*)primitiveEdited;
- (void)setPrimitiveEdited:(NSNumber*)value;

- (BOOL)primitiveEditedValue;
- (void)setPrimitiveEditedValue:(BOOL)value_;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;





- (NSMutableSet*)primitiveDailySummaries;
- (void)setPrimitiveDailySummaries:(NSMutableSet*)value;



- (PersonSpokeWithTitle*)primitiveTitle;
- (void)setPrimitiveTitle:(PersonSpokeWithTitle*)value;


@end
