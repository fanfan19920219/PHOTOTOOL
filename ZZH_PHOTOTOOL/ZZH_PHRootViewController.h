//
//  ZZH_PHRootViewController.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZH_PH_Header.h"
#import "ZZH_PH_Protocol.h"

@interface ZZH_PHRootViewController : UIViewController

@property (nonatomic , assign)id <ZZH_ReturnDelegate>delegate;

@property (nonatomic,strong)void(^returnblock)(NSMutableArray *returnArray);

@property (nonatomic ,assign)NSInteger maxIndex;
/**
 *  单利方法
 *
 *  @return ZZH_PHlibraryTool
 */
+(instancetype)ShareZZH_PHlibraryTool;

-(void)getSelectPhotoWithReturnBlock:(void(^)(NSMutableArray* returnArray))returnBlock;



@end
