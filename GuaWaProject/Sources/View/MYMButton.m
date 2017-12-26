//
//  MYMButton.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/11/27.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MYMButton.h"
#import "UIButton+touch.h"
#define HR ScreenWidth/667.0f
#define WR ScreenHeight/375.0f
@interface MYMButton ()

@end

@implementation MYMButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//代码创建按钮时
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//
//        [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
//        [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//        [self addTarget:self action:@selector(dragInside:) forControlEvents:UIControlEventTouchDragInside];
//    }
//    return self;
//}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(dragInside:) forControlEvents:UIControlEventTouchDragInside];
}


//模块选择
- (void)touchUpInside:(UIButton *)button{
    [UIView animateWithDuration:0.1 animations:^{
        [self setAnimateScale:1.0];
    }completion:^(BOOL finished) {
        
        if (button.tag == 0) {
            
        }else if (button.tag == 1){
            
        }else{
            
        }
        
    }];

}

- (void)dragInside:(UIButton *)button{
    
    [UIView animateWithDuration:0.1 animations:^{
        
        [self setAnimateScale:1.0];
        
    }];
}

- (void)touchDown:(UIButton *)button{
    
    [UIView animateWithDuration:0.1 animations:^{
        [self setAnimateScale:0.9];
    }];
}

-(void)setAnimateScale:(CGFloat)scale{
    self.transform = CGAffineTransformMakeScale(scale, scale);
}
@end
