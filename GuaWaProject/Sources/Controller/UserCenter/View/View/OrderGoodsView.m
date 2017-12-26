//
//  OrderGoodsView.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/20.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "OrderGoodsView.h"
#import "MGood.h"
@interface OrderGoodsView()

@property (nonatomic, strong)NSMutableArray * goodsArr;
@end

@implementation OrderGoodsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)setImageArr:(NSArray *)imageArr{
    if (imageArr.count != _imageArr.count) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        _goodsArr = [[NSMutableArray alloc]initWithCapacity:imageArr.count];
        for (int i = 0; i < MIN(imageArr.count, 9); i++) {
            MGood * good = imageArr[i];
            
            UIImageView * goodImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_goods"]];
            
            [goodImage sd_setImageWithURL:(good.thumbnail?[good.thumbnail getURLInstance]:[NSURL URLWithString:CESHI_IMAGE]) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (image) {
                    goodImage.image = [Utility imageWithImage:image scaledToSize:goodImage.bounds.size];
                    goodImage.layer.cornerRadius = 5.0f;
                    goodImage.layer.masksToBounds = YES;
                    goodImage.layer.borderWidth = 1.5;
                    goodImage.layer.borderColor = [UIColor colorWithHex:@"ffb32f"].CGColor;
                }
            }];
            goodImage.frame = CGRectMake( i*(CGRectGetWidth(goodImage.bounds)+16.0f), 0, CGRectGetWidth(goodImage.bounds), CGRectGetHeight(goodImage.bounds));
            [self addSubview:goodImage];
            [_goodsArr addObject:goodImage];
            
        }
    }
    _imageArr = imageArr;
}
@end
