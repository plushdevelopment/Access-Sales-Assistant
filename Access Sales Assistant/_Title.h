// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Title.h instead.

#import <CoreData/CoreData.h>


@class Contact;
@class PersonSpokeWith;




@interface TitleID : NSManagedObjectID {}
@end

@interface _Title : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TitleID*)objectID;



@property (nonatomic, retain) NSNumber *uid;

@property short uidValue;
- (short)uidValue;
- (void)setUidValue:(short)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* contact;
- (NSMutableSet*)contactSet;



@property (nonatomic, retain) NSSet* personSpokeWith;
- (NSMutableSet*)personSpokeWithSet;




@end

@interface _Title (CoreDataGeneratedAccessors)

- (void)addContact:(NSSet*)value_;
- (void)removeContact:(NSSet*)value_;
- (void)addContactObject:(Contact*)value_;
- (void)removeContactObject:(Contact*)value_;

- (void)addPersonSpokeWith:(NSSet*)value_;
- (void)removePersonSpokeWith:(NSSet*)value_;
- (void)addPersonSpokeWithObject:(PersonSpokeWith*)value_;
- (void)removePersonSpokeWithObject:(PersonSpokeWith*)value_;

@end

@interface _Title (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (short)primitiveUidValue;
- (void)setPrimitiveUidValue:(short)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveContact;
- (void)setPrimitiveContact:(NSMutableSet*)value;



- (NSMutableSet*)primitivePersonSpokeWith;
- (void)setPrimitivePersonSpokeWith:(NSMutableSet*)value;


@end
