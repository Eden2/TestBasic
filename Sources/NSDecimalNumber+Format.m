//
//  NSDecimalNumber+CustomDecimalNum.m
//  PodTest
//
//  Created by tong on 16/2/22.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "NSDecimalNumber+Format.h"

@implementation NSDecimalNumber (Format)
/*字符串转化为NSDecimalNumber*/
+(NSDecimalNumber *)getNSDecimalByString:(NSString *)number{
    return [NSDecimalNumber decimalNumberWithString:number];
}
/**
 NSDecimalNumber显示NSString方式
 
 @param amtDecimalNumber NSDecimalNumber
 @param type HX_ShowNSDecimalNumberType
 @return NSString
 */
+ (NSString*)formatShowAmt:(NSDecimalNumber*)amtDecimalNumber withFormat:(HX_ShowNSDecimalNumberType)type{
    if (type == ShowNSDecimalNumberTypeYUAN) {
        return [NSString stringWithFormat:@"%.2lf元",[amtDecimalNumber doubleValue]];
    }else if (type == ShowNSDecimalNumberTypeFUHAO){
        return [NSString stringWithFormat:@"￥%.2lf",[amtDecimalNumber doubleValue]];
    }else
        return [NSString stringWithFormat:@"%.2lf",[amtDecimalNumber doubleValue]];
}

/**
 * 获得正确的金额各式,如果有小数点，小数点保留2位（小数点有2位以上的才会四舍五入保留2位小数）
 */
+ (NSString*)formatShowAmtWithString:(NSString *)amtString withFormat:(HX_ShowNSDecimalNumberType)type{
    /*四舍五入,保留2位小数 金额单位有万元的应该保留4位*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:2
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    NSDecimalNumber *amtt = [NSDecimalNumber decimalNumberWithString:amtString];
    amtt = [amtt decimalNumberByRoundingAccordingToBehavior:roundUp];
    
    if (type == ShowNSDecimalNumberTypeYUAN) {
        return [NSString stringWithFormat:@"%@ 元",amtt];
    }else if (type == ShowNSDecimalNumberTypeFUHAO){
        return [NSString stringWithFormat:@"￥ %@",amtt];
    }else{
        return [amtt stringValue];
    }
}


/*金额保留到分，数据除以100*/
+(NSDecimalNumber *)formatAmt:(NSString *)amt{
    unsigned long long amtDouble = [amt longLongValue];
    //这个地方的参数long long最大为2的23次方-1
    NSDecimalNumber *formatAmt = [NSDecimalNumber decimalNumberWithMantissa:amtDouble exponent:-2 isNegative:NO];
    return formatAmt;
}
/*加法*/
+(NSDecimalNumber *)getNumberAdd:(NSDecimalNumber *)A by:(NSDecimalNumber *)B withScalePoint:(short)dot
{
    /*四舍五入*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:dot
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [A decimalNumberByAdding:B withBehavior:roundUp];
}
/*减法*/
+(NSDecimalNumber *)getNumberSubtracting:(NSDecimalNumber *)A by:(NSDecimalNumber *)B withScalePoint:(short)dot{
    /*四舍五入*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:dot
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [A decimalNumberBySubtracting:B withBehavior:roundUp];
}

/*乘法 参数和返回都是NSDecimalNumber类型*/
+(NSDecimalNumber *)getNumberMultiply:(NSDecimalNumber *)A by:(NSDecimalNumber *)B withScalePoint:(short)dot{
    /*四舍五入*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:dot
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [A  decimalNumberByMultiplyingBy:B withBehavior:roundUp];
}

/*乘法 参数是NSString类型*/
+(NSDecimalNumber *)getNumberMultiplyWithString:(NSString *)AString by:(NSString *)BString withScalePoint:(short)dot{
    /*四舍五入*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:dot
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [[self getNSDecimalByString:AString]  decimalNumberByMultiplyingBy:[self getNSDecimalByString:BString] withBehavior:roundUp];
}
/*乘法 返回是NSString类型*/
+(NSString *)getStrNumberMultiply:(NSDecimalNumber *)A by:(NSDecimalNumber *)B withScalePoint:(short)dot{
    /*四舍五入*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:dot
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [[A  decimalNumberByMultiplyingBy:B withBehavior:roundUp] stringValue];
}

/*乘法 参数和返回都是NSString类型*/
+(NSString *)getStrNumberMultiplyWithString:(NSString *)AString by:(NSString *)BString withScalePoint:(short)dot{
    /*四舍五入*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:dot
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [[[self getNSDecimalByString:AString] decimalNumberByMultiplyingBy:[self getNSDecimalByString:BString] withBehavior:roundUp] stringValue];
}

/*上传至服务器 金额*100*/
+(NSString *)getNumberService:(NSString *)A withScalePoint:(short)dot{
    /*四舍五入*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:dot
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [[[self getNSDecimalByString:A]  decimalNumberByMultiplyingBy:[self getNSDecimalByString:@"100"] withBehavior:roundUp] stringValue];
}

/**
 A除以B

 @param A 除数
 @param B 被除数
 @param dot 小数点保留几位
 @param mode 舍入方式 四舍五入 只入不舍 只舍不如 只取整数
 @return a除以b返回NSDecimalNumber
 */
+(NSDecimalNumber *)getNumberDividing:(NSDecimalNumber *)A by:(NSDecimalNumber *)B withScalePoint:(short)dot withNSRoundingMode:(NSRoundingMode)mode{
    /*NSRoundUp 只入不舍*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:mode
                                       scale:dot
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [A decimalNumberByDividingBy:B withBehavior:roundUp];
}

/**
 字符串A除以字符串B 小数点四舍五入

 @param AString 除数
 @param BString 被除数
 @param dot 小数点保留几位
 @return a除以b返回字符串
 */
+(NSString *)getNumberDividingWithString:(NSString *)AString by:(NSString *)BString withScalePoint:(short)dot{
    /*四舍五入*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:dot
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [[[self getNSDecimalByString:AString] decimalNumberByDividingBy:[self getNSDecimalByString:BString] withBehavior:roundUp] stringValue];
}

/*A的几次方*/
+(NSDecimalNumber *)getNumberRaisingToPower:(NSDecimalNumber *)A power:(NSUInteger)B withScalePoint:(short)dot{
    /*四舍五入*/
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:dot
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [A decimalNumberByRaisingToPower:B withBehavior:roundUp];
}
/*A是否比B大*/
+(BOOL)compareLargeNumber:(NSDecimalNumber *)A with:(NSDecimalNumber *)B{
    NSComparisonResult result = [A compare:B];
    if (result == NSOrderedDescending) {//大于
        return YES;
    }else
        return NO;
}
/*A是否比B小*/
+(BOOL)compareSmallNumber:(NSDecimalNumber *)A with:(NSDecimalNumber *)B{
    NSComparisonResult result = [A compare:B];
    if (result == NSOrderedAscending) {//小于
        return YES;
    }else
        return NO;
}
/*A是否等于B*/
+(BOOL)compareSameNumber:(NSDecimalNumber *)A with:(NSDecimalNumber *)B{
    NSComparisonResult result = [A compare:B];
    if (result == NSOrderedSame) {//等于
        return YES;
    }else
        return NO;
}
@end
