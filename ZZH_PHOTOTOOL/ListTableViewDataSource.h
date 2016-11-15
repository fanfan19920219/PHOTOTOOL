//
//  ListTableViewDataSource.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZZH_PH_Header.h"

@interface ListTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic , strong)NSArray *DataArray;

@end
