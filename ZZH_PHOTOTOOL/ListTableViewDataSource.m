//
//  ListTableViewDataSource.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ListTableViewDataSource.h"

@implementation ListTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = @"cell";
    ZZH_PHListCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell = [[ZZH_PHListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    ZZH_PHListModel *listModel = [self.DataArray objectAtIndex:indexPath.row];
//    cell.AlbumNameLabel.text = [NSString stringWithFormat:@"%@ (%@)",listModel.PhotoName,listModel.PhotoCount];
//    cell.celImageView.image = listModel.Photoimage;
    [cell setImage:listModel.Photoimage AndAlbumName:listModel.PhotoName AndNum:listModel.PhotoCount];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}



@end
