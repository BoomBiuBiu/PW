//
//  DetailViewController.m
//  PW
//
//  Created by chinasoftHSBC on 2017/6/15.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "DetailViewController.h"
#define ACCOUNTARRAY    @"accountArray"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<<返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    self.view.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    [self createTF];
    [self createLB];
    [self createBtn];

    
    

}
-(void)back{
    
    if([_passWordTF.text isEqualToString:_passWord]&&[_accountTF.text isEqualToString:_account]&&[_nameTF.text isEqualToString:_name]){
        //没修改 直接返回
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (_passWordTF.text.length==0&&_accountTF.text .length==0&&_nameTF.text.length==0) {
        //新建的没写 直接返回

        [self.navigationController popViewControllerAnimated:YES];
        return;

    }
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您已经修改,但未保存" message:@"确定返回吗?" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"cacel");
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ok");

        [self.navigationController popViewControllerAnimated:YES];

    }];

    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];

}

-(void)createTF{
    
    _nameTF=[[UITextField alloc]initWithFrame:CGRectMake(20, 80, self.view.frame.size.width-40, 40)];
    _nameTF.textColor=[UIColor grayColor];
    _nameTF.font=[UIFont boldSystemFontOfSize:18];
    _nameTF.placeholder=@"网站";
    _nameTF.text=_name;
    _nameTF.layer.masksToBounds=YES;
    _nameTF.layer.cornerRadius=8;
    _nameTF.layer.borderWidth=0.5;
    _nameTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    _nameTF.borderStyle = UITextBorderStyleRoundedRect;
    
    _nameTF.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_nameTF];

    
    _accountTF=[[UITextField alloc]initWithFrame:CGRectMake(20, 80+40+20, self.view.frame.size.width-40, 40)];
    _accountTF.textColor=[UIColor grayColor];
    _accountTF.font=[UIFont boldSystemFontOfSize:18];
    _accountTF.placeholder=@"账号";
    _accountTF.text=_account;
    _accountTF.layer.masksToBounds=YES;
    _accountTF.layer.borderWidth=0.5;
    _accountTF.layer.cornerRadius=8;
    _accountTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    _accountTF.borderStyle = UITextBorderStyleRoundedRect;
    _accountTF.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_accountTF];
    
    
    _passWordTF=[[UITextField alloc]initWithFrame:CGRectMake(20, 80+40*2+20*2, self.view.frame.size.width-40, 40)];
    _passWordTF.placeholder=@"密码";
    _passWordTF.text=_passWord;
    _passWordTF.layer.masksToBounds=YES;
    _passWordTF.layer.cornerRadius=8;
    _passWordTF.layer.borderWidth=0.5;
    _passWordTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    _passWordTF.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTF.textColor=[UIColor grayColor];
    _passWordTF.font=[UIFont boldSystemFontOfSize:18];
    _passWordTF.backgroundColor=_accountTF.backgroundColor;
    [self.view addSubview:_passWordTF];

    
    
}
-(void)createLB{
    
    _tipLB=[[UILabel alloc]initWithFrame:CGRectMake(20, _passWordTF.frame.origin.y+40+20, self.view.frame.size.width-40, 20)];
    _tipLB.text=@"网站、账号或密码不能为空!";
    _tipLB.textColor=[UIColor redColor];
    _tipLB.hidden=YES;

    [self.view addSubview:_tipLB];
    
}


-(void)createBtn{
    
    _saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(40, _tipLB.frame.origin.y+40+40, self.view.frame.size.width-80, 40)];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    _saveBtn.layer.masksToBounds=YES;
    _saveBtn.layer.cornerRadius=10;

    [_saveBtn addTarget:self action:@selector(saveAccount:) forControlEvents:UIControlEventTouchUpInside];
    [_saveBtn setBackgroundColor:[UIColor colorWithRed:3/255.0 green:174/255.0 blue:240/255.0 alpha:1]] ;
    [self.view addSubview:_saveBtn];
    
    
}
-(void)saveAccount:(UIButton*)btn{
    
    
    if(_accountTF.text.length==0||_passWordTF.text.length==0||_nameTF.text.length==0){
        
        _tipLB.hidden=NO;
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *array = [NSMutableArray arrayWithArray:[defaults objectForKey:ACCOUNTARRAY]];
    
    NSMutableArray *mutArray=[NSMutableArray arrayWithArray:array];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:_accountTF.text, @"account",_passWordTF.text ,@"passWord",_nameTF.text, @"name",nil];
    
    
    NSInteger index=-1;
    if(_account.length>0){//修改
        for(int i=0;i<mutArray.count;i++)
        {
            NSDictionary *dic=[mutArray objectAtIndex:i];
            if ([[dic valueForKey:@"account"] isEqualToString:_account]) {

                index=i;
                break;
            }
        }
        
        [mutArray replaceObjectAtIndex:index withObject:dic];//替换
        
    }else{//新建
        
        if (![mutArray containsObject:dic]) {
            [mutArray addObject:dic];
        }

    }
    
    
    [defaults setObject:mutArray forKey:ACCOUNTARRAY];
    
    [self.navigationController popViewControllerAnimated:YES];

    
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
