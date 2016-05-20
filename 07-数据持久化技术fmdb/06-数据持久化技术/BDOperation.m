//
//  BDOperation.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "BDOperation.h"
#import <sqlite3.h>
#import "QYstudent.h"
#define KDBfile @"QYDB.sqlite"
//1.这里只是一个静态的变量，声明完后证明当期这个变量可以在全局使用
//2.数据库链接对象
static sqlite3 *_db=NULL;

@implementation BDOperation

+(instancetype)shareDBHandel{
    static dispatch_once_t once;
    static BDOperation *dbOperation=nil;
    dispatch_once(&once, ^{
        dbOperation=[[BDOperation alloc] init];
        //创建表
        [dbOperation createTable];
    });
    return dbOperation;
    
}
//创建表
-(BOOL)createTable{
  //1.打开数据库
    if(![self openDB])
        return NO;
   //2.创建sql语句
    NSString *sql=@"create table if not exists students(ID integer primary key,name text,age integer,phone text,icon blob)";
  //3执行sql语句
    char *errmsg;
    if (sqlite3_exec(_db, [sql UTF8String], NULL, NULL, &errmsg)!=SQLITE_OK) {
        NSLog(@"=====%s",errmsg);
        //关闭数据库
        [self closeDB];
        return NO;
    }
     NSLog(@"======表创建成功");
    [self closeDB];
    return YES;
}

-(BOOL)closeDB{

    if(sqlite3_close(_db)!=SQLITE_OK){
        NSLog(@"关闭失败");
        return NO;
    }
    //把指针指向于NULL,_db句柄指向于0；
    _db=NULL;
    
    return YES;
}

-(BOOL)openDB{
    //1.判读数据库连接对象
    if (_db) {
    return YES;
    }
    
   const char *dbFile=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:KDBfile] UTF8String];
    //打开数据库创建数据库链接对象
    int result=sqlite3_open(dbFile, &_db);
    if (result!=SQLITE_OK) {
        NSLog(@"======%s",sqlite3_errmsg(_db));
        return NO;
    }
    NSLog(@"======打开成功");
    return YES;
}

//插入数据
-(BOOL)insertModeForDB:(QYstudent *)mode{
  //1.打开数据库
    if (![self openDB]) {
        return NO;
    }
  //2.编写sql语句
    NSString *sql=@"insert into students(name,age,icon,phone)values(?,?,?,?)";
  //3.将sql转换可以执行的预编译对象
      //3.1预编译语句
        sqlite3_stmt *stmt;
      //第三个参数表示sql的长度 -1 全部
      //第五个参数表示sql地址 NULl
     int result=sqlite3_prepare_v2(_db, [sql UTF8String], -1, &stmt, NULL);
     if (result!=SQLITE_OK) {
        NSLog(@"=====%s",sqlite3_errmsg(_db));
        [self closeDB];
        return NO;
     }
    //3.2绑定参数
    //第四个参数-1 表示字符串的长度
    //第五个参数表示析构函数 NUll
    sqlite3_bind_text(stmt, 1, [mode.name UTF8String], -1, NULL);
    sqlite3_bind_int(stmt, 2, mode.age);
    sqlite3_bind_blob(stmt, 3, [mode.icon bytes],(int)mode.icon.length, NULL);
    sqlite3_bind_text(stmt, 4, [mode.phone UTF8String], -1, NULL);
    
    //4.执行预编译语句
    if (sqlite3_step(stmt)!=SQLITE_DONE) {
        NSLog(@"=====%s",sqlite3_errmsg(_db));
        //1.销毁预编译对象
        sqlite3_finalize(stmt);
        
        //关闭数据库
        [self closeDB];
        return NO;
    }

  //5.销毁预编译对象
    sqlite3_finalize(stmt);
   //6.关闭数据库
    [self closeDB];
  return YES;
};

-(BOOL)deleteDataForID:(int)Id{
//1.打开数据库
    if(![self openDB])return NO;
//2.sql语句
    NSString *sql=@"delete from students where ID=?";
//3.sql语句转化成可执行的预编译对象
    //3.1声明预编译对象
     sqlite3_stmt *stmt;
     //第三个参数表示sql的长度 -1 全部
     //第五个参数表示sql的指针地址，对我们没有用，NULL
     int result=sqlite3_prepare_v2(_db, [sql UTF8String], -1, &stmt, NULL);
    if (result!=SQLITE_OK) {
        NSLog(@"预编译失败===%s",sqlite3_errmsg(_db));
        [self closeDB];
        return NO;
    }
    //3.2bind 参数
    sqlite3_bind_int(stmt, 1, Id);
//4.执行预编译对象
    //对于UPdate，insert,delete 操作step之后返回SQLITE_DONE 代表意思执行成功
    //对于select这样操作step后 SQLITE_ROW 返回一条数据
    if (sqlite3_step(stmt)!=SQLITE_DONE) {
        sqlite3_finalize(stmt);
        [self closeDB];
        return NO;
    }
//5.销毁预编译对象
    sqlite3_finalize(stmt);
//6.关闭数据库
    [self closeDB];
    return YES;
}

