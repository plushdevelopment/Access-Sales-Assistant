//
//  SectionItem.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SectionItem <NSObject>

- (NSArray *)childItems;
- (NSString *)name;

@end
