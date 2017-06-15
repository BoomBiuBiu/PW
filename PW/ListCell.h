//
//  ListCell.h
//  PW
//
//  Created by chinasoftHSBC on 2017/6/15.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UILabel *accountLB;
@property(nonatomic,strong)UILabel *passwordLB;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
