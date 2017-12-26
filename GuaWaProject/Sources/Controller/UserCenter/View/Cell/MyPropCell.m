//
//  MyPropCell.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/21.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MyPropCell.h"
#import "MProp.h"
@interface MyPropCell ()
{
    __weak IBOutlet UILabel *lab_propName;
    __weak IBOutlet UILabel *lab_activitionTime;
    __weak IBOutlet UILabel *lab_invalidTime;
    __weak IBOutlet UIImageView *image_prop;
    __weak IBOutlet UIImageView *image_propstatus;
    
}
@end

@implementation MyPropCell
- (instancetype)initWithCollectionView:(UICollectionView *)collectionview indexPath:(NSIndexPath *)indexPath{
    
    MyPropCell * cell = [collectionview dequeueReusableCellWithReuseIdentifier:@"MyPropCell" forIndexPath:indexPath];
    if (!cell) {
        NSArray *cellArr = [[NSBundle mainBundle] loadNibNamed:@"MyPropCell" owner:self options:nil];
        cell = [cellArr objectAtIndex:0];
    }
    return cell;
}

- (void)setProp:(MProp *)prop{
    lab_propName.text = prop.nickname;
    lab_activitionTime.text = @"2017-12-21 20:46";//这两个时间服务端暂时没有返回
    lab_invalidTime.text = @"2017-12-21 20:46";
    [image_prop sd_setImageWithURL:[NSURL URLWithString:CESHI_IMAGE] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            UIImage * bg_image = [UIImage imageNamed:@"bg_goods"];
            image_prop.image = [Utility imageWithImage:image scaledToSize:bg_image.size];
            image_prop.layer.cornerRadius = 5.0f;
            image_prop.layer.masksToBounds = YES;
            image_prop.layer.borderWidth = 1.5;
            image_prop.layer.borderColor = [UIColor colorWithHex:@"ffb32f"].CGColor;
        }
    }];
    image_propstatus.image = prop.cardStatus == 3?[UIImage imageNamed:@"icon_used"]:[UIImage imageNamed:@"icon_Shipped"];
    _prop = prop;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
