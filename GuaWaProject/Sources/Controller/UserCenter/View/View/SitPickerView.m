//
//  SitPickerView.m
//  MatchLive
//
//  Created by xmrk on 16/5/18.
//  Copyright © 2016年 mjBear. All rights reserved.
//

#import "SitPickerView.h"

#define kProvComponent 0
#define kCityComponent 1
#define kRegionComponent 2


@implementation SitPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.subviews awakeFromNib];
    self.pickerView.backgroundColor = [UIColor grayColor];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    //读取plist文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"citydata" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    _provinceList = arr;
    _cityList = _provinceList[0][@"citylist"];
    _regionList = _cityList[0][@"arealist"];
    [self creatToolBar];
}

- (void)creatToolBar{
    UIBarButtonItem *btnItem1 = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(leftAction:)];
    
    UIBarButtonItem *btnItem2 = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(rightAction:)];
    
    UIBarButtonItem *btnPlace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                             target:nil
                                                                             action:nil];
    
    NSMutableArray *items = [NSMutableArray arrayWithObjects:btnItem1,btnPlace,btnItem2, nil];
    [self.toolBar setItems:items animated:YES];
    self.toolBar.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:.65];
    
    
}
#pragma mark - pickerView delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == kProvComponent) {
        return _provinceList.count;
    }else if (component == kCityComponent){
        return _cityList.count;
    }else{
        return _regionList.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case kProvComponent:
            return [[_provinceList objectAtIndex:row] objectForKey:@"provinceName"];
            break;
        case kCityComponent:
            return [[_cityList objectAtIndex:row] objectForKey:@"cityName"];
            break;
        case kRegionComponent:
            return [[_regionList objectAtIndex:row] objectForKey:@"areaName"];
            break;
        default:
            return @"";
            break;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == kProvComponent) {
        _component_province = row;
        _cityList = _provinceList[row][@"citylist"];
        _regionList = _cityList[0][@"arealist"];
        [pickerView reloadComponent:kCityComponent];
        [pickerView reloadComponent:kRegionComponent];
        [pickerView selectRow:0 inComponent:kCityComponent animated:YES];
        [pickerView selectRow:0 inComponent:kRegionComponent animated:YES];
    }
    if (component == kCityComponent) {
        _component_city = row;
        _regionList = _cityList[row][@"arealist"];
        [pickerView reloadComponent:kRegionComponent];
        [pickerView selectRow:0 inComponent:kRegionComponent animated:YES];
        
    }
    if (component == kRegionComponent) {
        _component_region = row;
    }
    
}
#pragma mark - 获取选中的地址
- (void)getSelectAddress{
    self.province = _provinceList[_component_province][@"provinceName"];
    self.city = _cityList[_component_city][@"cityName"];
    self.region = _regionList[_component_region][@"areaName"];

}

- (IBAction)leftAction:(id)sender
{
    if (self.cancelAction) {
        self.cancelAction();
    }
    
}
- (IBAction)rightAction:(id)sender
{
    [self getSelectAddress];
    if (self.ensureAction) {
        self.ensureAction(self.province,self.city,self.region);
    }
    
}
- (void)show:(BOOL)animated{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
}


@end
