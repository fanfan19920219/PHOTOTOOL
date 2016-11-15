//
//  ZZH_PH_GetAssetObject.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZZH_PH_GetAssetObject.h"

@implementation ZZH_PH_GetAssetObject
ZZH_PH_GetAssetObject *DefaultObj;

+(instancetype)Default{
    if(DefaultObj ==nil){
        DefaultObj = [[ZZH_PH_GetAssetObject alloc]init];
    }
    return DefaultObj;
}

-(void)getAlbumListWithReturnBlock:(void(^)(NSMutableArray *returnListArray,NSMutableArray* returnAssetsArray))ReturnBlock{
    
    PHFetchResult<PHAssetCollection *> *assetCollectionsSystem = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
//    NSInteger index = [assetCollections countOfAssetsWithMediaType:PHAssetMediaTypeAudio];
//    NSLog(@"index --- %ld",(long)index);
    
    //array
    NSMutableArray *listArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *collectionArray =[[NSMutableArray alloc]init];
    
    
    for (PHAssetCollection *assetCollection in assetCollectionsSystem) {
        [collectionArray addObject:assetCollection];
        
        NSLog(@"asset.name -- %@",assetCollection.localizedTitle);
        [self addModel:assetCollection WithArray:listArray];
        //[self enumerateAssetsInAssetCollection:assetCollection original:NO];
    }
    
    PHFetchResult<PHAssetCollection *> *assetCollectionsIndex = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollectionsIndex) {
        if(![collectionArray containsObject:assetCollection]){
            [collectionArray addObject:assetCollection];
            [self addModel:assetCollection WithArray:listArray];
        }
        //[self enumerateAssetsInAssetCollection:assetCollection original:NO];
    }
    NSLog(@"array.count --- %lu",(unsigned long)collectionArray.count);
//    for(PHAssetCollection *assetCollection in collectionArray){
//        NSLog(@"name --- %@  count -----",assetCollection.localizedTitle);
//        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
//        NSLog(@"assets.count --- %lu",(unsigned long)assets.count);
//    }
    ReturnBlock(listArray,collectionArray);
}

-(void)addModel:(PHAssetCollection *)assetCollection WithArray:(NSMutableArray*)array{
    ZZH_PHListModel *model = [[ZZH_PHListModel alloc]init];
    model.PhotoName = [NSString stringWithFormat:@"%@",assetCollection.localizedTitle];
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    NSLog(@"assets.count --- %lu",(unsigned long)assets.count);
    model.PhotoCount = [NSString stringWithFormat:@"%lu",(unsigned long)assets.count];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:assets.lastObject targetSize:CGSizeZero contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        model.Photoimage = result;
        NSLog(@"image --- %@",result);
        [array addObject:model];
    }];
}

- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original withReturnBlock:(void(^)(NSMutableArray *ImageArray,NSMutableArray *assetArray ,NSMutableArray *indexArray))returnBlock{
    NSLog(@"相簿名:%@  -- %lu", assetCollection.localizedTitle,(unsigned long)assetCollection.estimatedAssetCount);
    
    NSMutableArray *ImageArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *assetArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    
    options.networkAccessAllowed = YES;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *PHoptions = [[PHFetchOptions alloc] init];
    PHoptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:PHoptions];
    
    NSLog(@"assets.count --- %lu",(unsigned long)assets.count);
    //    PHAsset *asset =[assets objectAtIndex:10];
    //    NSLog(@"asst.location ---- %@",asset.localIdentifier);
    for (PHAsset *asset in assets) {
        
       // NSLog(@"asset.localIdentifier --- %@",asset.localIdentifier);
        
        // 是否要原图
        CGSize size = original ? CGSizeMake(SCREEN_WIDTH*0.87, SCREEN_HEIGHT*0.87) : CGSizeZero;
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
             {
                 if(result){
                     [ImageArray addObject:result];
                     [assetArray addObject:asset];
                     NSString *index = [NSString stringWithFormat:@"%lu",(unsigned long)[assets indexOfObject:asset]];
                     [indexArray addObject:index];
                 }
                 if(assets.count ==ImageArray.count){
                     NSLog(@"遍历完成----- count ----%lu",(unsigned long)ImageArray.count);
                         returnBlock(ImageArray,assetArray,indexArray);
                 }
             }];
    }
}



- (void)enumerateAssetsInAssetPhotoPath:(NSMutableArray<NSString*> *)pathArray original:(BOOL)original withReturnBlock:(void(^)(NSMutableArray *ImageArray,NSMutableArray *assetArray ,NSMutableArray *indexArray))returnBlock{
    
    NSMutableArray *ImageArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *assetArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    
    options.networkAccessAllowed = YES;
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *PHoptions = [[PHFetchOptions alloc] init];
    PHoptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithLocalIdentifiers:pathArray options:PHoptions];
    
    NSLog(@"assets.count --- %lu",(unsigned long)assets.count);

    for (PHAsset *asset in assets) {
        CGSize size = original ? CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH) : CGSizeZero;
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
         {
             if(result){
                 [ImageArray addObject:result];
                 [assetArray addObject:asset];
                 NSString *index = [NSString stringWithFormat:@"%lu",(unsigned long)[assets indexOfObject:asset]];
                 [indexArray addObject:index];
             }
             if(assets.count ==ImageArray.count){
                 
                 returnBlock(ImageArray,assetArray,indexArray);
             }
         }];
    }
}



- (void)get_Aphoto:(PHAsset *)asset original:(BOOL)original withReturnBlock:(void(^)(UIImage  *returnImage))returnBlock{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.synchronous = NO;
    NSLog(@"asset.localIdentifier --- %@",asset.localIdentifier);
    // 是否要原图
    CGSize size = original ? CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) : CGSizeZero;
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:
     PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary *
                                                               _Nullable info)
    {
             NSLog(@"%@ ---- info ----- ", result);
                 returnBlock(result);
         }];
}


@end
