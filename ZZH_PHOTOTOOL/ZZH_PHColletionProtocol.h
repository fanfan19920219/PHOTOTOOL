//
//  ZZH_PHColletionProtocol.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZH_PH_Header.h"


@interface ZZH_PHColletionProtocol : NSObject<UICollectionViewDelegate,UICollectionViewDataSource,CellImageSelectButtonMethodDelegate,setCachesArrayDelegate>
//PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];

@property (nonatomic , assign)id<CollectionViewPushDelegate> delegate;

@property (nonatomic , assign)id<setCachesArrayDelegate> dataSource;

@property (nonatomic , strong)NSMutableArray* DataArray;

@property (nonatomic , strong)NSMutableArray *cacheArray;


@end
