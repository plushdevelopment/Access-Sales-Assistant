// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PolicyCountReportData.h instead.

#import <CoreData/CoreData.h>


@class AUNTK;




@interface PolicyCountReportDataID : NSManagedObjectID {}
@end

@interface _PolicyCountReportData : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PolicyCountReportDataID*)objectID;




@property (nonatomic, retain) NSNumber *count;


@property int countValue;
- (int)countValue;
- (void)setCountValue:(int)value_;

//- (BOOL)validateCount:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *header;


//- (BOOL)validateHeader:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) AUNTK* auntk;

//- (BOOL)validateAuntk:(id*)value_ error:(NSError**)error_;




@end

@interface _PolicyCountReportData (CoreDataGeneratedAccessors)

@end

@interface _PolicyCountReportData (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCount;
- (void)setPrimitiveCount:(NSNumber*)value;

- (int)primitiveCountValue;
- (void)setPrimitiveCountValue:(int)value_;




- (NSString*)primitiveHeader;
- (void)setPrimitiveHeader:(NSString*)value;





- (AUNTK*)primitiveAuntk;
- (void)setPrimitiveAuntk:(AUNTK*)value;


@end
