//
//  ViewController.m
//  FoldSection
//
//  Created by sjpgod on 16/3/17.
//  Copyright © 2016年 sjpgod. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSMutableArray * dataArray;

@property (nonatomic,strong) NSMutableArray * foldArray;

@property (nonatomic,strong) UITableView * tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,20, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStyleGrouped];
    _tableView.backgroundColor  =[UIColor whiteColor];
    /**
     *  设置尾部高度
     */
    _tableView.sectionFooterHeight = 0;
    [self createData];
}

-(void)createData{
    self.dataArray = [NSMutableArray arrayWithObjects:@"2",@"3",@"4",@"5", nil];
    /**
     *  foldArray为标识数组
     */
    self.foldArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    [self createUI];
}
-(void)createUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
/**
 *  根据标识数组判读是否展开分组
 *
 *  @param tableView
 *  @param section
 *
 *  @return 每组cell个数
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (([_foldArray[section] intValue])? [_dataArray[section] intValue] : 0);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    view.backgroundColor = [UIColor cyanColor];
    UILabel * label =[[UILabel alloc]initWithFrame:view.bounds];
    label.text = [NSString stringWithFormat:@"第%ld组",section];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = view.bounds;
    btn.tag = section;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}

-(void)click:(UIButton *)sender{
    
    if ([_foldArray[sender.tag] intValue] == 1 ) {
        [_foldArray replaceObjectAtIndex:sender.tag withObject:@"0"];
    }else{
        [_foldArray replaceObjectAtIndex:sender.tag withObject:@"1"];
    }
    [_tableView reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld组第%ld行",indexPath.section,indexPath.row];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了第%ld组第%ld行",indexPath.section,indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end