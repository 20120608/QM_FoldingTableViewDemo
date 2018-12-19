//
//  DQMGroup.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMGroup.h"
#import "DQMTeam.h"

@implementation DQMGroup

+ (NSDictionary *)mj_objectClassInArray
{
  return @{@"teams" : [DQMTeam class]};
}



- (NSMutableArray<DQMTeam *> *)teams
{
  if(_teams == nil)
  {
    _teams = [NSMutableArray array];
  }
  return _teams;
}

@end
