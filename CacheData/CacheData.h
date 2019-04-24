//
//  CacheData.h
//  CacheData
//
//  Created by Krasnovid Filipp on 23/04/2019.
//  Copyright © 2019 LightColorTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheData : NSObject

- (instancetype)initWithSectionCount:(NSInteger)count;

- (NSArray *)cellsArray;
- (NSArray *)cellsArrayAtSection:(NSInteger)section;
- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)headerAtSection:(NSInteger)section;
- (UIView *)footerAtSection:(NSInteger)section;

- (void)addCell:(UITableViewCell *__nonnull)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)updateCell:(UITableViewCell *__nonnull)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)swapCellAtIndexPath:(NSIndexPath *__nonnull)indexPath withCellAtIndexPath:(NSIndexPath *__nonnull)swapIndexPath;

- (void)addHeader:(UIView *__nonnull)header atSection:(NSInteger)section;
- (void)updateHeader:(UIView *__nonnull)header atSection:(NSInteger)section;
- (void)deleteHeaderAtSection:(NSInteger)section;

- (void)addFooter:(UIView *__nonnull)footer atSection:(NSInteger)section;
- (void)updateFooter:(UIView *__nonnull)footer atSection:(NSInteger)section;
- (void)deleteFooterAtSection:(NSInteger)section;

- (void)updateSectionCount:(NSInteger)count;
- (void)cleanCache;
- (BOOL)isLastCellIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)lastIndexPathInSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
