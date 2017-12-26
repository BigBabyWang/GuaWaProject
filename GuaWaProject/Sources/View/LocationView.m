//
//  LocationView.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/24.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "LocationView.h"
#import "MLocation.h"
@interface LocationView()
{
    
    __weak IBOutlet UITextField *tf_userPhone;
    __weak IBOutlet UITextField *tf_des;
    
    __weak IBOutlet UIButton *btn_province;
    __weak IBOutlet UIButton *btn_city;
    __weak IBOutlet UIButton *btn_region;
    
    __weak IBOutlet UIButton *btn_default;
    __weak IBOutlet UIButton *btn_delete;
    __weak IBOutlet UIButton *btn_addsave;
    __weak IBOutlet UIButton *btn_edisave;
}
@property (weak, nonatomic) IBOutlet UITextField *tf_userName;
@property (nonatomic, strong)NSArray * areaBtnArr;
@end
@implementation LocationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
}
- (void)setLocation:(MLocation *)location{
    _tf_userName.text = location.linkName;
    tf_userPhone.text = location.mobile;
    tf_des.text = location.detail;
    NSArray * locationArr = [location.area componentsSeparatedByString:@" "];
    for (int i = 0; i < locationArr.count; i++) {
        NSString * str = locationArr[i];
        UIButton * btn = self.areaBtnArr[i];
        [btn setTitle:str forState:(UIControlStateNormal)];
    }
    btn_default.selected = location.isDefault;
    
    btn_addsave.hidden = YES;
    btn_edisave.hidden = NO;
    btn_delete.hidden = NO;
    
    _location = location;
}
- (IBAction)btnCloseAction:(UIButton *)sender {
    self.cancel();
}
- (IBAction)btnSaveAction:(UIButton *)sender {
    NSMutableDictionary * locationDic = [NSMutableDictionary new];
    locationDic[@"optype"] = @(sender.tag);
    locationDic[@"linkName"] = _tf_userName.text;
    locationDic[@"mobile"] = tf_userPhone.text;
    locationDic[@"area"] = [NSString stringWithFormat:@"%@%@%@%@%@",btn_province.titleLabel.text,@" ",btn_city.titleLabel.text,@" ",btn_region.titleLabel.text];
    locationDic[@"detail"] = tf_des.text;
    locationDic[@"isDefault"] = @(btn_default.selected);
    locationDic[@"memberId"] = @(1);//[AppShareContext sharedAppShareContext].mUser.uid;
    if (sender.tag == 2) {
        locationDic[@"addressId"] = @(_location.addressId);
    }
    self.save(locationDic);
}
- (IBAction)btnDeleteAction:(UIButton *)sender {
}
- (IBAction)btnChooseLocation:(id)sender {
    TLPopupWindow * apopup = [[TLPopupWindow alloc]initWithPickerViewcompleteBlock:^(NSString *pro, NSString *city, NSString *region) {
        NSLog(@"%@%@%@",pro,city,region);
        [btn_province setTitle:pro forState:(UIControlStateNormal)];
        [btn_city setTitle:city forState:(UIControlStateNormal)];
        [btn_region setTitle:region forState:(UIControlStateNormal)];
    }];
    [apopup show:YES];
}

- (NSArray *)areaBtnArr{
    if (!_areaBtnArr) {
        _areaBtnArr = [[NSArray alloc]initWithObjects:btn_province,btn_city,btn_region, nil];
    }
    return _areaBtnArr;
}
@end
