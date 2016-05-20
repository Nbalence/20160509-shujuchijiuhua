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
#import "FMOPeration.h"
@interface UpdateViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
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
- (IBAction)selectImageAction:(UITapGestureRecognizer *)sender {
    //调用图册
    UIImagePickerController *pickerConterller=[[UIImagePickerController alloc] init];
    //设置调用类型 图册，相册，相机
    pickerConterller.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    //设置代理
    pickerConterller.delegate=self;
    [self presentViewController:pickerConterller animated:YES completion:nil];
    
}


- (IBAction)UpdateAction:(id)sender {
#if 0
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
#endif
    //参数存到字典里
    NSDictionary *parmaters=@{@"ID":@(_tfID.text.intValue),@"name":_tfName.text,@"age":@(_tfAge.text.intValue),@"phone":_tfPhone.text,@"icon":UIImageJPEGRepresentation(_iconImageView.image, 1)};
    //更新操作
    if ([[FMOPeration shareHandel] updateDataForMode:parmaters]) {
        NSLog(@"========chenggong");
    }
    
    
    
    
}

#pragma UIImagePickerControllerdelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
   //选择图片,获取图片
   UIImage *image= info[UIImagePickerControllerOriginalImage];
    
    __weak UIImageView *tempImage=_iconImageView;
    [picker dismissViewControllerAnimated:YES completion:^{
        tempImage.image=image;
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
 //取消
    [picker dismissViewControllerAnimated:YES completion:nil];
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
