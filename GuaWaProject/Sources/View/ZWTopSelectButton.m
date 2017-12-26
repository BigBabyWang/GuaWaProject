//
//  ZWTopSelectButton.m
//  ZWSlideView
//
//  Created by 流年划过颜夕 on 16/5/6.
//  Copyright © 2016年 流年划过颜夕. All rights reserved.
//
#define topSelectBtnInitHeight self.topSelectBtnHeight
#define topSelectBtnInitY (self.frame.size.height-topSelectBtnInitHeight)/2

#import "ZWTopSelectButton.h"

@interface ZWTopSelectButton()
@property (nonatomic, assign) float topSelectBtnHeight;
@property (nonatomic) CGRect defultFrame;
@property (nonatomic) CGRect selectFrame;
@end
@implementation ZWTopSelectButton

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        UILabel *labName=[[UILabel alloc]init];
        labName.textAlignment=NSTextAlignmentCenter;
        labName.textColor=[UIColor redColor];
        labName.font=[Utility getFont:13];;
        CALayer *layer = [CALayer layer];
        layer.frame = labName.bounds;
        layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
        layer.shadowOffset = CGSizeMake(0, 6);
        //    layer.shadowOpacity = 0.35;
        //这里self表示当前自定义的view
        [labName.layer addSublayer:layer];
        [self addSubview:labName];
        self.labName=labName;
        UIImage * normalImg = [UIImage imageNamed:@"btn_fenye"];
        UIImage * selectImg = [UIImage imageNamed:@"btn_fenye_xuanzhong"];
        [self setImage:normalImg forState:(UIControlStateNormal)];
        [self setImage:selectImg forState:(UIControlStateSelected)];
        self.backgroundColor = [UIColor clearColor];
        
        frame.size.width = [UIImage imageNamed:@"btn_fenye"].size.width;
        self.frame = frame;
        self.defultFrame = frame;
        frame.size.width = selectImg.size.width;
        self.selectFrame = frame;
//        UIView *viewLine=[[UIView alloc]init];
//        viewLine.backgroundColor=[UIColor redColor];
//        [self addSubview:viewLine];
//        self.viewLine=viewLine;
        
    }
    return self;
}

-(float)topSelectBtnHeight
{
    if ([self.delegata respondsToSelector:@selector(topSelectBtnSpacingBarHeightInZWTopSelectButtonDelegate:)]) {
       return  [self.delegata topSelectBtnSpacingBarHeightInZWTopSelectButtonDelegate:self];
    }else
    {
        return 30;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.labName.frame=CGRectMake(0, -2, self.frame.size.width, self.frame.size.height);
//    float  topSelectBtnInithalfHeight =topSelectBtnInitHeight/2;
//    self.viewLine.frame=CGRectMake(self.frame.size.width-1, self.frame.size.height/2-topSelectBtnInithalfHeight, 1, topSelectBtnInitHeight);
}
-(void)setState:(BOOL)state{
    self.selected = state;
    if (state==YES) {
        CGRect frame = self.selectFrame;
        [self animation:frame];
        self.labName.textColor= [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.9];
        self.userInteractionEnabled=NO;
        self.labName.font=[Utility getFont:14];
    }else if(state==NO)
    {
        self.frame = self.defultFrame;
//        if (self.defultFrame.size.width != self.frame.size.width) {
//            [self animation:self.defultFrame];
//        }
        self.labName.textColor=[UIColor colorWithRed:162/255.0f green:175/255.0f blue:242/255.0f alpha:0.9];
        self.userInteractionEnabled=YES;
        self.labName.font=[Utility getFont:13];
    }
}
-(void)animation:(CGRect)frame{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = frame;
    }];
}
@end

