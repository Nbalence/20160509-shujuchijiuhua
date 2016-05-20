//
//  ViewController.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/5.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#define FileName @"student"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myTextFiled;
//文件路径
@property (strong,nonatomic)NSString *filePath;
@end

@implementation ViewController
-(NSString *)filePath{
    if (_filePath) {
        return _filePath;
    }
   //1.获取存在沙盒的路径
     NSString *documentPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
   //2.documents创建一个文件夹进行管理
    //test
    // 2.1获取文件管理器对象
    NSFileManager *manager=[NSFileManager defaultManager];
    //2.2合并文件夹路径
    NSString *directioryPath=[documentPath stringByAppendingPathComponent:@"test"];
    NSError *error;
    //2.3创建文件夹
    if (![manager createDirectoryAtPath:directioryPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"error====%@",error);
        return nil;
    }
    //3.创建文件
      //3.1合并文件路径
    NSString *path=[directioryPath stringByAppendingPathComponent:FileName];
    //3.2判断文件是否已经存在
    if ([manager fileExistsAtPath:path]) {
        _filePath=path;
        return _filePath;
    }
      //3.3创建文件
    if (![manager createFileAtPath:path contents:nil attributes:0]) {
        NSLog(@"====文件创建失败");
        return nil;
    }
    _filePath=path;
    return _filePath;
}

#pragma mark 读取数据
-(void)loadData{
    _myTextFiled.text=[[NSString alloc] initWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];
}

#pragma mark --保存数据
-(BOOL)saveData{
    NSError *error;
    if (![_myTextFiled.text writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
        NSLog(@"======error====%@",error);
        return NO;
    }
    
    NSLog(@"save ok");
    return YES;
}

- (IBAction)saveAction:(id)sender {
   //调用保存数据
    [self saveData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1初始化读取本地缓存数据
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
