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




@property (nonatomic, retain) NSString *Title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *URL;


//- (BOOL)validateURL:(id*)value_ error:(NSError**)error_;





@end

@interface _TrainingVideo (CoreDataGeneratedAccessors)

@end

@interface _TrainingVideo (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (NSString*)primitiveURL;
- (void)setPrimitiveURL:(NSString*)value;




@end
