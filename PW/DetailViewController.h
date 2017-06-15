//
//  DetailViewController.h
//  PW
//
//  Created by chinasoftHSBC on 2017/6/15.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property(nonatomic,copy) NSString *account;
@property(nonatomic,copy) NSString *passWord;
@property(nonatomic,copy) NSString *name;

@property(nonatomic,strong)UITextField *nameTF;
@property(nonatomic,strong)UITextField *accountTF;
@property(nonatomic,strong)UITextField *passWordTF;
@property(nonatomic,strong)UILabel *tipLB;
@property(nonatomic,strong)UIButton *saveBtn;

@end
