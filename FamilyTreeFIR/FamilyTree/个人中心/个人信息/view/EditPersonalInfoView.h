//
//  EditPersonalInfoView.h
//  FamilyTree
//
//  Created by 姚珉 on 16/6/15.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModel.h"
@interface EditPersonalInfoView : UIScrollView
-(void)reloadEditPersonalInfoData:(LoginModel *)loginModel;
@end
