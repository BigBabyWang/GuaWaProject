//
//  MyPropCell.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/21.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MProp;
@interface MyPropCell : UICollectionViewCell
@property (nonatomic, strong)MProp * prop;
- (instancetype)initWithCollectionView:(UICollectionView *)collectionview indexPath:(NSIndexPath *)indexPath;
@end
