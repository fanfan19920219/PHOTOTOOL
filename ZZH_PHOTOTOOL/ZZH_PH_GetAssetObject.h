//
//  ZZH_PH_GetAssetObject.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "ZZH_PH_Header.h"


@interface ZZH_PH_GetAssetObject : NSObject
/**
 *  返回单例对象
 *
 *  @return selfObject
 */
+(instancetype)Default;

/**
 *   返回相册列表
 *
 *  @param ReturnBlock
 */
-(void)getAlbumListWithReturnBlock:(void(^)(NSMutableArray *returnListArray,NSMutableArray* returnAssetsArray))ReturnBlock;

/**
 *  返回数据集里的照片
 *
 *  @param assetCollection 数据集
 *  @param original           是否原图
 *  @param returnBlock     returnBlock
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original withReturnBlock:(void(^)(NSMutableArray *ImageArray,NSMutableArray *assetArray ,NSMutableArray *indexArray))returnBlock;


/**
 *  返回数据集里的照片
 *
 *  @param pathArray   路径级
 *  @param original       是否原图
 *  @param returnBlock returnBlock
 */
- (void)enumerateAssetsInAssetPhotoPath:(NSMutableArray<NSString*> *)pathArray original:(BOOL)original withReturnBlock:(void(^)(NSMutableArray *ImageArray,NSMutableArray *assetArray ,NSMutableArray *indexArray))returnBlock;


/**
 *  获取单张照片
 *
 *  @param asset       传入的asset
 *  @param original    是否原图
 *  @param returnBlock 返回照片的block
 */
- (void)get_Aphoto:(PHAsset *)asset original:(BOOL)original withReturnBlock:(void(^)(UIImage  *returnImage))returnBlock;

@end
