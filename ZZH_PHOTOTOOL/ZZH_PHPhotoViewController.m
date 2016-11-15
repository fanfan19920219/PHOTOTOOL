//
//  ZZH_PHPhotoViewController.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZZH_PHPhotoViewController.h"


@interface ZZH_PHPhotoViewController ()<CollectionViewPushDelegate,setCachesArrayDelegate>
{
    UICollectionView *_collectionView;
    ZZH_PHColletionProtocol *collectionProtocol;
    
    UIButton *_cancelButton;
    UIButton *_ensureButton;
    UILabel  *_loadingLabel;
    UILabel  *_showCurrentSelectNumLabel;
    
    __strong ZZH_PHShowListController *listVC;
}
@end

@implementation ZZH_PHPhotoViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initMethod];
    [self create_Views];
    [self refreshCollectionView];
}

-(void)initMethod{
    self.view.backgroundColor =  RGBA(63, 130, 139, 1);
}

-(void)create_Views{
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=10.0f;
    flowLayout.minimumLineSpacing=10.0f;
    flowLayout.itemSize=CGSizeMake(80, 80);
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    
    //  创建 collectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT - 104) collectionViewLayout:flowLayout];
    collectionProtocol = [[ZZH_PHColletionProtocol alloc]init];
    collectionProtocol.delegate = self;
    collectionProtocol.dataSource = listVC;
    collectionProtocol.cacheArray = self.cachePhotoArray;
    _collectionView.delegate = collectionProtocol;
    _collectionView.dataSource = collectionProtocol;
    _collectionView.backgroundColor = RGB(242);
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 1)];
    downLine.backgroundColor = RGB(222);
    [self.view addSubview:downLine];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(10, SCREEN_HEIGHT - 40, 80, 40);
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:_cancelButton];
    
    _ensureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _ensureButton.frame = CGRectMake(SCREEN_WIDTH - 90, SCREEN_HEIGHT - 40, 80, 40);
    [_ensureButton addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    [_ensureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ensureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:_ensureButton];
    
    _loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 100)];
    _loadingLabel.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    _loadingLabel.text = @"加载照片中，不要着急哦^_^";
    _loadingLabel.textAlignment = NSTextAlignmentCenter;
    _loadingLabel.textColor = RGB(144);
    [self.view addSubview:_loadingLabel];
    
    _showCurrentSelectNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, SCREEN_HEIGHT - 30, 20, 20)];
    _showCurrentSelectNumLabel.layer.cornerRadius = 10;
    _showCurrentSelectNumLabel.clipsToBounds = YES;
    _showCurrentSelectNumLabel.backgroundColor = [UIColor whiteColor];
    _showCurrentSelectNumLabel.textColor = RGBA(63, 130, 139, 1);
    _showCurrentSelectNumLabel.hidden = YES;
    _showCurrentSelectNumLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_showCurrentSelectNumLabel];
    
}

#pragma mark :::::::::::::::::: ensureButtonMethod :::::::::::::::::::::::
-(void)ensure{
    [listVC ReturnBlock];
}




-(void)refreshCollectionView{
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue1, ^{
        [ZZHPHOTOTOOL enumerateAssetsInAssetCollection:self.assetCollection original:NO withReturnBlock:^(NSMutableArray *ImageArray, NSMutableArray *assetArray, NSMutableArray *indexArray) {
            dispatch_async(dispatch_get_main_queue(), ^{
                collectionProtocol.DataArray = [self returnImageViewArray:ImageArray assetArray:assetArray indexArray:indexArray];
                [_collectionView reloadData];
                [_loadingLabel removeFromSuperview];
                self.title = [NSString stringWithFormat:@"%@ (%lu)",self.title,(unsigned long)collectionProtocol.DataArray.count];
                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:collectionProtocol.DataArray.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
            });
        } ];
    });
}

-(NSMutableArray *)returnImageViewArray:(NSMutableArray*)returnarray assetArray:(NSMutableArray*)assetArray indexArray:(NSMutableArray *)indexArray{
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for(UIImage *image in returnarray){
        NSInteger index = [returnarray indexOfObject:image];
        ZZH_PHCellImageView *CellImageView = [[ZZH_PHCellImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        CellImageView.delegate = collectionProtocol;
        CellImageView.image = image;
        CellImageView.tag = [[indexArray objectAtIndex:index] intValue];
        CellImageView.asset = [assetArray objectAtIndex:index];
        for(ZZH_PHCellImageView *judgmentOrExitView in self.cachePhotoArray){
            if([CellImageView.asset.localIdentifier isEqualToString:judgmentOrExitView.asset.localIdentifier]){
                CellImageView.selectButton.selected = YES;
                break;
            }
        }
        [imageArray addObject:CellImageView];
    }
    return imageArray;
}

#pragma mark ::::::::::::setDelegate:::::::::::::::
-(void)setDelegate:(id)delegate{
    listVC = (ZZH_PHShowListController*)delegate;
}



#pragma mark ::::::::::::::pushDelegateMethod:::::::::::::::::
-(void)collectionViewPush:(UIViewController *)nextViewContoller withParameter:(id)indexParameter{
    ZZH_PHShowPhotoController *showViewController = (ZZH_PHShowPhotoController*)nextViewContoller;
    
    [self.navigationController pushViewController:showViewController animated:YES];
}

-(void)refreshNumLabel{
    
    NSString *numString = [NSString stringWithFormat:@"%lu",(unsigned long)self.cachePhotoArray.count];
    if([numString integerValue]==0){
        _showCurrentSelectNumLabel.hidden = YES;
    }else {
        _showCurrentSelectNumLabel.text = numString;
        _showCurrentSelectNumLabel.hidden = NO;
    }
    [UIView animateWithDuration:0.1 animations:^{
        _showCurrentSelectNumLabel.transform =CGAffineTransformScale(_showCurrentSelectNumLabel.transform, 1.3, 1.3);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            _showCurrentSelectNumLabel.transform=CGAffineTransformIdentity;
        }];
    }];
}


@end
