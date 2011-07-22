// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PersonSpokeWithTitle.h instead.

#import <CoreData/CoreData.h>


@class PersonSpokeWith;




@interface PersonSpokeWithTitleID : NSManagedObjectID {}
@end

@interface _PersonSpokeWithTitle : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PersonSpokeWithTitleID*)objectID;




@property (nonatomic, retain) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *uid;


@property short uidValue;
- (short)uidValue;
- (void)setUidValue:(short)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* personSpokeWith;

- (NSMutableSet*)personSpokeWithSet;




@end

@interface _PersonSpokeWithTitle (CoreDataGeneratedAccessors)

- (void)addPersonSpokeWith:(NSSet*)value_;
- (void)removePersonSpokeWith:(NSSet*)value_;
- (void)addPersonSpokeWithObject:(PersonSpokeWith*)value_;
- (void)removePersonSpokeWithObject:(PersonSpokeWith*)value_;

@end

@interface _PersonSpokeWithTitle (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (short)primitiveUidValue;
- (void)setPrimitiveUidValue:(short)value_;





- (NSMutableSet*)primitivePersonSpokeWith;
- (void)setPrimitivePersonSpokeWith:(NSMutableSet*)value;


@end
