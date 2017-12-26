//
//  MyCardsCell.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/21.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MyCardsCell.h"
#import "MCard.h"
@interface MyCardsCell()
{
    __weak IBOutlet UIImageView *image_select;
    __weak IBOutlet UILabel *lab_validity;
    __weak IBOutlet UIImageView *bg_cards;
    
}

@end

@implementation MyCardsCell
- (instancetype)initWithCollectionView:(UICollectionView *)collectionview indexPath:(NSIndexPath *)indexPath{
    
    MyCardsCell * cell = [collectionview dequeueReusableCellWithReuseIdentifier:@"MyCardsCell" forIndexPath:indexPath];
    if (!cell) {
        NSArray *cellArr = [[NSBundle mainBundle] loadNibNamed:@"MyCardsCell" owner:self options:nil];
        cell = [cellArr objectAtIndex:0];
    }
    return cell;
}

- (void)setCard:(MCard *)card{
    image_select.hidden = !card.isSelect;
    bg_cards.image = card.type == 1?[UIImage imageNamed:@"btn_monthly_card"]:[UIImage imageNamed:@"btn_weekly_card"];
    lab_validity.text = card.cardNo;
    _card = card;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
