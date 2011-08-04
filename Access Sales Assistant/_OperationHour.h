// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to OperationHour.h instead.

#import <CoreData/CoreData.h>


@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;
@class HoursOfOperation;




@interface OperationHourID : NSManagedObjectID {}
@end

@interface _OperationHour : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (OperationHourID*)objectID;




@property (nonatomic, retain) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *uid;


@property short uidValue;
- (short)uidValue;
- (void)setUidValue:(short)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* fridayCloseTime;

- (NSMutableSet*)fridayCloseTimeSet;




@property (nonatomic, retain) NSSet* fridayOpenTime;

- (NSMutableSet*)fridayOpenTimeSet;




@property (nonatomic, retain) NSSet* mondayCloseTime;

- (NSMutableSet*)mondayCloseTimeSet;




@property (nonatomic, retain) NSSet* mondayOpenTime;

- (NSMutableSet*)mondayOpenTimeSet;




@property (nonatomic, retain) NSSet* saturdayCloseTime;

- (NSMutableSet*)saturdayCloseTimeSet;




@property (nonatomic, retain) NSSet* saturdayOpenTime;

- (NSMutableSet*)saturdayOpenTimeSet;




@property (nonatomic, retain) NSSet* sundayCloseTime;

- (NSMutableSet*)sundayCloseTimeSet;




@property (nonatomic, retain) NSSet* sundayOpenTime;

- (NSMutableSet*)sundayOpenTimeSet;




@property (nonatomic, retain) NSSet* thursdayCloseTime;

- (NSMutableSet*)thursdayCloseTimeSet;




@property (nonatomic, retain) NSSet* thursdayOpenTime;

- (NSMutableSet*)thursdayOpenTimeSet;




@property (nonatomic, retain) NSSet* tuesdayCloseTime;

- (NSMutableSet*)tuesdayCloseTimeSet;




@property (nonatomic, retain) NSSet* tuesdayOpenTime;

- (NSMutableSet*)tuesdayOpenTimeSet;




@property (nonatomic, retain) NSSet* wednesdayCloseTime;

- (NSMutableSet*)wednesdayCloseTimeSet;




@property (nonatomic, retain) NSSet* wednesdayOpenTime;

- (NSMutableSet*)wednesdayOpenTimeSet;




@end

@interface _OperationHour (CoreDataGeneratedAccessors)

- (void)addFridayCloseTime:(NSSet*)value_;
- (void)removeFridayCloseTime:(NSSet*)value_;
- (void)addFridayCloseTimeObject:(HoursOfOperation*)value_;
- (void)removeFridayCloseTimeObject:(HoursOfOperation*)value_;

- (void)addFridayOpenTime:(NSSet*)value_;
- (void)removeFridayOpenTime:(NSSet*)value_;
- (void)addFridayOpenTimeObject:(HoursOfOperation*)value_;
- (void)removeFridayOpenTimeObject:(HoursOfOperation*)value_;

- (void)addMondayCloseTime:(NSSet*)value_;
- (void)removeMondayCloseTime:(NSSet*)value_;
- (void)addMondayCloseTimeObject:(HoursOfOperation*)value_;
- (void)removeMondayCloseTimeObject:(HoursOfOperation*)value_;

- (void)addMondayOpenTime:(NSSet*)value_;
- (void)removeMondayOpenTime:(NSSet*)value_;
- (void)addMondayOpenTimeObject:(HoursOfOperation*)value_;
- (void)removeMondayOpenTimeObject:(HoursOfOperation*)value_;

- (void)addSaturdayCloseTime:(NSSet*)value_;
- (void)removeSaturdayCloseTime:(NSSet*)value_;
- (void)addSaturdayCloseTimeObject:(HoursOfOperation*)value_;
- (void)removeSaturdayCloseTimeObject:(HoursOfOperation*)value_;

- (void)addSaturdayOpenTime:(NSSet*)value_;
- (void)removeSaturdayOpenTime:(NSSet*)value_;
- (void)addSaturdayOpenTimeObject:(HoursOfOperation*)value_;
- (void)removeSaturdayOpenTimeObject:(HoursOfOperation*)value_;

