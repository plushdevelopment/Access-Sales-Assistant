//
//  NSManagedObject+Additions.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSManagedObject+Additions.h"
#import "CoreData+ActiveRecordFetching.h"

@implementation NSManagedObject (NSManagedObject_Additions)

+ (id)ai_objectForProperty:(NSString *)propertyName value:(id)propertyValue
{
	NSManagedObject *object = [[self class] findFirstByAttribute:propertyName withValue:propertyValue];
	if (!object) {
		object = [[self class] createEntity];
		[object setValue:propertyValue forKey:propertyName];
	}
	return object;
}

@end
