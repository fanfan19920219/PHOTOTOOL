//
//  Header.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define ZZHPHOTOTOOL [ZZH_PH_GetAssetObject Default]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(rgb) [UIColor colorWithRed:(rgb)/255.0 green:(rgb)/255.0 blue:(rgb)/255.0 alpha:1.0]
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

#import "ZZH_PH_Protocol.h"
#import "SVProgressHUD.h"

/**
 *  project File
 */
#import "ZZH_PHShowListController.h"
#import "ZZH_PHShowPhotoController.h"
#import "ZZH_PHPhotoViewController.h"

#import "ZZH_PHShowScrollview.h"
#import "ZZH_PHCellImageView.h"
#import "ZZH_PHListCell.h"

#import "ZZH_PHListModel.h"
#import "ZZH_PH_GetAssetObject.h"
#import "ZZH_PHColletionProtocol.h"
#import "ListTableViewDataSource.h"
#import "ListTableViewDelegate.h"

#endif /* Header_h */
