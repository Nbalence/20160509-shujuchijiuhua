//
//  InsertViewController.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "InsertViewController.h"
#import "BDOperation.h"
#import "QYstudent.h"
@interface InsertViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfAge;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation InsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchSaveAction:(id)sender {
    //1.给mode赋值
    QYstudent *mode=[[QYstudent alloc] init];
    mode.name=_tfName.text;
    mode.age=_tfAge.text.intValue;
    mode.phone=_tfPhone.text;
    mode.icon=UIImageJPEGRepresentation(_iconImageView.image, 1);
    //2.执行插入语句al
    if ([[BDOperation shareDBHandel] insertModeForDB:mode]) {
        NSLog(@"=====chenggong");
    }
    
    
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
