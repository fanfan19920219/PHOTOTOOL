//
//  ZZH_PHShowListController.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZH_PH_Header.h"

@interface ZZH_PHShowListController : UIViewController
/**
 *  当前已经选中的照片的数组
 */
@property (nonatomic , strong)NSMutableArray*cachePhotoArray;
/**
 *  最大可以选择的照片数
 */
@property (nonatomic , assign)NSInteger maxIndex;

@property (nonatomic , assign)id <ZZH_ReturnDelegate>delegate;
/**
 *  暂时没有用
 */
@property (nonatomic , assign)void(^returnBlock)(NSMutableArray*array);
/**
 *  返回已经选中的照片(高清)的方法
 */
-(void)ReturnBlock;
@end
