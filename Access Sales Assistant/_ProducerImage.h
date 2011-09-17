// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ProducerImage.h instead.

#import <CoreData/CoreData.h>


@class Producer;




@interface ProducerImageID : NSManagedObjectID {}
@end

@interface _ProducerImage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ProducerImageID*)objectID;




@property (nonatomic, retain) NSString *imageName;


//- (BOOL)validateImageName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *imagePath;


//- (BOOL)validateImagePath:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) Producer* producer;

//- (BOOL)validateProducer:(id*)value_ error:(NSError**)error_;




@end

@interface _ProducerImage (CoreDataGeneratedAccessors)

@end

@interface _ProducerImage (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveImageName;
- (void)setPrimitiveImageName:(NSString*)value;




- (NSString*)primitiveImagePath;
- (void)setPrimitiveImagePath:(NSString*)value;





- (Producer*)primitiveProducer;
- (void)setPrimitiveProducer:(Producer*)value;


@end
