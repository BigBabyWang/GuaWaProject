//
//  AccountListCell.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/20.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "AccountListCell.h"
#import "MAccount.h"
@interface AccountListCell()
{
    __weak IBOutlet UILabel *lab_title;
    __weak IBOutlet UILabel *lab_date;
    __weak IBOutlet UILabel *lab_money;
    
}

@end

@implementation AccountListCell
- (instancetype)initWithTableview:(UITableView *)tableView{
    
    AccountListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AccountListCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"AccountListCell" bundle:nil] forCellReuseIdentifier:@"AccountListCell"];
        NSArray *cellArr = [[NSBundle mainBundle] loadNibNamed:@"AccountListCell" owner:self options:nil];
        cell = (AccountListCell *)[cellArr objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//红 255 155 155
//绿 28 185 50
- (void)setAccount:(MAccount *)account{
    lab_title.text = account.des;
    lab_date.text = account.memberNickname;
    if (account.status == 1) {
        lab_money.text = [NSString stringWithFormat:@"+%ld金币",account.amount];
        lab_money.textColor = COLOR(255, 155, 155, 1);
    }else{
        lab_money.text = [NSString stringWithFormat:@"-%ld金币",account.amount];;
        lab_money.textColor = COLOR(28, 185, 50, 1);
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
