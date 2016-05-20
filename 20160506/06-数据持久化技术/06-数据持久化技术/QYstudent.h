//
//  QYstudent.h
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYstudent : NSObject
@property(nonatomic)int ID;
@property(nonatomic,strong)NSString *name;
@property(nonatomic)int age;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSData *icon;
@end
