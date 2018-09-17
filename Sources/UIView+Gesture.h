//
//  UIView+Gesture.h
//  MogoRenter
//
//  Created by song on 16/1/12.
//  Copyright © 2016年 MogoRoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Gesture)

/**
 *  点击事件  不需要手动添加手势事件 调用此方法既为添加
 *
 *  @param block <#block description#>
 */
- (void)tapGestureWithBlock:(void (^)(void))block;

/*! 移除tap手势 */
-(void)removeTapGesture;

/**
 *  长按事件
 *
 *  @param block <#block description#>
 */
- (void)longTapGestureWithBlock:(void (^)(UILongPressGestureRecognizer *gesture))block;

/*! 移除长按手势 */
-(void)removeLongTapGesture;

@end
