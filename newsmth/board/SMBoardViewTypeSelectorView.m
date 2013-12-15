//
//  SMBoardViewTypeSelectorView.m
//  newsmth
//
//  Created by Maxwin on 13-12-15.
//  Copyright (c) 2013年 nju. All rights reserved.
//

#import "SMBoardViewTypeSelectorView.h"

@interface SMBoardViewTypeSelectorView ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewForViewType;

@property (strong, nonatomic) NSArray *cells;
@end

@implementation SMBoardViewTypeSelectorView

- (id)init
{
    self = [super init];
    [self commonInit];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:@"SMBoardViewTypeSelectorView" owner:self options:nil];
    CGRect frame = self.frame;
    frame.size = _rootView.bounds.size;
    self.frame = frame;
    
    [self addSubview:_rootView];
}

- (void)setViewType:(SMBoardViewType)viewType
{
    _viewType = viewType;
    [self.tableViewForViewType reloadData];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _cells = @[@(SMBoardViewTypeTztSortByReply), @(SMBoardViewTypeTztSortByPost), @(SMBoardViewTypeNormal)];
    return _cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMBoardViewType viewType = [_cells[indexPath.row] integerValue];
    NSString *text;
    if (viewType == SMBoardViewTypeTztSortByReply) {
        text = @"同主题，回复时间";
    } else if (viewType == SMBoardViewTypeTztSortByPost) {
        text = @"同主题，发表时间";
    } else {
        text = @"普通模式";
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = text;
    cell.accessoryType = viewType == _viewType ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMBoardViewType viewType = [_cells[indexPath.row] integerValue];
    self.viewType = viewType;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end