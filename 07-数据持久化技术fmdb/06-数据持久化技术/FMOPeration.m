//
//  FMOPeration.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/9.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "FMOPeration.h"
#import "FMDB.h"
#import "QYstudent.h"
#define KDBFILE @"student.db"

@interface FMOPeration ()
//数据库连接对象
@property(strong,nonatomic)FMDatabase *dbBase;
@end

@implementation FMOPeration

-(FMDatabase*)dbBase{
    if (_dbBase) {
        return _dbBase;
    }
    //创建数据库对象
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path=[docPath stringByAppendingPathComponent:KDBFILE];
    _dbBase=[FMDatabase databaseWithPath:path];
    return _dbBase;
}


+(instancetype)shareHandel{
    static dispatch_once_t once;
    static FMOPeration *operation;
    dispatch_once(&once, ^{
       //该方法执行一次
        operation=[[FMOPeration alloc] init];
        //1.打开数据库
        if (![operation.dbBase open]) {
            NSLog(@"========%@",[operation.dbBase lastErrorMessage]);
            return ;
        }
        //2创建表
        [operation   createTable];
    });
    return operation;
}
//创建表
-(BOOL)createTable{
    if (![self.dbBase executeUpdate:@"create table if not exists students (ID integer primary key,name text,age integer,phone text,icon blob)"]) {
        NSLog(@"=====%@",[self.dbBase lastErrorMessage]);
        return NO;
    }
    return YES;
}
-(BOOL)insertModeForDB:(QYstudent *)mode{
    //执行插入操作
    if (![self.dbBase executeUpdate:@"insert into students(name,age,phone,icon)values(?,?,?,?)",mode.name,@(mode.age),mode.phone,mode.icon]){
        NSLog(@"======%@",[self.dbBase lastErrorMessage]);
        return NO;
    }
    return YES;
}

-(BOOL)deleteDataForID:(int)Id{
    if (![self.dbBase executeUpdateWithFormat:@"delete from students where ID=%d",Id]) {
        NSLog(@"======%@",[self.dbBase lastErrorMessage]);
        return NO;
    }
    return YES;
}
-(BOOL)updateDataForMode:(NSDictionary *)mode{
    if (![self.dbBase executeUpdate:@"update students set name=:name,age=:age,icon=:icon,phone=:phone where ID=:ID" withParameterDictionary:mode]) {
        NSLog(@"=======%@",[self.dbBase lastErrorMessage]);
        return NO;
    }
    return YES;
}

-(QYstudent *)exectraModeBY:(FMResultSet *)set{
    QYstudent *mode=[[QYstudent alloc] init];
    [mode setValuesForKeysWithDictionary:[set resultDictionary]];
    return mode;
}

-(NSMutableArray*)selectOneDataForId:(int)Id{
#if 0 //查询方法
    
 FMResultSet *set=[self.dbBase executeQuery:@"select * from students where ID=?",@(Id)];
  //用while 循环，每一次取出一行数据
    NSMutableArray *dataArr=[NSMutableArray array];
    while ([set next]) {
     //将没行数据转换成mode
         NSLog(@"=====%d",[set intForColumn:@"age"]);
        NSLog(@"====%d",[set intForColumnIndex:0]);
        [dataArr addObject:[self exectraModeBY:set]];
    }
#endif
    //模糊查询
    NSString *sql=[NSString stringWithFormat:@"select * from students where name like '%@%@%@' or phone like '%@%@%@'",@"%",@"l",@"%",@"%",@"0",@"%"];
    FMResultSet *set=[self.dbBase executeQuery:sql];
    //用while 循环，每一次取出一行数据
    NSMutableArray *dataArr=[NSMutableArray array];
    while ([set next]) {
        //将没行数据转换成mode
        NSLog(@"=====%d",[set intForColumn:@"age"]);
        NSLog(@"====%d",[set intForColumnIndex:0]);
        [dataArr addObject:[self exectraModeBY:set]];
    }

    
    return dataArr;
}

-(NSMutableArray*)selectMoreOneDataForAll{
  //查询方法
    FMResultSet *set=[self.dbBase executeQuery:@"select *from students"];
    NSMutableArray *dataArr=[NSMutableArray array];
    while ([set next]) {
        [dataArr addObject:[self exectraModeBY:set]];
    }
    return dataArr;
}

@end
