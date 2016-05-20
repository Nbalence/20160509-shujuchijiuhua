//
//  DeleteViewController.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "DeleteViewController.h"
#import "BDOperation.h"
#import "FMOPeration.h"

@interface DeleteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfID;

@end

@implementation DeleteViewController
- (IBAction)deleteAction:(id)sender {
    //执行删除操作
#if 0
    if ([[BDOperation shareDBHandel] deleteDataForID:_tfID.text.intValue]) {
        UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"提示" message:@"删除成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
        [alter addAction:action];
        [self presentViewController:alter animated:YES completion:nil];
    };
#endif
    if ([[FMOPeration shareHandel] deleteDataForID:_tfID.text.intValue]) {
        NSLog(@"删除成功");
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
