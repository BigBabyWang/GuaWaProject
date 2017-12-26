//
//  MyLocationCell.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLocation;
@interface MyLocationCell : UITableViewCell
@property (nonatomic, strong)MLocation * location;
- (instancetype)initWithTableview:(UITableView *)tableView;
@end
