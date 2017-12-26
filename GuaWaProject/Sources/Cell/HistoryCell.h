//
//  HistoryCell.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/25.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHistory;
@interface HistoryCell : UITableViewCell
@property (nonatomic, strong)MHistory * history;
- (instancetype)initWithTableview:(UITableView *)tableView;
@end
