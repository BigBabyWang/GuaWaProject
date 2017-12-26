//
//  MyDollCell.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/21.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MyDollCell.h"
#import "ShadowLabel.h"
#import "MGood.h"
@interface MyDollCell()
{
    __weak IBOutlet ShadowLabel *lab_goodsName;
    __weak IBOutlet UIImageView *image_select;
    __weak IBOutlet UIImageView *image_goods;
    __weak IBOutlet UILabel *lab_score;
    
}
@end
@implementation MyDollCell
- (instancetype)initWithCollectionView:(UICollectionView *)collectionview indexPath:(NSIndexPath *)indexPath{

    MyDollCell * cell = [collectionview dequeueReusableCellWithReuseIdentifier:@"MyDollCell" forIndexPath:indexPath];
    if (!cell) {
        NSArray *cellArr = [[NSBundle mainBundle] loadNibNamed:@"MyDollCell" owner:self options:nil];
        cell = [cellArr objectAtIndex:0];
    }
    return cell;
}

- (void)setGood:(MGood *)good{
    image_select.hidden = !good.isSelect;
    
    [image_goods sd_setImageWithURL:(good.thumbnail?[good.thumbnail getURLInstance]:[NSURL URLWithString:CESHI_IMAGE]) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            UIImage * bg_image = [UIImage imageNamed:@"baisedi"];
            image_goods.image = [Utility imageWithImage:image scaledToSize:bg_image.size];
            image_goods.layer.cornerRadius = 15.0f;
            image_goods.layer.masksToBounds = YES;
        }
    }];
    lab_score.text = StringWithInterger(good.guawa);
    lab_goodsName.text = good.title;
    _good = good;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
