//
//  BDOperation.h
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//  操作数据库

#import <Foundation/Foundation.h>
@class QYstudent;
@interface BDOperation : NSObject
//单例对象
+(instancetype)shareDBHandel;
//插入数据库
-(BOOL)insertModeForDB:(QYstudent *)mode;
//删除一条数据
-(BOOL)deleteDataForID:(int)Id;
//更新数据
-(BOOL)updateDataForMode:(QYstudent *)mode;
//查询单个数据
-(NSMutableArray*)selectOneDataForId:(int)Id;
//查询多个数据
-(NSMutableArray*)selectMoreOneDataForAll;

@end
