//
//  MHelp.h
//  MatchLive
//
//  Created by xmrk on 16/5/24.
//  Copyright © 2016年 mjBear. All rights reserved.
//


@class MParam;

@interface MHelp : NSObject

/**
 "add_time" = 1464081794;
 "article_id" = 6;
 content = 6666666666666666;
 place = 6;
 status = 1;
 title = "\U6b64\U4e3a\U94b1\U5305\U9875\U5e2e\U52a9";
 */

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *content;

@property (assign, nonatomic) NSInteger article_id;

@property (assign, nonatomic) NSInteger place;

@property (assign, nonatomic) NSInteger status;

@property (assign, nonatomic) double add_time;

@end

@interface MHelpList : NSObject

@property(nonatomic,strong)NSMutableArray *helpList;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)MParam *param;

@end
