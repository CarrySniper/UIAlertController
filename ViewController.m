//
//  ViewController.m
//  UIAlertController代替UIALertView和UIActionSheet
//
//  Created by 陈家庆 on 15-3-5.
//  Copyright (c) 2015年 shikee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationItem.title = @"UIAlertController的创建与使用";
    self.view.backgroundColor = [UIColor grayColor];
    
    
    /*
     *** UIAlertController的样式 preferredStyle:
     
        1.UIAlertControllerStyleAlert样式代替UIALertView
        2.UIAlertControllerStyleActionSheet样式代替UIActionSheet
     
     */
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController" preferredStyle:UIAlertControllerStyleAlert];

    //弹出视图 使用UIViewController的方法
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    /*
     *** 添加按钮
     
     Title:标题名称（按钮名）
     style:样式（按钮样式类型，3种（Cancel、Default、Destructive）） 
     handler:处理程序（点击按钮执行的代码）
     
     */
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"默认Default" style:UIAlertActionStyleDefault handler:nil];
    
//    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"重置Destructive" style:UIAlertActionStyleDestructive handler:nil];
    
    [alertController addAction:cancelAction];
    [alertController addAction:defaultAction];
//    [alertController addAction:resetAction];
    
    

//    UIAlertAction *getAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        UITextField *login = alertController.textFields[0];
//        UITextField *password = alertController.textFields[1];
//        [self.view endEditing:YES];
//        
//        NSLog(@"登陆：%@  密码：%@",login.text,password.text);
//    }];
//    
//    [alertController addAction:getAction];
    
    
    //添加文本输入框，以登录和密码对话框示例
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"登录";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"密码";
        textField.secureTextEntry = YES;
    }];
    
    //如果要监听UITextField开始、结束、改变状态，则需要添加监听代码
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"添加监听代码";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }];

}

- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        
        //下标为2的是添加了监听的 也是最后一个 alertController.textFields.lastObject
        UITextField *listen = alertController.textFields[2];
        
        //限制，如果listen输入长度要限制在5个字内，否则不允许点击默认Default键
        //当UITextField输入字数超过5个是按钮变灰色enabled为NO
        UIAlertAction *action = alertController.actions.lastObject;
        action.enabled = listen.text.length <= 5;
    }
}
//暂时没发现有什么作用
- (void)didEnterBackground:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
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