-(BOOL)updateDataForMode:(QYstudent *)mode{
    //1.打开数据库
    if(![self openDB])return NO;
    //2.sql语句
    NSString *sql=@"update students set name=?,age=?,phone=?,icon=? where ID=?";
    //3.将sql语句转换成预编译对象
       //3.1声明预编译对象
       sqlite3_stmt *stmt;
    //第三个参数表示sql的长度 -1表示全部长度
    //第五个参数表示sql的地址 NULL ，这个参数对我们没有用
    if(sqlite3_prepare_v2(_db, [sql UTF8String], -1, &stmt, NULL)!=SQLITE_OK){
        NSLog(@"====%s",sqlite3_errmsg(_db));
        [self closeDB];
        return NO;
    }
      //3.2bind参数
     //第四个参数表示文本长度 -1 全部
     //第五个参数表示（析构函数)一般没有用传NULL
     sqlite3_bind_text(stmt, 1, [mode.name UTF8String], -1, NULL);
     sqlite3_bind_int(stmt, 2, mode.age);
     sqlite3_bind_text(stmt, 3, [mode.phone UTF8String], -1, NULL);
     sqlite3_bind_blob(stmt, 4, [mode.icon bytes],(int)mode.icon.length, NULL);
     sqlite3_bind_int(stmt, 5, mode.ID);
    //4.执行预编译对象
    //对于update，insert，delete执行step操作，返回SQLITE_DONE代表执行成功
    //对于select执行step操作，返回SQLITE_ROW代表一条数据
    if(sqlite3_step(stmt)!=SQLITE_DONE){
        sqlite3_finalize(stmt);
        [self closeDB];
        return NO;
    }
    //5.销毁预编译对象
    sqlite3_finalize(stmt);
    //6.关闭数据库
    [self closeDB];
    return YES;
}

-(QYstudent *)extruacMode:(sqlite3_stmt *)stmt{
  //1.ID
  int ID=sqlite3_column_int(stmt, 0);
  //2.name
  const unsigned char *cName=sqlite3_column_text(stmt, 1);
  //3.age
    int age=sqlite3_column_int(stmt, 2);
    //4.phone
   const unsigned char *cPhone=sqlite3_column_text(stmt, 3);
    //5.icon
   const void * bicon=sqlite3_column_blob(stmt,4);
    QYstudent *mode=[QYstudent new];
    mode.ID=ID;
    mode.age=age;
    if (cName) {
        mode.name=[NSString  stringWithUTF8String:(const char *)cName];
    }
    
    if (cPhone) {
        mode.phone=[NSString stringWithUTF8String:(const char *)cPhone];
    }
    //返回字节数 长度
    int size=sqlite3_column_bytes(stmt, 4);
    mode.icon=[NSData dataWithBytes:bicon length:size];
    return mode;
}

-(NSMutableArray*)selectMoreOneDataForAll{
    //1.打开数据库
    if(![self openDB])return nil;
    //2.sql语句
    NSString *sql=@"select * from students";
    //3.sql语句转换成预编译对象
    //3.1声明预编译对象
    sqlite3_stmt *stmt;
    //第三个参数表示sql的长度 -1 全部
    //第五个参数表示sql地址 NULL 对我们没有用传NULL
    if (sqlite3_prepare_v2(_db, [sql UTF8String], -1, &stmt, NULL)!=SQLITE_OK) {
        NSLog(@"=====%s",sqlite3_errmsg(_db));
        [self closeDB];
        return nil;
    }
    //4.执行预编译语句
    NSMutableArray *dataArr=[NSMutableArray array];
    while (sqlite3_step(stmt)==SQLITE_ROW) {
        //查询回来的一条数据是存储我们的预编译对象里边
        //将预编对象的数据=取出来===>存在模型里边
        //每次读取一行
        QYstudent *mode=[self extruacMode:stmt];
        [dataArr addObject:mode];
    }
    //5.销毁预编译对象
    sqlite3_finalize(stmt);
    //6.关闭数据库
    [self closeDB];
    return dataArr;
}

-(NSMutableArray*)selectOneDataForId:(int)Id{
  //1.打开数据库
    if(![self openDB])return nil;
  //2.sql语句
    NSString *sql=@"select * from students where ID=?";
  //3.sql语句转换成预编译对象
    //3.1声明预编译对象
     sqlite3_stmt *stmt;
    //第三个参数表示sql的长度 -1 全部
    //第五个参数表示sql地址 NULL 对我们没有用传NULL
    if (sqlite3_prepare_v2(_db, [sql UTF8String], -1, &stmt, NULL)!=SQLITE_OK) {
        NSLog(@"=====%s",sqlite3_errmsg(_db));
        [self closeDB];
        return nil;
    }
    //3.2bind参数
    sqlite3_bind_int(stmt, 1, Id);
  //4.执行预编译语句
    NSMutableArray *dataArr=[NSMutableArray array];
    while (sqlite3_step(stmt)==SQLITE_ROW) {
       //查询回来的一条数据是存储我们的预编译对象里边
       //将预编对象的数据=取出来===>存在模型里边
        //每次读取一行
        QYstudent *mode=[self extruacMode:stmt];
        [dataArr addObject:mode];
    }
  //5.销毁预编译对象
    sqlite3_finalize(stmt);
  //6.关闭数据库
    [self closeDB];
    return dataArr;
}
@end
