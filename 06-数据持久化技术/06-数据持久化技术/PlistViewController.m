//
//  PlistViewController.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/5.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "PlistViewController.h"
#define  FileName @"student.plist"

@interface PlistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *ageTf;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UISwitch *sexSwitch;

//文件存储路径
@property(strong,nonatomic)NSString *filePath;

@end

@implementation PlistViewController

-(NSString *)filePath{
    if (_filePath) {
        return _filePath;
    }
    //1.获取沙盒路径
    NSString *docmumentsPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //2.创建文件夹
      //2.1合并文件夹路径 文件夹名字 “doc”
      NSString *direPath=[docmumentsPath stringByAppendingPathComponent:@"doc"];
      //2.2创建文件夹
       NSError *error;
      if (![[NSFileManager defaultManager]createDirectoryAtPath:direPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        return nil;
     }
    //3.创建文件
     //3.1合并文件路径
    _filePath=[direPath stringByAppendingPathComponent:FileName];

    return _filePath;
    
}



#pragma mark 读取本地缓存文件
-(void)loadData{
    //读取文件
    NSDictionary *valueDic=[[NSDictionary alloc] initWithContentsOfFile:self.filePath];
    
    //给UI赋值
    _nameTf.text=valueDic[@"name"];
    _ageTf.text=[NSString stringWithFormat:@"%ld",[valueDic[@"age"] integerValue]];
    NSData *data=valueDic[@"icon"];
    UIImage *image=[UIImage imageWithData:data];
    _iconImage.image=image;
    _sexSwitch.on=[valueDic[@"sex"] boolValue];

}
#pragma mark 存储数据
-(BOOL)saveData{
    
    NSDictionary *temDic=@{@"name":_nameTf.text,@"age":@(_ageTf.text.integerValue),@"sex":@(_sexSwitch.on),@"icon":UIImageJPEGRepresentation([UIImage imageNamed:@"2.jpg"], 1)};
 
    return [temDic writeToFile:self.filePath atomically:YES];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     //1.读取本地缓存文件
      [self loadData];
    // Do any additional setup after loading the view.
}

- (IBAction)touchsave:(id)sender {
    //保存文件
    if ([self saveData]) {
        NSLog(@"========save Ok!");
    }

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