- (void)addSundayCloseTime:(NSSet*)value_;
- (void)removeSundayCloseTime:(NSSet*)value_;
- (void)addSundayCloseTimeObject:(HoursOfOperation*)value_;
- (void)removeSundayCloseTimeObject:(HoursOfOperation*)value_;

- (void)addSundayOpenTime:(NSSet*)value_;
- (void)removeSundayOpenTime:(NSSet*)value_;
- (void)addSundayOpenTimeObject:(HoursOfOperation*)value_;
- (void)removeSundayOpenTimeObject:(HoursOfOperation*)value_;

- (void)addThursdayCloseTime:(NSSet*)value_;
- (void)removeThursdayCloseTime:(NSSet*)value_;
- (void)addThursdayCloseTimeObject:(HoursOfOperation*)value_;
- (void)removeThursdayCloseTimeObject:(HoursOfOperation*)value_;

- (void)addThursdayOpenTime:(NSSet*)value_;
- (void)removeThursdayOpenTime:(NSSet*)value_;
- (void)addThursdayOpenTimeObject:(HoursOfOperation*)value_;
- (void)removeThursdayOpenTimeObject:(HoursOfOperation*)value_;

- (void)addTuesdayCloseTime:(NSSet*)value_;
- (void)removeTuesdayCloseTime:(NSSet*)value_;
- (void)addTuesdayCloseTimeObject:(HoursOfOperation*)value_;
- (void)removeTuesdayCloseTimeObject:(HoursOfOperation*)value_;

- (void)addTuesdayOpenTime:(NSSet*)value_;
- (void)removeTuesdayOpenTime:(NSSet*)value_;
- (void)addTuesdayOpenTimeObject:(HoursOfOperation*)value_;
- (void)removeTuesdayOpenTimeObject:(HoursOfOperation*)value_;

- (void)addWednesdayCloseTime:(NSSet*)value_;
- (void)removeWednesdayCloseTime:(NSSet*)value_;
- (void)addWednesdayCloseTimeObject:(HoursOfOperation*)value_;
- (void)removeWednesdayCloseTimeObject:(HoursOfOperation*)value_;

- (void)addWednesdayOpenTime:(NSSet*)value_;
- (void)removeWednesdayOpenTime:(NSSet*)value_;
- (void)addWednesdayOpenTimeObject:(HoursOfOperation*)value_;
- (void)removeWednesdayOpenTimeObject:(HoursOfOperation*)value_;

@end

@interface _OperationHour (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (short)primitiveUidValue;
- (void)setPrimitiveUidValue:(short)value_;





- (NSMutableSet*)primitiveFridayCloseTime;
- (void)setPrimitiveFridayCloseTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveFridayOpenTime;
- (void)setPrimitiveFridayOpenTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveMondayCloseTime;
- (void)setPrimitiveMondayCloseTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveMondayOpenTime;
- (void)setPrimitiveMondayOpenTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveSaturdayCloseTime;
- (void)setPrimitiveSaturdayCloseTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveSaturdayOpenTime;
- (void)setPrimitiveSaturdayOpenTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveSundayCloseTime;
- (void)setPrimitiveSundayCloseTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveSundayOpenTime;
- (void)setPrimitiveSundayOpenTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveThursdayCloseTime;
- (void)setPrimitiveThursdayCloseTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveThursdayOpenTime;
- (void)setPrimitiveThursdayOpenTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveTuesdayCloseTime;
- (void)setPrimitiveTuesdayCloseTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveTuesdayOpenTime;
- (void)setPrimitiveTuesdayOpenTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveWednesdayCloseTime;
- (void)setPrimitiveWednesdayCloseTime:(NSMutableSet*)value;



- (NSMutableSet*)primitiveWednesdayOpenTime;
- (void)setPrimitiveWednesdayOpenTime:(NSMutableSet*)value;


@end
