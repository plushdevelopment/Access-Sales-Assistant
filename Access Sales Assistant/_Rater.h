// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Rater.h instead.

#import <CoreData/CoreData.h>


@class Producer;




@interface RaterID : NSManagedObjectID {}
@end

@interface _Rater : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RaterID*)objectID;



@property (nonatomic, retain) NSNumber *guid;

@property short guidValue;
- (short)guidValue;
- (void)setGuidValue:(short)value_;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Producer* producer;
//- (BOOL)validateProducer:(id*)value_ error:(NSError**)error_;




@end

@interface _Rater (CoreDataGeneratedAccessors)

@end

@interface _Rater (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveGuid;
- (void)setPrimitiveGuid:(NSNumber*)value;

- (short)primitiveGuidValue;
- (void)setPrimitiveGuidValue:(short)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (Producer*)primitiveProducer;
- (void)setPrimitiveProducer:(Producer*)value;


@end
