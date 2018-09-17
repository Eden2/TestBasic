//
//  NSDecimalNumber+CustomDecimalNum.h
//  PodTest
//
//  Created by tong on 16/2/22.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>

/*NSDecimalNumber字符串表现形式*/
typedef enum ShowNSDecimalNumberType
{
    ShowNSDecimalNumberTypeYUAN,
    ShowNSDecimalNumberTypeFUHAO,
    ShowNSDecimalNumberTypeNO
}HX_ShowNSDecimalNumberType;

@interface NSDecimalNumber (FormatAmt)
/*字符串转化为NSDecimalNumber*/
+(NSDecimalNumber *)getNSDecimalByString:(NSString *)number;

/**
 NSDecimalNumber显示NSString方式

 @param amtDecimalNumber NSDecimalNumber
 @param type HX_ShowNSDecimalNumberType
 @return NSString
 */
+ (NSString*)formatShowAmt:(NSDecimalNumber*)amtDecimalNumber withFormat:(HX_ShowNSDecimalNumberType)type;

/**
 * 获得正确的金额各式,如果有小数点，小数点保留2位（小数点有2位以上的才会四舍五入保留2位小数）
 */
+ (NSString*)formatShowAmtWithString:(NSString *)amtString withFormat:(HX_ShowNSDecimalNumberType)type;

/*金额保留到分，数据除以100*/
+(NSDecimalNumber *)formatAmt:(NSString *)amt;
/*加法*/
+(NSDecimalNumber *)getNumberAdd:(NSDecimalNumber *)A by:(NSDecimalNumber *)B withScalePoint:(short)dot withScalePoint:(short)dot;
/*减法*/
+(NSDecimalNumber *)getNumberSubtracting:(NSDecimalNumber *)A by:(NSDecimalNumber *)B withScalePoint:(short)dot;

/*乘法 参数和返回都是NSDecimalNumber类型*/
+(NSDecimalNumber *)getNumberMultiply:(NSDecimalNumber *)A by:(NSDecimalNumber *)B withScalePoint:(short)dot;
/*乘法 参数是NSString类型*/
+(NSDecimalNumber *)getNumberMultiplyWithString:(NSString *)AString by:(NSString *)BString withScalePoint:(short)dot;
/*乘法 返回是NSString类型*/
+(NSString *)getStrNumberMultiply:(NSDecimalNumber *)A by:(NSDecimalNumber *)B withScalePoint:(short)dot;
/*乘法 参数和返回都是NSString类型*/
+(NSString *)getStrNumberMultiplyWithString:(NSString *)AString by:(NSString *)BString withScalePoint:(short)dot;


/*上传至服务器 金额*100*/
+(NSString *)getNumberService:(NSString *)A;
/**
 A除以B
 
 @param A 除数
 @param B 被除数
 @param dot 小数点保留几位
 @param mode 舍入方式 四舍五入 只入不舍 只舍不如 只取整数
 @return a除以b返回NSDecimalNumber
 */
+(NSDecimalNumber *)getNumberDividing:(NSDecimalNumber *)A by:(NSDecimalNumber *)B withScalePoint:(short)dot withNSRoundingMode:(NSRoundingMode)mode;
/*A的几次方*/
+(NSDecimalNumber *)getNumberRaisingToPower:(NSDecimalNumber *)A power:(NSUInteger)B withScalePoint:(short)dot;
/*A是否比B大*/
+(BOOL)compareLargeNumber:(NSDecimalNumber *)A with:(NSDecimalNumber *)B;
/*A是否比B小*/
+(BOOL)compareSmallNumber:(NSDecimalNumber *)A with:(NSDecimalNumber *)B;
/*A是否等于B*/
+(BOOL)compareSameNumber:(NSDecimalNumber *)A with:(NSDecimalNumber *)B;
@end
