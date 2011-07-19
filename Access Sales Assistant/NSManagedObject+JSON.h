//
//  NSManagedObject+JSON.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (NSManagedObject_JSON)

+ (NSArray*)managedObjectsFromJSONStructure:(NSString*)json withManagedObjectContext:(NSManagedObjectContext*)moc;

@end
