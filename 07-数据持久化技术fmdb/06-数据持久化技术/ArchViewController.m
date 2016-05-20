//
//  ArchViewController.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ArchViewController.h"
#import "QYmode.h"

#define KfileName @"Mode"
@interface ArchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfAge;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (strong,nonatomic)NSString *filePath;
@end

@implementation ArchViewController

-(NSString *)filePath{
    if (_filePath) {
        return _filePath;
    }
    
    _filePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES)[0] stringByAppendingPathComponent:KfileName];
    return _filePath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.从本地读取数据
    [self loadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//读取数据
-(void)loadData{
    //1.本地nsdatato通过NSKeyedUnarchiver  工具类将二进制数据类反序列化，还原成原来mode
    QYmode *mode=[NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
    if (mode) {
      //UI 赋值
        _IconImageView.image=[UIImage imageWithData:mode.iconData];
        _tfName.text=mode.name;
        _tfAge.text=[NSString stringWithFormat:@"%ld",mode.age];
        _mySwitch.on=mode.sex;
    }
}

//存储数据
-(BOOL)saveData{
   //1.将数据存在mode里
    QYmode *mode=[[QYmode alloc] init];
    mode.iconData=UIImageJPEGRepresentation([UIImage imageNamed:@"2.jpg"], 1);
    mode.name=_tfName.text;
    mode.age=_tfAge.text.integerValue;
    mode.sex=_mySwitch.on;
    
    //2.mode通过NSKeyedArchiver工具类把mode序列化===》NSData 存在本地 filePath
    [NSKeyedArchiver archiveRootObject:mode toFile:self.filePath];

    return YES;
}

- (IBAction)tochSaveData:(id)sender {
    //2.存储数据
    [self saveData];
    
}

@end
