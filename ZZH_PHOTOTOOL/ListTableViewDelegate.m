//
//  ListTableViewDelegate.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ListTableViewDelegate.h"

@implementation ListTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PHAssetCollection *assetCollection = [self.DataArray objectAtIndex:indexPath.row];
    ZZH_PHPhotoViewController *PhotoVC = [[ZZH_PHPhotoViewController alloc]init];
    PhotoVC.assetCollection = assetCollection;
    
    [self.delegate tableViewPush:PhotoVC withParameter: assetCollection.localizedTitle];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}
@end
