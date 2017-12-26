//
//  SitPickerView.h
//  MatchLive
//
//  Created by xmrk on 16/5/18.
//  Copyright © 2016年 mjBear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SitPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,copy)void(^cancelAction)(void);
@property (nonatomic,copy)void(^ensureAction)(NSString *pro,NSString *city,NSString *region);
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSString *province;   //省
@property (strong, nonatomic) NSString *city;       //市
@property (strong, nonatomic) NSString *region;       //市
@property (strong, nonatomic) NSArray *provinceList;//省数组
@property (strong, nonatomic) NSArray *cityList;    //市数组
@property (strong, nonatomic) NSArray *regionList;    //市数组
@property (assign, nonatomic) NSInteger component_province;  //标识province齿轮
@property (assign, nonatomic) NSInteger component_city;  //标识city齿轮
@property (assign, nonatomic) NSInteger component_region;  //标识region齿轮

@end
