//
//  ZZH_PHRootViewController.m
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/19.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ZZH_PHRootViewController.h"
#import "ZZH_PH_Header.h"


@interface ZZH_PHRootViewController (){
    ZZH_PHShowListController *showListVC;
}
@property (nonatomic , assign)void(^returnBlock)(NSMutableArray*array);
@end

@implementation ZZH_PHRootViewController

ZZH_PHRootViewController *selfVC;

+(instancetype)ShareZZH_PHlibraryTool{
    if (selfVC==nil) {
        selfVC =[[ZZH_PHRootViewController alloc]init];
    }
    return selfVC;
}

-(void)getSelectPhotoWithReturnBlock:(void(^)(NSMutableArray* returnArray))returnBlock{
    
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self controllerInitMethod];
}


-(void)controllerInitMethod{
    //  NavgatioViewController
    
    __weak typeof(self) weakSelf = self;
    
    showListVC = [[ZZH_PHShowListController alloc]init];
    showListVC.cachePhotoArray = [[NSMutableArray alloc]init];
    showListVC.delegate = self.delegate;
    showListVC.maxIndex  = self.maxIndex;
    
    UINavigationController *nav   = [[UINavigationController alloc]initWithRootViewController:showListVC];
    nav.view.frame                    = self.view.frame;
    nav.view.backgroundColor      = [UIColor whiteColor];
    nav.navigationBar.barTintColor = RGBA(63, 130, 139, 1);
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [nav.navigationBar setTitleTextAttributes:
     
     
  @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    
    
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    
    
}


@end
