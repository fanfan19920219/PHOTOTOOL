//
//  ZZH_PHPhotoViewController.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZH_PH_Header.h"

@interface ZZH_PHPhotoViewController : UIViewController
@property (nonatomic , strong)PHAssetCollection *assetCollection;
@property (nonatomic , strong)NSMutableArray*cachePhotoArray;
@property (nonatomic , assign)void(^returnBlock)(NSMutableArray*array);


-(void)setDelegate:(id)delegate;

@end
