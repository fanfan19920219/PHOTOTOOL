//
//  ZZH_PHShowListController.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZZH_PHShowListController.h"
#import "ListTableViewDelegate.h"
#import "ListTableViewDataSource.h"
#define TITLE @"相册列表"
#define BUTTON_SIZE 44.f

#define BUTTON_ANIMATION_SCALE 1.3f

#define BUTTON_ANIMATION_DURATION 0.1f

#define SELECTIMAGENAME @"selete@2x.png"

#define SELECTEDIMAGENAME @"seleted@2x.png"

@interface ZZH_PHShowListController ()<ListTableViewPushDelegate,setCachesArrayDelegate>
{
    UITableView *_tableView;
    ListTableViewDelegate *tableViewDelegate;
    ListTableViewDataSource *tableViewDataSource;
}
@end

@implementation ZZH_PHShowListController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initmethod];
    
}

-(void)initmethod{
    
    self.title = TITLE;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[ZZH_PH_GetAssetObject Default]getAlbumListWithReturnBlock:^(NSMutableArray *returnListArray, NSMutableArray *returnAssetsArray) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            tableViewDelegate = [[ListTableViewDelegate alloc]init];
            tableViewDelegate.delegate = self;
            tableViewDataSource = [[ListTableViewDataSource alloc]init];
            tableViewDelegate.DataArray = returnAssetsArray;
            tableViewDataSource.DataArray = returnListArray;
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
            _tableView.rowHeight = 60;
            _tableView.dataSource = tableViewDataSource;
            _tableView.delegate = tableViewDelegate;
            _tableView.tableFooterView = [[UIView alloc]init];
            //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.view addSubview:_tableView];
        });
    }];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 2, 50, 30);
    button.titleLabel.font = [UIFont systemFontOfSize:16 weight:0.3];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:RGB(250) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismisss) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
}

-(void)dismisss{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(void)ReturnBlock{
    
    NSMutableArray *pathArray = [[NSMutableArray alloc]init];
    for(ZZH_PHCellImageView *cellImageView in self.cachePhotoArray){
        [pathArray addObject:cellImageView.asset.localIdentifier];
    }
    [SVProgressHUD showWithStatus:@"正在获取照片中..."];
    
    [[ZZH_PH_GetAssetObject Default]enumerateAssetsInAssetPhotoPath:pathArray original:YES withReturnBlock:^(NSMutableArray *ImageArray, NSMutableArray *assetArray, NSMutableArray *indexArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate ZZH_PHoto_ReturnArray:ImageArray];
            [SVProgressHUD dismiss];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
    }];
}

-(void)tableViewPush:(UIViewController *)nextViewContoller withParameter:(id)indexParameter{

    ZZH_PHPhotoViewController *showphotoVC = (ZZH_PHPhotoViewController*)nextViewContoller;
    showphotoVC.cachePhotoArray = self.cachePhotoArray;
    showphotoVC.title = (NSString*)indexParameter;
    [self.navigationController pushViewController:showphotoVC animated:YES];
    [showphotoVC setDelegate:self];
    
}

#pragma mark ::::::::::::::::setCachesArrayDelegate:::::::::::::::::::
/**
 *  添加删除已经选中照片的方法
 *
 *  @param judgmentIndex YES为添加   NO为删除
 *  @param object            object = PHCellImageView
 */
-(void)addOrDelete:(UIButton*)judgmentIndex withObject:(id)object AndButton:(UIButton *)sender{
    
    
    
    ZZH_PHCellImageView *imageView = (ZZH_PHCellImageView*)object;
    
    if(judgmentIndex.selected==NO) {
        if(self.cachePhotoArray.count>=self.maxIndex){
            NSString *showString = [NSString stringWithFormat:@"您最多只能选择%ld张照片",(long)self.maxIndex];
            UIAlertView *showAlkerView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:showString delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [showAlkerView show];
            return;
        }
        [self.cachePhotoArray addObject:imageView];
            [UIView animateWithDuration:BUTTON_ANIMATION_DURATION animations:^{
                sender.transform =CGAffineTransformScale(sender.transform, BUTTON_ANIMATION_SCALE,BUTTON_ANIMATION_SCALE);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:BUTTON_ANIMATION_DURATION animations:^{
                        sender.transform=CGAffineTransformIdentity;
                    }];
                }];
    } else {
        for(ZZH_PHCellImageView *judgmentImegView in self.cachePhotoArray){
            if([judgmentImegView.asset.localIdentifier isEqualToString:imageView.asset.localIdentifier]){
                [self.cachePhotoArray removeObject:judgmentImegView];
                break;
            }
        }
    }
    sender.selected = !sender.selected;
}


@end
