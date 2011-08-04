// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HoursOfOperation.h instead.

#import <CoreData/CoreData.h>


@class OperationHour;
@class OperationHour;
@class OperationHour;
@class OperationHour;
@class Producer;
@class OperationHour;
@class OperationHour;
@class OperationHour;
@class OperationHour;
@class OperationHour;
@class OperationHour;
@class OperationHour;
@class OperationHour;
@class OperationHour;
@class OperationHour;


@interface HoursOfOperationID : NSManagedObjectID {}
@end

@interface _HoursOfOperation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (HoursOfOperationID*)objectID;





@property (nonatomic, retain) OperationHour* fridayCloseTime;

//- (BOOL)validateFridayCloseTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* fridayOpenTime;

//- (BOOL)validateFridayOpenTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* mondayCloseTime;

//- (BOOL)validateMondayCloseTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* mondayOpenTime;

//- (BOOL)validateMondayOpenTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* producer;

- (NSMutableSet*)producerSet;




@property (nonatomic, retain) OperationHour* saturdayCloseTime;

//- (BOOL)validateSaturdayCloseTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* saturdayOpenTime;

//- (BOOL)validateSaturdayOpenTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* sundayCloseTime;

//- (BOOL)validateSundayCloseTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* sundayOpenTime;

//- (BOOL)validateSundayOpenTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* thursdayCloseTime;

//- (BOOL)validateThursdayCloseTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* thursdayOpenTime;

//- (BOOL)validateThursdayOpenTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* tuesdayCloseTime;

//- (BOOL)validateTuesdayCloseTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* tuesdayOpenTime;

//- (BOOL)validateTuesdayOpenTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* wednesdayCloseTime;

//- (BOOL)validateWednesdayCloseTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) OperationHour* wednesdayOpenTime;

//- (BOOL)validateWednesdayOpenTime:(id*)value_ error:(NSError**)error_;




@end

@interface _HoursOfOperation (CoreDataGeneratedAccessors)

- (void)addProducer:(NSSet*)value_;
- (void)removeProducer:(NSSet*)value_;
- (void)addProducerObject:(Producer*)value_;
- (void)removeProducerObject:(Producer*)value_;

@end

@interface _HoursOfOperation (CoreDataGeneratedPrimitiveAccessors)



- (OperationHour*)primitiveFridayCloseTime;
- (void)setPrimitiveFridayCloseTime:(OperationHour*)value;



- (OperationHour*)primitiveFridayOpenTime;
- (void)setPrimitiveFridayOpenTime:(OperationHour*)value;



- (OperationHour*)primitiveMondayCloseTime;
- (void)setPrimitiveMondayCloseTime:(OperationHour*)value;



- (OperationHour*)primitiveMondayOpenTime;
- (void)setPrimitiveMondayOpenTime:(OperationHour*)value;



- (NSMutableSet*)primitiveProducer;
- (void)setPrimitiveProducer:(NSMutableSet*)value;



- (OperationHour*)primitiveSaturdayCloseTime;
- (void)setPrimitiveSaturdayCloseTime:(OperationHour*)value;



- (OperationHour*)primitiveSaturdayOpenTime;
- (void)setPrimitiveSaturdayOpenTime:(OperationHour*)value;



- (OperationHour*)primitiveSundayCloseTime;
- (void)setPrimitiveSundayCloseTime:(OperationHour*)value;



- (OperationHour*)primitiveSundayOpenTime;
- (void)setPrimitiveSundayOpenTime:(OperationHour*)value;



- (OperationHour*)primitiveThursdayCloseTime;
- (void)setPrimitiveThursdayCloseTime:(OperationHour*)value;



- (OperationHour*)primitiveThursdayOpenTime;
- (void)setPrimitiveThursdayOpenTime:(OperationHour*)value;



- (OperationHour*)primitiveTuesdayCloseTime;
- (void)setPrimitiveTuesdayCloseTime:(OperationHour*)value;



- (OperationHour*)primitiveTuesdayOpenTime;
- (void)setPrimitiveTuesdayOpenTime:(OperationHour*)value;



- (OperationHour*)primitiveWednesdayCloseTime;
- (void)setPrimitiveWednesdayCloseTime:(OperationHour*)value;



- (OperationHour*)primitiveWednesdayOpenTime;
- (void)setPrimitiveWednesdayOpenTime:(OperationHour*)value;


@end
