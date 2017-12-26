//
//  KnapsackViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/4.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "KnapsackViewController.h"
#import "MyDollCell.h"
#import "MyCardsCell.h"
#import "MyPropCell.h"

#import "MGood.h"
#import "MCard.h"
#import "MProp.h"
@interface KnapsackViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    __weak IBOutlet UIButton *btn_left;
    __weak IBOutlet UIButton *btn_mid;
    __weak IBOutlet UIButton *btn_right;
    
    __weak IBOutlet UIButton *btn_exchange;
    __weak IBOutlet UIButton *btn_useRightnow;
    __weak IBOutlet UIButton *btn_recharge;
    
    __weak IBOutlet UICollectionView *_collectionview;
}
@property (nonatomic, assign)NSInteger type;
//@property (nonatomic, strong)MGoodsList * goodsList;
//@property (nonatomic, strong)MCardsList * cardsList;
//@property (nonatomic, strong)MPropsList * propsList;
@property (nonatomic, strong)NSArray * tableData;


@end

@implementation KnapsackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self uploadMyKnapsack];
}
#pragma mark ------Set UI------
- (void)setUI{
    // 注册cell、sectionHeader、sectionFooter
    [_collectionview registerNib:[UINib nibWithNibName:@"MyDollCell" bundle:nil] forCellWithReuseIdentifier:@"MyDollCell"];
    [_collectionview registerNib:[UINib nibWithNibName:@"MyCardsCell" bundle:nil] forCellWithReuseIdentifier:@"MyCardsCell"];
    [_collectionview registerNib:[UINib nibWithNibName:@"MyPropCell" bundle:nil] forCellWithReuseIdentifier:@"MyPropCell"];
    [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"kheader"];
}
#pragma mark ------Set Data------
- (void)setData{
    self.type = 1;
}
#pragma mark ------HTTP------
- (void)uploadMyKnapsack{
    [self.busEngine getMyKnapsack:_type completionHandler:^(MResult *res) {
        if (res.isSuccess) {
            if (_type == 1) {
                MGoodsList * goodsList = res.retObject;
                self.tableData = goodsList.goodsList;
            }else if (_type == 2){
                MCardsList * cardsList = res.retObject;
                self.tableData = cardsList.cardsList;
            }else{
                MPropsList * propsList = res.retObject;
                self.tableData = propsList.propsList;
            }
            [_collectionview reloadData];
        }
    } errorHandler:^(NSError *error) {
        ERROR_NET
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ------CollectionViewDataSource------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tableData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = nil;
    if (_type == 1) {
        MyDollCell *temCell = [[MyDollCell alloc]initWithCollectionView:collectionView indexPath:indexPath];
        MGood * good = self.tableData[indexPath.row];
        temCell.good = good;
        cell = temCell;
    }else if (_type == 2){
        MyCardsCell *temCell = [[MyCardsCell alloc]initWithCollectionView:collectionView indexPath:indexPath];
        MCard * card = self.tableData[indexPath.row];
        temCell.card = card;
        cell = temCell;
    }else{
        MyPropCell *temCell = [[MyPropCell alloc]initWithCollectionView:collectionView indexPath:indexPath];
        MProp * prop = self.tableData[indexPath.row];
        temCell.prop = prop;
        cell = temCell;
    }
    
    return cell;
    
}
// 设置表头，表尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader] && (_type == 1 || _type == 2))
    {
        UICollectionReusableView *headerView = [_collectionview dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"kheader" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor clearColor];
        
        return headerView;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeZero;
    if (_type == 1 || _type == 2) {
        size = (CGSize){ScreenWidth,44};
    }
    return size;
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 1.0f;
//}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}


#pragma mark ------CollectionViewDelegate------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (_type == 1) {
        MGood * good = self.tableData[indexPath.row];
        good.isSelect = !good.isSelect;
    }else if (_type == 2){
        MCard * card = self.tableData[indexPath.row];
        card.isSelect = !card.isSelect;
    }
    [collectionView reloadData];
}
#pragma mark ------UICollectionViewDelegateFlowLayout------

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize  size = CGSizeZero;
    if (_type == 1) {
        UIImage * image = [UIImage imageNamed:@"bg_myDoll"];
        size = image.size;
        size.width += 5;
    }else if (_type == 2){
        UIImage * image = [UIImage imageNamed:@"btn_monthly_card"];
        size = image.size;
    }else{
        UIImage * image = [UIImage imageNamed:@"bg_orderList"];
        size = image.size;
        size.height += 5;
    }
    
    return size;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (_type == 0) {
        inset = UIEdgeInsetsMake(7,20, 7, 20);
    }else{
        inset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return inset;//分别为上、左、下、右
}

#pragma mark ------Button Action------
- (IBAction)btnNavAction:(UIButton *)sender {
    if (sender.tag == _type) {
        return;
    }
    btn_left.selected = NO;
    btn_mid.selected = NO;
    btn_right.selected = NO;
    sender.selected = YES;
    _type = sender.tag;
    [self uploadMyKnapsack];
    [self changeButtonAnimate];
}
//我的娃娃
- (IBAction)btnMyDollAction:(id)sender {
    [self btnNavAction:sender];
}
//月卡
- (IBAction)btnMyCardsAction:(id)sender {
    [self btnNavAction:sender];
}
//道具记录
- (IBAction)btnPropAction:(id)sender {
    [self btnNavAction:sender];
}
//兑换
- (IBAction)btnExchangeAction:(id)sender {
    
}
//充值
- (IBAction)btnRechargeAction:(id)sender {
    
}
- (void)changeButtonAnimate{
    [UIView animateWithDuration:0.1 animations:^{
        btn_exchange.alpha = 2-_type;
        btn_recharge.alpha = 2-_type;
        btn_useRightnow.alpha = _type-1;
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
