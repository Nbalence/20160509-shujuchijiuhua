//
//  UpdateViewController.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "UpdateViewController.h"
#import "QYstudent.h"
#import "BDOperation.h"

@interface UpdateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfID;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfAge;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)UpdateAction:(id)sender {
  //1.数据存储到mode
    QYstudent *mode=[[QYstudent alloc] init];
    mode.ID=_tfID.text.intValue;
    mode.name=_tfName.text;
    mode.phone=_tfPhone.text;
    mode.age=_tfAge.text.intValue;
    mode.icon=UIImageJPEGRepresentation(_iconImageView.image, 1);
  //2.执行操作
    if ([[BDOperation shareDBHandel] updateDataForMode:mode]) {
        UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"提示" message:@"更新成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alter addAction:action];
        [self presentViewController:alter animated:YES completion:nil];

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
