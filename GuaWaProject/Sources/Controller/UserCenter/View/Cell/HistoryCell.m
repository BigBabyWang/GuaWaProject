//
//  HistoryCell.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/25.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "HistoryCell.h"
#import "MHistory.h"
@interface HistoryCell ()
{
    __weak IBOutlet UILabel *lab_userCoin;
    __weak IBOutlet UILabel *lab_roomName;
    __weak IBOutlet UILabel *lab_playTime;
    __weak IBOutlet UILabel *lab_result;
    
    __weak IBOutlet UIImageView *image_good;
    
    __weak IBOutlet UIImageView *image_no_catch;
}

@end
@implementation HistoryCell
- (instancetype)initWithTableview:(UITableView *)tableView{
    
    HistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell"];
    if (!cell) {
        NSArray *cellArr = [[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:self options:nil];
        cell = [cellArr objectAtIndex:0];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setHistory:(MHistory *)history{
    lab_userCoin.text = [NSString stringWithFormat:@"%ld枚",history.coin];
    lab_roomName.text = history.roomTitle;
    lab_playTime.text = @"加载中...";
    lab_result.text = history.tip;
    lab_result.hidden = NO;
    image_no_catch.hidden = YES;
    if (history.status != 1) {
        lab_result.hidden = YES;
        image_no_catch.hidden = NO;
    }
    
    
    [image_good sd_setImageWithURL:(history.thumbnail?[history.thumbnail getURLInstance]:[NSURL URLWithString:CESHI_IMAGE]) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            UIImage * bg_image = [UIImage imageNamed:@"bg_goods"];
            image_good.image = [Utility imageWithImage:image scaledToSize:bg_image.size];
            image_good.layer.cornerRadius = 5.0f;
            image_good.layer.masksToBounds = YES;
            image_good.layer.borderWidth = 1.5;
            image_good.layer.borderColor = [UIColor colorWithHex:@"ffb32f"].CGColor;
        }
    }];
    
    _history = history;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
