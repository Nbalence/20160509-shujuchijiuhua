//
//  QYmode.h
//  06-数据持久化技术
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

//想让那个类序列化，要让那个类遵循Nscoding协议

@interface QYmode : NSObject<NSCoding>

@property(nonatomic,strong)NSData *iconData;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,assign)BOOL sex;

@end
