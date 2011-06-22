// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#import <CoreData/CoreData.h>









@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (UserID*)objectID;



@property (nonatomic, retain) NSString *domain;

//- (BOOL)validateDomain:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *password;

//- (BOOL)validatePassword:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *username;

//- (BOOL)validateUsername:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *organization;

//- (BOOL)validateOrganization:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *serviceKey;

//- (BOOL)validateServiceKey:(id*)value_ error:(NSError**)error_;





@end

@interface _User (CoreDataGeneratedAccessors)

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDomain;
- (void)setPrimitiveDomain:(NSString*)value;




- (NSString*)primitivePassword;
- (void)setPrimitivePassword:(NSString*)value;




- (NSString*)primitiveUsername;
- (void)setPrimitiveUsername:(NSString*)value;




- (NSString*)primitiveOrganization;
- (void)setPrimitiveOrganization:(NSString*)value;




- (NSString*)primitiveServiceKey;
- (void)setPrimitiveServiceKey:(NSString*)value;




@end
