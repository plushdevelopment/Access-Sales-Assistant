// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Agency.h instead.

#import <CoreData/CoreData.h>






@interface AgencyID : NSManagedObjectID {}
@end

@interface _Agency : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AgencyID*)objectID;



@property (nonatomic, retain) NSString *guid;

//- (BOOL)validateGuid:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@end

@interface _Agency (CoreDataGeneratedAccessors)

@end

@interface _Agency (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveGuid;
- (void)setPrimitiveGuid:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




@end
