//
//  QYmode.m
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYmode.h"
#define Kicon @"image"
#define KName @"name"
#define Kage  @"age"
#define Ksex  @"sex"

@implementation QYmode
#pragma mark Nscoding
//反序列化操作
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
    //解码取值
        _iconData=[aDecoder decodeObjectForKey:Kicon];
        _name=[aDecoder decodeObjectForKey:KName];
        _age=[aDecoder decodeIntegerForKey:Kage];
        _sex=[aDecoder decodeBoolForKey:Ksex];
    }
    return self;
}
//序列化技术
-(void)encodeWithCoder:(NSCoder *)aCoder{
  //编码
    [aCoder encodeObject:_iconData forKey:Kicon];
    [aCoder encodeObject:_name forKey:KName];
    [aCoder encodeInteger:_age forKey:Kage];
    [aCoder encodeBool:_sex forKey:Ksex];
}





@end
