// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EmailListItem.h instead.

#import <CoreData/CoreData.h>


@class Contact;
@class Producer;




@interface EmailListItemID : NSManagedObjectID {}
@end

@interface _EmailListItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EmailListItemID*)objectID;



@property (nonatomic, retain) NSNumber *type;

@property short typeValue;
- (short)typeValue;
- (void)setTypeValue:(short)value_;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Contact* contact;
//- (BOOL)validateContact:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Producer* producer;
//- (BOOL)validateProducer:(id*)value_ error:(NSError**)error_;




@end

@interface _EmailListItem (CoreDataGeneratedAccessors)

@end

@interface _EmailListItem (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveType;
- (void)setPrimitiveType:(NSNumber*)value;

- (short)primitiveTypeValue;
- (void)setPrimitiveTypeValue:(short)value_;




- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;





- (Contact*)primitiveContact;
- (void)setPrimitiveContact:(Contact*)value;



- (Producer*)primitiveProducer;
- (void)setPrimitiveProducer:(Producer*)value;


@end
