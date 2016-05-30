//
//  LGJProductsVC.m
//  TableViewTwoLevelLinkageDemo
//
//  Created by 劉光軍 on 16/5/30.
//  Copyright © 2016年 [SinaWeibo:劉光軍_Shine    简书:劉光軍_   ]. All rights reserved.
//

#import "LGJProductsVC.h"

@interface LGJProductsVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *productsTableView;
@property(nonatomic, strong)NSArray *productsArr;
@property(nonatomic, strong)NSArray *sectionArr;
@property(nonatomic, assign)BOOL isScrollUp;//是否是向上滚动
@property(nonatomic, assign)CGFloat lastOffsetY;//滚动即将结束时scrollView的偏移量

@end

@implementation LGJProductsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _isScrollUp = false;
    _lastOffsetY = 0;
    
    [self configData];
    [self createTableView];
    
    // Do any additional setup after loading the view.
}

- (void)configData {
    
    if (!_sectionArr) {
        NSArray *numArr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十"];
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            NSString *tmpStr = [NSString stringWithFormat:@"第%@类", numArr[i]];
            [tmpArr addObject:tmpStr];
        }
        _sectionArr = tmpArr;
    }
    if (!_productsArr) {
        _productsArr = @[@"鞋子",@"衣服",@"化妆品",@"饮用水",@"副食品",@"小吃",@"鞋子",@"衣服",@"化妆品",@"饮用水"];
    }
}

- (void)createTableView {
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.25, 64, self.view.frame.size.width * 0.75, self.view.frame.size.height)];
    
    self.productsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.productsTableView.delegate = self;
    self.productsTableView.dataSource = self;
    self.productsTableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:self.productsTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _productsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [_sectionArr objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_productsArr objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(willDisplayHeaderView:)] != _isScrollUp) {
        [self.delegate willDisplayHeaderView:section];
    }
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didEndDisplayingHeaderView:)] && _isScrollUp) {
        [self.delegate didEndDisplayingHeaderView:section];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"_lastOffsetY : %f,scrollView.contentOffset.y : %f", _lastOffsetY, scrollView.contentOffset.y);
    _isScrollUp = _lastOffsetY < scrollView.contentOffset.y;
    _lastOffsetY = scrollView.contentOffset.y;
    NSLog(@"______lastOffsetY: %f", _lastOffsetY);
}

#pragma mark - 一级tableView滚动时 实现当前类tableView的联动
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath {
    
    [self.productsTableView selectRowAtIndexPath:([NSIndexPath indexPathForRow:0 inSection:indexPath.row]) animated:YES scrollPosition:UITableViewScrollPositionTop];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
