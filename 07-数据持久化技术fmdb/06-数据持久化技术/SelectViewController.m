//
//  SelectViewController.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "SelectViewController.h"
#import "QYstudent.h"
#import "BDOperation.h"
#import "FMOPeration.h"

@interface SelectViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfID;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray *dataArr;
@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark --多个数据查询
- (IBAction)selectAllAction:(id)sender {
#if 0    //执行单个查询操作
    _dataArr=[[BDOperation shareDBHandel] selectMoreOneDataForAll];
    if(_dataArr){
        //刷新UI
        [_myTableView reloadData];
    }
#endif
    _dataArr=[[FMOPeration shareHandel] selectMoreOneDataForAll];
    if (_dataArr) {
        [_myTableView reloadData];
    }

    
}
#pragma mark 单个数据查询
- (IBAction)selectOneAction:(id)sender {
#if 0   //执行单个查询操作
    _dataArr=[[BDOperation shareDBHandel] selectOneDataForId:_tfID.text.intValue];
    if(_dataArr){
    //刷新UI
        [_myTableView reloadData];
    }
#endif
    _dataArr=[[FMOPeration    shareHandel] selectOneDataForId:_tfID.text.intValue];
    if (_dataArr) {
        [_myTableView reloadData];
    }
    
}

#pragma mark DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identfier];
    }
    //赋值操作
    QYstudent *mode=_dataArr[indexPath.row];
    cell.imageView.image=[UIImage imageWithData:mode.icon];
    cell.textLabel.text=[NSString stringWithFormat:@"ID:%d               name:%@",mode.ID,mode.name];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"age:%d               phone:%@",mode.age,mode.phone];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
