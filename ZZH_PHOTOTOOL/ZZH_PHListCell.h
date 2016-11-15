//
//  ZZH_PHListCell.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/28.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZH_PHListCell : UITableViewCell

@property (nonatomic , strong)UIImageView *celImageView;

@property (nonatomic , strong)UILabel *AlbumNameLabel;

@property (nonatomic , strong)UILabel *numbersLabel;

-(void)setImage:(UIImage*)image AndAlbumName:(NSString *)titleString  AndNum:(NSString*)num;

@end
