//
//  ZZH_PHShowPhotoController.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/20.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZH_PHShowPhotoController : UIViewController

@property (nonatomic , strong)UIImage *showImage;
@property (nonatomic , strong)NSMutableArray *ImageArray;
@property (nonatomic , assign)NSInteger currentIndex;

-(void)setOriginImage:(UIImage*)image;

@end
