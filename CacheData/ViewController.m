//
//  ViewController.m
//  CacheData
//
//  Created by Krasnovid Filipp on 23/04/2019.
//  Copyright © 2019 LightColorTT. All rights reserved.
//

#import "ViewController.h"
#import "CacheData.h"

static NSInteger countSection = 3;
static NSString *identifier = @"testIdentidier";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CacheData *cacheData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cacheData = [[CacheData alloc] initWithSectionCount:countSection];
    [self createCells];
    [self createHeaderAndFooter];
    [self createTable];
}

- (void)createCells {
    for (NSInteger i = 0; i < countSection; i++) {
        for (NSInteger j = 0; j < arc4random_uniform(15) + 5; j++) {
            UITableViewCell *tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            tableViewCell.textLabel.text = [NSString stringWithFormat:@"section = %ld row = %ld",indexPath.section, indexPath.row];
            [self.cacheData addCell:tableViewCell atIndexPath:indexPath];
        }
    }
}

- (void)createHeaderAndFooter {
    for (NSInteger i = 0; i < countSection; i++) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.f)];
        headerView.backgroundColor = [UIColor redColor];
        [self.cacheData addHeader:headerView atSection:i];
    }
    
    for (NSInteger i = 0; i < countSection; i++) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.f)];
        footerView.backgroundColor = [UIColor blueColor];
        [self.cacheData addFooter:footerView atSection:i];
    }
    
}

- (void)createTable {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44.f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.cacheData headerAtSection:section];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.cacheData footerAtSection:section];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.cacheData cellsArrayAtSection:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cacheData cellAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return countSection;
}

- (IBAction)deleteLastCellAction:(UIBarButtonItem *)sender {
    NSIndexPath *lastIndexPath = [self.cacheData lastIndexPathInSection:0];
    NSLog(@"remove cell at indexPath: %@", lastIndexPath);
    [self.cacheData deleteCellAtIndexPath:lastIndexPath];
    [self.tableView reloadData];
}

- (IBAction)addCellAction:(UIBarButtonItem *)sender {
    NSIndexPath *lastIndexPath = [self.cacheData lastIndexPathInSection:0];
    NSIndexPath *newCellIndex = [NSIndexPath indexPathForRow:lastIndexPath.row + 1 inSection:lastIndexPath.section];
    NSLog(@"add cell at indexPath: %@", lastIndexPath);
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    tableViewCell.textLabel.text = [NSString stringWithFormat:@"section = %ld row = %ld",newCellIndex.section, newCellIndex.row];
    [self.cacheData addCell:tableViewCell atIndexPath:newCellIndex];
    [self.tableView reloadData];
}

- (IBAction)swapAction:(UIBarButtonItem *)sender {
    NSIndexPath *lastIndexPath = [self.cacheData lastIndexPathInSection:0];
    NSIndexPath *prevCellIndexPath = [NSIndexPath indexPathForRow:lastIndexPath.row + -1 inSection:lastIndexPath.section];
    NSLog(@"swap cell at indexPath: %@ to indexPath: %@", lastIndexPath, prevCellIndexPath);;
    [self.cacheData swapCellAtIndexPath:lastIndexPath withCellAtIndexPath:prevCellIndexPath];
    [self.tableView reloadData];
}

- (IBAction)updateAction:(UIBarButtonItem *)sender {
    NSIndexPath *lastIndexPath = [self.cacheData lastIndexPathInSection:0];
    NSLog(@"update cell at indexPath: %@", lastIndexPath);
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    tableViewCell.textLabel.text = [NSString stringWithFormat:@"updated cell at index path %@",lastIndexPath];
    tableViewCell.textLabel.adjustsFontSizeToFitWidth = YES;
    [self.cacheData updateCell:tableViewCell atIndexPath:lastIndexPath];
    [self.tableView reloadData];
}

@end
