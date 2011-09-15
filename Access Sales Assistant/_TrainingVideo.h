// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TrainingVideo.h instead.

#import <CoreData/CoreData.h>










@interface TrainingVideoID : NSManagedObjectID {}
@end

@interface _TrainingVideo : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TrainingVideoID*)objectID;




@property (nonatomic, retain) NSString *category;


//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *descp;


//- (BOOL)validateDescp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *thumbnailUrl;


//- (BOOL)validateThumbnailUrl:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *uid;


//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *url;


//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;





@end

@interface _TrainingVideo (CoreDataGeneratedAccessors)

@end

@interface _TrainingVideo (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;




- (NSString*)primitiveDescp;
- (void)setPrimitiveDescp:(NSString*)value;




- (NSString*)primitiveThumbnailUrl;
- (void)setPrimitiveThumbnailUrl:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (NSString*)primitiveUid;
- (void)setPrimitiveUid:(NSString*)value;




- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;




@end
