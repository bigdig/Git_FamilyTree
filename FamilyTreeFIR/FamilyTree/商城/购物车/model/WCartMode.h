//
//  WCartMode.h
//  FamilyTree
//
//  Created by 王子豪 on 16/8/2.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCararray;
@interface WCartMode : NSObject

@property (nonatomic, strong) NSArray<WCararray *> *CarArray;

@end
@interface WCararray : NSObject

@property (nonatomic, copy) NSString *CoName;

@property (nonatomic, copy) NSString *Cover;

@property (nonatomic, copy) NSString *CoprName;

@property (nonatomic, assign) NSInteger CoprMoney;

@property (nonatomic, assign) NSInteger CoprActpri;

@property (nonatomic, assign) NSInteger ShId;

@property (nonatomic, copy) NSString *CoprData;

@property (nonatomic, assign) NSInteger CoprCount;

@property (nonatomic, copy) NSString *CoprUnit;

@property (nonatomic, assign) NSInteger CoId;

@end

