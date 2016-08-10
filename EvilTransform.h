//
//  EvilTransform.h
//  MapTrail
//
//  Created by 朗世公司 on 16/8/10.
//  Copyright © 2016年 Aries. All rights reserved.
//  转换为火星坐标

#import <Foundation/Foundation.h>

@interface EvilTransform : NSObject

//index 0 --latitude
//index 1 --longitude
+ (NSArray *)transformWgLat:(double)wgLat wglon:(double)wgLon;
@end
