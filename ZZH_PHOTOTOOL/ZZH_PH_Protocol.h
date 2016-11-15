//
//  ZZH_PH_Protocol.h
//  ZZH_PHLibraryTool
//
//  Created by M-SJ077 on 16/9/20.
//  Copyright © 2016年 zhangzhihua. All rights reserved.
//

#ifndef ZZH_PH_Protocol_h
#define ZZH_PH_Protocol_h
@class ZZH_PHCellImageView;

@protocol ZZH_ReturnDelegate <NSObject>

@optional

-(void)ZZH_PHoto_ReturnArray:(NSMutableArray *)returnArray;

@end

@protocol ListTableViewPushDelegate <NSObject>

@optional
-(void)tableViewPush:(UIViewController *)nextViewContoller withParameter:(id)indexParameter;

@end
@protocol CollectionViewPushDelegate <NSObject>

@optional
-(void)collectionViewPush:(UIViewController *)nextViewContoller withParameter:(id)indexParameter;

-(void)refreshNumLabel;

@end

@protocol CellImageSelectButtonMethodDelegate <NSObject>

@optional
-(void)cellSelectButtonClick:(UIButton*)sender andZZH_PHCellImageView:(ZZH_PHCellImageView*)imageView andIndex:(NSInteger)index orClick:(BOOL)orClick;

@end

@protocol setCachesArrayDelegate <NSObject>

@optional
-(void)addOrDelete:(UIButton*)judgmentButton withObject:(id)object AndButton:(UIButton*)sender;

@end

#endif /* ZZH_PH_Protocol_h */
