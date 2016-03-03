//
//  JX_HexToRGB.h
//  JX_HexToRGB
//
//  Created by 谷建兴 on 16/3/2.
//  Copyright © 2016年 gujianxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JX_HexToRGB : NSObject

//将十六进制转为UIColor
- (UIColor *)hexFloatColor:(NSString *)hexStr;

@end
