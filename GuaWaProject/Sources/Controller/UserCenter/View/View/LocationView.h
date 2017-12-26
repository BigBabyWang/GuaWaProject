//
//  LocationView.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/24.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLocation;
@interface LocationView : UIView

@property (nonatomic, strong)MLocation * location;
@property (nonatomic, copy) void (^cancel)(void);
@property (nonatomic, copy) void (^save)(NSDictionary*);
@end
