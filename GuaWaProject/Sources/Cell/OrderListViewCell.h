//
//  OrderListViewCell.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/20.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MOrder;
@interface OrderListViewCell : UITableViewCell
@property (nonatomic, strong)MOrder * order;
- (instancetype)initWithTableview:(UITableView *)tableView;
@end
