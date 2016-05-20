//
//  NSUserDefalutsViewController.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "NSUserDefalutsViewController.h"

@interface NSUserDefalutsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation NSUserDefalutsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.读取本地数据
    [self loadData];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//加载数据
-(void)loadData{
   //1.获取NsuersDefault 单例对象
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    _mySlider.value=[defaults floatForKey:@"value"];
    _mySwitch.on=[defaults boolForKey:@"on"];
    _myTextField.text=[defaults objectForKey:@"desc"];
}

//保存数据
-(void)saveData{
   //1.获取NSuserDefaults单例对象
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    /*
     1.该对象封装了plist文件的读写操作方法
     2.改文件存储在沙盒 libary/preferences 目录下，存储名称Bundld identfier.plist
     */
    [defaults setFloat:_mySlider.value forKey:@"value"];
    [defaults setBool:_mySwitch.on forKey:@"on"];
    [defaults setObject:_myTextField.text forKey:@"desc"];
    //同步到plist文件 Yes
    //[defaults synchronize];
    
}

- (IBAction)saveData:(UIButton *)sender {
    //保存数据
    [self saveData];
    
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
