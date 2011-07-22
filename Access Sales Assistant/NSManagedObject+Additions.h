//
//  NSManagedObject+Additions.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (NSManagedObject_Additions)
+ (id)ai_objectForProperty:(NSString *)propertyName value:(id)propertyValue managedObjectContext:(NSManagedObjectContext *)context;
@end
