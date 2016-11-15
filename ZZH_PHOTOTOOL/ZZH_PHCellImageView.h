//
//  ZZH_PHCellImageView.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "ZZH_PH_Header.h"

@interface ZZH_PHCellImageView : UIImageView

@property (nonatomic , strong)NSString *path;

@property (nonatomic ,strong)PHAsset *asset;

@property (nonatomic , strong)UIButton *selectButton;

@property (nonatomic ,assign)id<CellImageSelectButtonMethodDelegate>delegate;

-(void)setSelectButtonFrame;

@end
