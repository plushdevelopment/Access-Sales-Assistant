// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PurposeOfCall.h instead.

#import <CoreData/CoreData.h>


@class DailySummary;




@interface PurposeOfCallID : NSManagedObjectID {}
@end

@interface _PurposeOfCall : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PurposeOfCallID*)objectID;




@property (nonatomic, retain) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *uid;


@property short uidValue;
- (short)uidValue;
- (void)setUidValue:(short)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) DailySummary* dailySummmary;

//- (BOOL)validateDailySummmary:(id*)value_ error:(NSError**)error_;




@end

@interface _PurposeOfCall (CoreDataGeneratedAccessors)

@end

@interface _PurposeOfCall (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (short)primitiveUidValue;
- (void)setPrimitiveUidValue:(short)value_;





- (DailySummary*)primitiveDailySummmary;
- (void)setPrimitiveDailySummmary:(DailySummary*)value;


@end
