//
//  MainViewSectionInfo.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SectionHeaderView.h"
@interface MainViewSectionInfo : NSObject

@property (assign) BOOL open;

@property (nonatomic,strong) SectionHeaderView* headerView;

@property (nonatomic,readonly) NSMutableArray *rowHeights;

@property (nonatomic,strong) NSString* sectionName;

- (NSUInteger)countOfRowHeights;
- (id)objectInRowHeightsAtIndex:(NSUInteger)idx;
- (void)insertObject:(id)anObject inRowHeightsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)idx;
- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)idx withObject:(id)anObject;
- (void)getRowHeights:(id *)buffer range:(NSRange)inRange;
- (void)insertRowHeights:(NSArray *)rowHeightArray atIndexes:(NSIndexSet *)indexes;
- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)rowHeightArray;


@end
