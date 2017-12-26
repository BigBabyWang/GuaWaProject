//
//  AccountListCell.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/20.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAccount;
@interface AccountListCell : UITableViewCell
@property (nonatomic, strong)MAccount * account;
- (instancetype)initWithTableview:(UITableView *)tableView;

@end
