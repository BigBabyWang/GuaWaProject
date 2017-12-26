//
//  MyAccountCell.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/20.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MyAccountCell.h"
@interface MyAccountCell()
{
    __weak IBOutlet UILabel *lab_diamond;
    __weak IBOutlet UILabel *lab_coin;
    __weak IBOutlet UILabel *lab_guawa;

}
@end
@implementation MyAccountCell
- (instancetype)initWithTableview:(UITableView *)tableView{
    MyAccountCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyAccountCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"MyAccountCell" bundle:nil] forCellReuseIdentifier:@"MyAccountCell"];
        NSArray *cellArr = [[NSBundle mainBundle] loadNibNamed:@"MyAccountCell" owner:self options:nil];
        cell = (MyAccountCell *)[cellArr objectAtIndex:0];
    }
    [cell reloadData];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)reloadData{
    MUser * user = [AppShareContext sharedAppShareContext].mUser;
    lab_diamond.text = [NSString stringWithFormat:@"%ld颗",user.diamond];
    lab_coin.text = [NSString stringWithFormat:@"%ld枚",user.coin];
    lab_guawa.text = [NSString stringWithFormat:@"%ld个",user.guawa];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
