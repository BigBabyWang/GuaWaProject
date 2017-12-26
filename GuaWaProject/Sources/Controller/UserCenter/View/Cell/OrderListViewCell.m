//
//  OrderListViewCell.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/20.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "OrderListViewCell.h"
#import "OrderGoodsView.h"
#import "MOrder.h"
#import "MGood.h"
@interface OrderListViewCell()
{
    
    __weak IBOutlet UILabel *lab_orderName;
    __weak IBOutlet OrderGoodsView *goodsView;
    __weak IBOutlet UILabel *lab_goodsNum;
    __weak IBOutlet UILabel *lab_sendTime;
    
}

@end

@implementation OrderListViewCell
- (instancetype)initWithTableview:(UITableView *)tableView{
    
    OrderListViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListViewCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"OrderListViewCell" bundle:nil] forCellReuseIdentifier:@"OrderListViewCell"];
        NSArray *cellArr = [[NSBundle mainBundle] loadNibNamed:@"OrderListViewCell" owner:self options:nil];
        cell = [cellArr objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setOrder:(MOrder *)order{
    
    lab_orderName.hidden = order.goodsList.count == 1?NO:YES;
    if (order.goodsList.count == 1) {
        MGood * good = order.goodsList[0];
        lab_orderName.text = good.title;
    }
    
    goodsView.imageArr = order.goodsList;
    lab_goodsNum.text = [NSString stringWithFormat:@"%ld",order.goodsNum];
    NSLog(@"imageNum : %ld",order.goodsNum);
    lab_sendTime.text = order.applySendTime;
    
    _order = order;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
