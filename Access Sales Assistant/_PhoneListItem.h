// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PhoneListItem.h instead.

#import <CoreData/CoreData.h>


@class Producer;
@class Contact;





@interface PhoneListItemID : NSManagedObjectID {}
@end

@interface _PhoneListItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PhoneListItemID*)objectID;



@property (nonatomic, retain) NSString *number;

//- (BOOL)validateNumber:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *type;

@property short typeValue;
- (short)typeValue;
- (void)setTypeValue:(short)value_;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *guid;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Producer* producer;
//- (BOOL)validateProducer:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Contact* contact;
//- (BOOL)validateContact:(id*)value_ error:(NSError**)error_;




@end

@interface _PhoneListItem (CoreDataGeneratedAccessors)

@end

@interface _PhoneListItem (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveNumber;
- (void)setPrimitiveNumber:(NSString*)value;




- (NSNumber*)primitiveType;
- (void)setPrimitiveType:(NSNumber*)value;

- (short)primitiveTypeValue;
- (void)setPrimitiveTypeValue:(short)value_;




- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;





- (Producer*)primitiveProducer;
- (void)setPrimitiveProducer:(Producer*)value;



- (Contact*)primitiveContact;
- (void)setPrimitiveContact:(Contact*)value;


@end
