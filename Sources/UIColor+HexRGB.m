//
//  UIColor+HexRGB.m
//  Goldmofang
//
//  Created by 仝彦彦 on 15-3-4.
//  Copyright (c) 2015年 tongyy. All rights reserved.
//

#import "UIColor+HexRGB.h"

@implementation UIColor (HexRGB)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
	NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
	unsigned hexNum;
	if (![scanner scanHexInt:&hexNum]) return nil;
	return [self colorWithRGBHex:hexNum];
}
@end
