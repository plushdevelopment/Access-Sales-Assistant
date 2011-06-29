// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HoursOfOperation.h instead.

#import <CoreData/CoreData.h>


@class Producer;
















@interface HoursOfOperationID : NSManagedObjectID {}
@end

@interface _HoursOfOperation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (HoursOfOperationID*)objectID;



@property (nonatomic, retain) NSDate *saturdayOpenTime;

//- (BOOL)validateSaturdayOpenTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *wednesdayCloseTime;

//- (BOOL)validateWednesdayCloseTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *mondayOpenTime;

//- (BOOL)validateMondayOpenTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *tuesdayOpenTime;

//- (BOOL)validateTuesdayOpenTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *mondayCloseTime;

//- (BOOL)validateMondayCloseTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *thursdayOpenTime;

//- (BOOL)validateThursdayOpenTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *saturdayCloseTime;

//- (BOOL)validateSaturdayCloseTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *tuesdayCloseTime;

//- (BOOL)validateTuesdayCloseTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *fridayOpenTime;

//- (BOOL)validateFridayOpenTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *sundayCloseTime;

//- (BOOL)validateSundayCloseTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *sundayOpenTime;

//- (BOOL)validateSundayOpenTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *thursdayCloseTime;

//- (BOOL)validateThursdayCloseTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *fridayCloseTime;

//- (BOOL)validateFridayCloseTime:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *wednesdayOpenTime;

//- (BOOL)validateWednesdayOpenTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* producer;
- (NSMutableSet*)producerSet;




@end

@interface _HoursOfOperation (CoreDataGeneratedAccessors)

- (void)addProducer:(NSSet*)value_;
- (void)removeProducer:(NSSet*)value_;
- (void)addProducerObject:(Producer*)value_;
- (void)removeProducerObject:(Producer*)value_;

@end

@interface _HoursOfOperation (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveSaturdayOpenTime;
- (void)setPrimitiveSaturdayOpenTime:(NSDate*)value;




- (NSDate*)primitiveWednesdayCloseTime;
- (void)setPrimitiveWednesdayCloseTime:(NSDate*)value;




- (NSDate*)primitiveMondayOpenTime;
- (void)setPrimitiveMondayOpenTime:(NSDate*)value;




- (NSDate*)primitiveTuesdayOpenTime;
- (void)setPrimitiveTuesdayOpenTime:(NSDate*)value;




- (NSDate*)primitiveMondayCloseTime;
- (void)setPrimitiveMondayCloseTime:(NSDate*)value;




- (NSDate*)primitiveThursdayOpenTime;
- (void)setPrimitiveThursdayOpenTime:(NSDate*)value;




- (NSDate*)primitiveSaturdayCloseTime;
- (void)setPrimitiveSaturdayCloseTime:(NSDate*)value;




- (NSDate*)primitiveTuesdayCloseTime;
- (void)setPrimitiveTuesdayCloseTime:(NSDate*)value;




- (NSDate*)primitiveFridayOpenTime;
- (void)setPrimitiveFridayOpenTime:(NSDate*)value;




- (NSDate*)primitiveSundayCloseTime;
- (void)setPrimitiveSundayCloseTime:(NSDate*)value;




- (NSDate*)primitiveSundayOpenTime;
- (void)setPrimitiveSundayOpenTime:(NSDate*)value;




- (NSDate*)primitiveThursdayCloseTime;
- (void)setPrimitiveThursdayCloseTime:(NSDate*)value;




- (NSDate*)primitiveFridayCloseTime;
- (void)setPrimitiveFridayCloseTime:(NSDate*)value;




- (NSDate*)primitiveWednesdayOpenTime;
- (void)setPrimitiveWednesdayOpenTime:(NSDate*)value;





- (NSMutableSet*)primitiveProducer;
- (void)setPrimitiveProducer:(NSMutableSet*)value;


@end
