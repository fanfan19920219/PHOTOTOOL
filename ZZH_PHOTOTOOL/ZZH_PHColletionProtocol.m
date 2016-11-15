//
//  ZZH_PHColletionProtocol.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZZH_PHColletionProtocol.h"

@implementation ZZH_PHColletionProtocol
#pragma mark - collectionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.DataArray.count;
}

//collection的代理方法
- (UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ZZH_PHCellImageView *imageView = [self.DataArray objectAtIndex:indexPath.item];
    [imageView setSelectButtonFrame];
    imageView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    [cell.contentView addSubview:imageView];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZH_PHCellImageView *imageView = [self.DataArray objectAtIndex:indexPath.item];
    //[SVProgressHUD showWithStatus:@"加载照片中"];
    collectionView.backgroundColor = [UIColor redColor];
    ZZH_PHShowPhotoController *showPhotoViewController = [[ZZH_PHShowPhotoController alloc]init];
    showPhotoViewController.showImage =imageView.image;
    showPhotoViewController.currentIndex = self.cacheArray.count;
    showPhotoViewController.ImageArray = self.cacheArray;
    for(ZZH_PHCellImageView *judgmentView in self.cacheArray){
        if([judgmentView.asset.localIdentifier isEqualToString:imageView.asset.localIdentifier]){
            showPhotoViewController.currentIndex = [self showPhotoViewControllerIndex:judgmentView];
            break;
        }
    }
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.delegate collectionViewPush:showPhotoViewController withParameter:nil];
    [[ZZH_PH_GetAssetObject Default]get_Aphoto:imageView.asset original:YES withReturnBlock:^(UIImage *returnImage) {
        @try {
            dispatch_async(dispatch_get_main_queue(), ^{
                [showPhotoViewController setOriginImage:returnImage];
            });
        } @catch (NSException *exception) {
        } @finally {
        }
    }];
}

-(NSInteger)showPhotoViewControllerIndex:(ZZH_PHCellImageView*)judgmentImageView{
    NSInteger currentindex = 0;
    for(ZZH_PHCellImageView *ImageView in self.cacheArray){
        if(ImageView.tag>judgmentImageView.tag){
            currentindex++;
        }
    }
    return self.cacheArray.count - currentindex -1;
}

#pragma mark ::::::::::::::::::::selectButtonDelegatemethod:::::::::::::::::::
-(void)cellSelectButtonClick:(UIButton *)sender andZZH_PHCellImageView:(id)imageView andIndex:(NSInteger)index orClick:(BOOL)orClick{
    
    [self.dataSource addOrDelete:sender withObject:imageView AndButton:sender];
    [self.delegate refreshNumLabel];
}


@end
