//
//  CacheData.m
//  CacheData
//
//  Created by Krasnovid Filipp on 23/04/2019.
//  Copyright © 2019 LightColorTT. All rights reserved.
//

#import "CacheData.h"

@interface CacheData ()

@property (assign, nonatomic) NSInteger countSection;

@property (strong, nonatomic) NSMutableArray *arrayHeaders;
@property (strong, nonatomic) NSMutableArray *arrayFooters;
@property (strong, nonatomic) NSMutableArray *arrayCells;

@end

@implementation CacheData

#pragma mark - Init

- (instancetype)initWithSectionCount:(NSInteger)count {
    self = [super init];
    if (self) {
        self.countSection = count;
        self.arrayHeaders = [NSMutableArray new];
        self.arrayFooters = [NSMutableArray new];
        self.arrayCells = [NSMutableArray new];
        [self preparationArrays];
    }
    return self;
}

- (void)dealloc {
    self.arrayHeaders = nil;
    self.arrayFooters = nil;
    self.arrayCells = nil;
}

#pragma mark - Private

- (void)preparationArrays {
    for (NSInteger i = 0; i < self.countSection; i++) {
        [self.arrayCells addObject:[NSMutableArray new]];
    }
}

#pragma mark - Cells

- (UITableViewCell *)cellAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger countObjectInSection = [self.arrayCells[indexPath.section] count];
    NSAssert((countObjectInSection != 0) | (indexPath.row > countObjectInSection - 1), @"Requested index does not exist");
    return self.arrayCells[indexPath.section][indexPath.row];
}

- (void)addCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [self.arrayCells[indexPath.section] insertObject:cell atIndex:indexPath.row];
}

- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [self.arrayCells[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:cell];
}

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath {
    [self.arrayCells[indexPath.section] removeObjectAtIndex:indexPath.row];
}

- (void)swapCellAtIndexPath:(NSIndexPath *)indexPath withCellAtIndexPath:(NSIndexPath *)swapIndexPath {
    [self.arrayCells[indexPath.section] exchangeObjectAtIndex:indexPath.row withObjectAtIndex:swapIndexPath.row];
}


#pragma mark - Headers

- (UIView *)headerAtSection:(NSInteger)section {
    NSInteger countObjectInSection = [self.arrayHeaders count];
    NSAssert((countObjectInSection != 0) | (section > countObjectInSection - 1), @"Requested index does not exist");
    return [self.arrayHeaders objectAtIndex:section];
}

- (void)addHeader:(UIView *)header atSection:(NSInteger)section {
    [self.arrayHeaders insertObject:header atIndex:section];
}

- (void)updateHeader:(UIView *)header atSection:(NSInteger)section {
    [self.arrayHeaders replaceObjectAtIndex:section withObject:header];
}

- (void)deleteHeaderAtSection:(NSInteger)section {
    [self.arrayHeaders removeObjectAtIndex:section];
}

#pragma mark - Footers

- (UIView *)footerAtSection:(NSInteger)section {
    NSInteger countObjectInSection = [self.arrayFooters count];
    NSAssert((countObjectInSection != 0) | (section > countObjectInSection - 1), @"Requested index does not exist");
    return [self.arrayFooters objectAtIndex:0];
}

- (void)addFooter:(UIView *)footer atSection:(NSInteger)section {
    [self.arrayFooters insertObject:footer atIndex:section];
}

- (void)updateFooter:(UIView *)footer atSection:(NSInteger)section {
    [self.arrayFooters replaceObjectAtIndex:section withObject:footer];
}

- (void)deleteFooterAtSection:(NSInteger)section {
    [self.arrayFooters removeObjectAtIndex:section];
}


#pragma mark - Utility

- (NSArray *)cellsArray {
    return [self.arrayCells copy];
}

- (NSArray *)cellsArrayAtSection:(NSInteger)section {
    return [self.arrayCells[section] copy];
}

- (void)cleanCache {
    [self.arrayHeaders removeAllObjects];
    [self.arrayFooters removeAllObjects];
    [self.arrayCells removeAllObjects];
    [self preparationArrays];
}

- (void)updateSectionCount:(NSInteger)count {
    self.countSection = count;
}

- (BOOL)isLastCellIndexPath:(NSIndexPath *)indexPath {
    return [self.arrayCells[indexPath.section] count] - 1 == indexPath.row ? YES : NO;
}

- (NSIndexPath *)lastIndexPathInSection:(NSInteger)section {
    NSInteger countObjectInSection = [self.arrayCells[section] count];
    NSAssert(!(countObjectInSection == 0), @"No objects in section");
    return [NSIndexPath indexPathForRow:countObjectInSection - 1 inSection:section];
}

@end
