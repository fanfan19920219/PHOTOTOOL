//
//  ZZH_PHShowPhotoController.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/20.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZZH_PHShowPhotoController.h"
#import "ZZH_PH_Header.h"

#define ZEOR 0

@interface ZZH_PHShowPhotoController ()<UIScrollViewDelegate>
{
    UIImageView *_imageView;
    ZZH_PHShowScrollview *_showScrollView;
    BOOL _orLoading;
}
@end

@implementation ZZH_PHShowPhotoController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self create_Views];
    
}

-(void)create_Views {
    [SVProgressHUD showWithStatus:@"照片加载中"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _showScrollView = [[ZZH_PHShowScrollview alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _showScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.ImageArray.count, 0);
    if(self.ImageArray.count ==self.currentIndex){
        _showScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (self.currentIndex+1), 0);
    }
    _showScrollView.contentOffset = CGPointMake(SCREEN_WIDTH *self.currentIndex, 0);
    _showScrollView.pagingEnabled = YES;
    _showScrollView.delegate = self;
    [self.view addSubview:_showScrollView];
    
    _imageView = [[UIImageView alloc]initWithImage:self.showImage];
    _imageView.userInteractionEnabled = YES;
    _imageView.frame = CGRectMake((self.currentIndex*SCREEN_WIDTH)+5, 0, SCREEN_WIDTH-10, (SCREEN_WIDTH - 10)*(self.showImage.size.height/self.showImage.size.width));
    _imageView.center = CGPointMake(_imageView.center.x, SCREEN_HEIGHT/2);
    [self addGesture:_imageView];
    [_showScrollView addSubview:_imageView];
    
    NSMutableArray *pathArray = [[NSMutableArray alloc]init];
    for(ZZH_PHCellImageView *PathimageView in self.ImageArray){
        [pathArray addObject:PathimageView.asset.localIdentifier];
    }
    
    [[ZZH_PH_GetAssetObject Default]enumerateAssetsInAssetPhotoPath:pathArray original:YES withReturnBlock:^(NSMutableArray *ImageArray, NSMutableArray *assetArray, NSMutableArray *indexArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for(UIView *deleteView in [_showScrollView subviews]){
                [deleteView removeFromSuperview];
            }
            if(self.ImageArray.count ==self.currentIndex){
                [_showScrollView addSubview:_imageView];
            }
            int local_x_index = ZEOR;
            for(UIImage *reimage in ImageArray){
                UIImageView *imageView = [[UIImageView alloc]initWithImage:reimage];
                imageView.frame = CGRectMake(5+(local_x_index*SCREEN_WIDTH), 0,SCREEN_WIDTH-10, (SCREEN_WIDTH-10)*(reimage.size.height/reimage.size.width));
                imageView.center = CGPointMake(imageView.center.x, SCREEN_HEIGHT/2);
                imageView.userInteractionEnabled = YES;
                [self addGesture:imageView];
                [_showScrollView addSubview:imageView];
                local_x_index++;
            }
        });
    }];
}


-(void)showSVP{
    [SVProgressHUD showWithStatus:@"照片加载中"];
}

-(void)addGesture:(UIView*)gesTureView{
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [gesTureView addGestureRecognizer:singleRecognizer];
}

-(void)tap:(UITapGestureRecognizer*)gesture{
    self.navigationController.navigationBar.hidden = !self.navigationController.navigationBar.hidden;
    [UIView animateWithDuration:0.3 animations:^{
        if(self.navigationController.navigationBar.hidden ==YES){
            self.view.backgroundColor = [UIColor blackColor];
        }else{
            self.view.backgroundColor = [UIColor whiteColor];
        }
    } completion:^(BOOL finished) {
        
    }];
}

-(void)setOriginImage:(UIImage*)image{
    if(_orLoading==YES){
        [SVProgressHUD dismiss];
    }
    _imageView.image = image;
    _orLoading = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}
@end
