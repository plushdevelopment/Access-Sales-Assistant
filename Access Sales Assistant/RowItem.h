//
//  RowItem.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RowItem <NSObject>

- (NSString *)title;
- (NSString *)subtitle;
- (NSString *)summary;
- (UIImage *)image;

@end
