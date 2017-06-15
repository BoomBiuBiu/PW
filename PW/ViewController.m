//
//  ViewController.m
//  PW
//
//  Created by chinasoftHSBC on 2017/6/15.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "ListCell.h"
#define ACCOUNTARRAY    @"accountArray"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    BOOL isShow;
}
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
    [_tableView reloadData];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:3/255.0 green:174/255.0 blue:240/255.0 alpha:1];
    UIColor* color = [UIColor whiteColor];
    
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes= dict;
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"显示/隐藏" style:UIBarButtonItemStylePlain target:self action:@selector(show)];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

    self.title=@"密码管理器";
    
     [self createTableView];
    
    
 
}
-(void)show{
    
    if(!isShow){
        isShow=YES;
        [_tableView reloadData];
    }else{
        isShow=NO;
        [_tableView reloadData];

    }
    
}

-(void)getData{
    
    _dataArray=[NSMutableArray array];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    _dataArray = [NSMutableArray arrayWithArray:[defaults objectForKey:ACCOUNTARRAY]];

}
-(void)createTableView{
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
   _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.backgroundColor= [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.view addSubview:_tableView];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
     return _dataArray.count+1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 66;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArray.count==indexPath.row) {
        
        static NSString *AddCell = @"AddCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]  initWithStyle: UITableViewCellStyleDefault reuseIdentifier:AddCell];
            cell.backgroundColor=[UIColor whiteColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.textAlignment=1;
        cell.textLabel.text=@"添加新密码";
        cell.textLabel.font=[UIFont boldSystemFontOfSize:18];
        
        return cell;

    }

    
    static NSString *CellName = @"ListCell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName];
    if (!cell) {
        cell = [[ListCell alloc]  initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellName];
        cell.backgroundColor=[UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

    }
 
    NSDictionary *accountDic=[_dataArray objectAtIndex:indexPath.row];
    cell.nameLB.text=[accountDic valueForKey:@"name"];
    cell.accountLB.text=[accountDic valueForKey:@"account"];
    if (isShow) {
        cell.passwordLB.text=[accountDic objectForKey:@"passWord"];
    }else{
        cell.passwordLB.text=@"***";

    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detail=[[DetailViewController alloc]init];
    if (indexPath.row<_dataArray.count) {
        NSDictionary *accountDic=[_dataArray objectAtIndex:indexPath.row];
        
        detail.name=[accountDic valueForKey:@"name"];
        detail.account=[accountDic valueForKey:@"account"];
        detail.passWord=[accountDic valueForKey:@"passWord"];
        
    }
    
    [self.navigationController pushViewController:detail animated:YES];

    
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=_dataArray.count) {
        
        return UITableViewCellEditingStyleDelete;

    }
    return UITableViewCellEditingStyleNone;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {

        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除吗?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
 
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

            
            [_dataArray removeObjectAtIndex:indexPath.row];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:_dataArray forKey:ACCOUNTARRAY];
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

        }];
        
        
        [alertController addAction:cancelAction];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
