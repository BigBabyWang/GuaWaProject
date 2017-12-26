//
//  MyLocationCell.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MyLocationCell.h"
#import "MLocation.h"
@interface MyLocationCell()
{
    
    __weak IBOutlet UILabel *lab_userName;
    __weak IBOutlet UILabel *lab_phone;
    __weak IBOutlet UIImageView *image_select;
    
    __weak IBOutlet UIView *locationView;
    
}
@property (nonatomic, strong)UILabel * lab_location;
@end
@implementation MyLocationCell
- (instancetype)initWithTableview:(UITableView *)tableView{
    
    MyLocationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyLocationCell"];
    if (!cell) {
        NSArray *cellArr = [[NSBundle mainBundle] loadNibNamed:@"MyLocationCell" owner:self options:nil];
        cell = [cellArr objectAtIndex:0];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)setLocation:(MLocation *)location{
    lab_userName.text = location.linkName;
    lab_phone.text = location.mobile;
    image_select.hidden = !location.isDefault;
    self.lab_location.text = [NSString stringWithFormat:@"%@%@",location.area,location.detail];
    _location = location;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    UILabel * lab = [[UILabel alloc]initWithFrame:locationView.bounds];
    lab.numberOfLines = 0;
    lab.font = [Utility getFont:12];
    lab.textColor = [UIColor colorWithHex:@"4E6EC2"];
    [locationView addSubview:lab];
    self.lab_location = lab;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
