//
//  DQMFoldingTableViewController.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMFoldingTableViewController.h"
#import "DQMGroup.h"
#import "DQMTeam.h"
#import "DQMListExpendHeaderView.h"

//测试跳转
#import "ViewController.h"

@interface DQMFoldingTableViewController ()

/** section的数组 */
@property (nonatomic, strong) NSMutableArray<DQMGroup *> *groups;

@end

@implementation DQMFoldingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  UIEdgeInsets edgeInsets = self.tableView.contentInset;
  edgeInsets.top += NAVIGATION_BAR_HEIGHT;
  edgeInsets.bottom += TAB_BAR_HEIGHT;
  self.tableView.contentInset = edgeInsets;
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return self.groups.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // 关键
  return self.groups[section].isOpened ? self.groups[section].teams.count : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return self.groups[section].name;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *const ID = @"team";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
  
  if (!cell) {
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    
  }
  
  cell.textLabel.text = self.groups[indexPath.section].teams[indexPath.row].sortNumber;
  cell.detailTextLabel.text = self.groups[indexPath.section].teams[indexPath.row].name;
  
  return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  DQMListExpendHeaderView *headerView = [DQMListExpendHeaderView headerViewWithTableView:tableView];
  
  headerView.group = self.groups[section];
  QMWeak(self);
  [headerView setSelectGroup:^BOOL{
    
    weakself.groups[section].isOpened = !weakself.groups[section].isOpened;
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

    return weakself.groups[section].isOpened;
  }];
  
  return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 44;
}

- (NSMutableArray<DQMGroup *> *)groups
{
  if (_groups == nil) {
    
    
    _groups = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"team_dictionary" ofType:@"plist"];
    
    NSDictionary *dictDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    [dictDict enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSArray<NSString *>  *obj, BOOL * _Nonnull stop) {
      
      DQMGroup *group = [DQMGroup new];
      
      group.isOpened = YES;
      
      group.name = key.copy;
      
      [obj enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        DQMTeam *team = [DQMTeam new];
        
        team.sortNumber = [NSString stringWithFormat:@"%zd", idx];
        team.name = [obj copy];
        
        [group.teams addObject:team];
        
      }];
      
      [self->_groups addObject:group];
    }];
    
    
    [_groups sortUsingComparator:^NSComparisonResult(DQMTeam * _Nonnull obj1, DQMTeam * _Nonnull obj2) {
      return [obj1.name compare:obj2.name] == NSOrderedAscending ? NSOrderedAscending : NSOrderedDescending;
    }];
  }
  return _groups;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}


#pragma mark - DQMNavUIBaseViewControllerDataSource

/** 导航条左边的按钮 */
- (UIImage *)lmjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar
{
  [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
  
  return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

#pragma mark - DQMNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar
{
  [self.navigationController popViewControllerAnimated:YES];
}

@end
