//
//  ViewController.m
//  ZZH_PHOTOTOOL
//
//  Created by M-SJ077 on 2016/11/15.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import "ViewController.h"
#import "ZZH_PHRootViewController.h"

@interface ViewController ()<ZZH_ReturnDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    openButton.frame = CGRectMake( 100, 100, 100, 60);
    [openButton addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    openButton.backgroundColor = [UIColor redColor];
    openButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    [openButton setTitle:@"打开相册" forState:UIControlStateNormal];
    [self.view addSubview:openButton];
    
    
}

-(void)openPhoto{
    ZZH_PHRootViewController *vc = [[ZZH_PHRootViewController alloc]init];
    vc.delegate = self;
    vc.maxIndex = 9;
    
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
