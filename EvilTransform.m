//
//  EvilTransform.m
//  MapTrail
//
//  Created by 朗世公司 on 16/8/10.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "EvilTransform.h"
#define PI 3.14159265358979324
#define a 6378245.0
#define ee 0.00669342162296594323

@implementation EvilTransform


+ (NSArray *)transformWgLat:(double)wgLat wglon:(double)wgLon{
    NSMutableArray *mutableArray = [NSMutableArray array];
    if ([self outOfChinaLat:wgLat lon:wgLon])
    {
        [mutableArray addObject:@(wgLat)];
        [mutableArray addObject:@(wgLon)];
        return [mutableArray copy];
    }
    double dLat = [self transformLatX:wgLon - 105.0 y:wgLat - 35.0];
    double dLon = [self transformLonX:wgLon - 105.0 y:wgLat - 35.0];
    double radLat = wgLat / 180.0 * PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * PI);
    
    
    [mutableArray addObject:@(wgLat + dLat)];
    [mutableArray addObject:@(wgLon + dLon)];
    
    return [mutableArray copy];
}

+ (BOOL)outOfChinaLat:(double)lat lon:(double)lon{
    if (lon < 72.004 || lon > 137.8347)
        return YES;
    if (lat < 0.8293 || lat > 55.8271)
        return YES;
    return NO;
}
+ (double)transformLatX:(double)x y:(double)y{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * PI) + 20.0 * sin(2.0 * x * PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * PI) + 40.0 * sin(y / 3.0 * PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * PI) + 320 * sin(y * PI / 30.0)) * 2.0 / 3.0;
    return ret;
}
+ (double)transformLonX:(double)x y:(double)y{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * PI) + 20.0 *  sin(2.0 * x * PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * PI) + 40.0 * sin(x / 3.0 * PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * PI) + 300.0 * sin(x / 30.0 * PI)) * 2.0 / 3.0;
    return ret;
    
}
@end
