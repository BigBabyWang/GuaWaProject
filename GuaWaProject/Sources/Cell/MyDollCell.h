//
//  MyDollCell.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/21.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGood;
@interface MyDollCell : UICollectionViewCell
@property (nonatomic, strong)MGood * good;
- (instancetype)initWithCollectionView:(UICollectionView *)collectionview indexPath:(NSIndexPath *)indexPath;
@end
