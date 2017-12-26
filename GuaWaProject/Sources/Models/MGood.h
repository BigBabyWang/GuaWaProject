//
//  MGood.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MGoodsList : NSObject
@property (nonatomic, strong)NSArray * goodsList;
@end
/*
 {
 "goodsId":2,
 "thumbnail":null,
 "title":"蒙妮妮",
 "guawa":1,
 "coin":1,
 "diamond":null
 },
 */
@interface MGood : NSObject
@property (nonatomic, strong)NSString * title;
@property (nonatomic, strong)NSString * thumbnail;

@property (nonatomic, assign)NSInteger goodsId;
@property (nonatomic, assign)NSInteger guawa;
@property (nonatomic, assign)NSInteger coin;
@property (nonatomic, assign)NSInteger diamond;

@property (nonatomic, assign)BOOL isSelect;//表格专用属性


@end
