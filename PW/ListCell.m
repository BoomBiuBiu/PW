//
//  ListCell.m
//  PW
//
//  Created by chinasoftHSBC on 2017/6/15.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _accountLB=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 150, 20)];
        _accountLB.adjustsFontSizeToFitWidth=YES;
        _accountLB.font=[UIFont systemFontOfSize:18];
        [self addSubview:_accountLB];
        
        _passwordLB=[[UILabel alloc]initWithFrame:CGRectMake(20, 35, 150, 20)];
        _passwordLB.adjustsFontSizeToFitWidth=YES;
        _passwordLB.font=[UIFont systemFontOfSize:16];
        _passwordLB.textColor=[UIColor redColor];
        [self addSubview:_passwordLB];

        _nameLB=[[UILabel alloc]initWithFrame:CGRectMake(170, 0, 200, 65)];
        _nameLB.adjustsFontSizeToFitWidth=YES;
        _nameLB.font=[UIFont boldSystemFontOfSize:18];
        [self addSubview:_nameLB];
        

     }
    return self;
}



@end
