//
//  NSManagedObjectExtras.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSManagedObject (NSObject)

- (NSDictionary *)propertiesAndRelationshipsDictionaryFromEntity:(NSEntityDescription *)entity;
- (NSString *)jsonStringValue;

@end
