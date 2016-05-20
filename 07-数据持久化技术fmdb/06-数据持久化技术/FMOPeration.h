//
//  FMOPeration.h
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QYstudent;
@interface FMOPeration : NSObject
//单例对象
+(instancetype)shareHandel;
//插入一条数据
-(BOOL)insertModeForDB:(QYstudent *)mode;
//删除一条数据
-(BOOL)deleteDataForID:(int)Id;
//更新数据
-(BOOL)updateDataForMode:(NSDictionary *)mode;
//查询单个数据
-(NSMutableArray*)selectOneDataForId:(int)Id;
//查询多个数据
-(NSMutableArray*)selectMoreOneDataForAll;


@end
