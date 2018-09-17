//
//  UIView+Gesture.m
//  MogoRenter
//
//  Created by song on 16/1/12.
//  Copyright © 2016年 MogoRoom. All rights reserved.
//

#import "UIView+Gesture.h"
#import <objc/runtime.h>
@implementation UIView (Gesture)

static void * const kTapGestureObjectKey = (void*)&kTapGestureObjectKey;
static void * const kLongTapGestureObjectKey = (void*)&kLongTapGestureObjectKey;

- (void)tapGestureWithBlock:(void (^)(void))block{
    void(^action)(void) = objc_getAssociatedObject(self, kTapGestureObjectKey);
    if (!action) {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, kTapGestureObjectKey, block, OBJC_ASSOCIATION_RETAIN);
    }else{
        [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
                obj.enabled = YES;
            }
        }];
    }
    
    
    objc_setAssociatedObject(self, kTapGestureObjectKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, kTapGestureObjectKey);
        if (action) {
            action();
        }
    }
}

-(void)removeTapGesture{
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
//            [obj removeTarget:self action:@selector(tapGesture:)];
            obj.enabled = NO;
//            self.userInteractionEnabled = NO;
        }
    }];
}

- (void)longTapGestureWithBlock:(void (^)(UILongPressGestureRecognizer *gesture))block {
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapGesture:)];
    [self addGestureRecognizer:gesture];
    objc_setAssociatedObject(self, kLongTapGestureObjectKey, gesture, OBJC_ASSOCIATION_RETAIN);
    
    objc_setAssociatedObject(self, kLongTapGestureObjectKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)longTapGesture:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        void(^action)(UILongPressGestureRecognizer *longTapGesture) = objc_getAssociatedObject(self, kLongTapGestureObjectKey);
        if (action) {
            action(gesture);
        }
    }
}

-(void)removeLongTapGesture{
    void(^action)(void) = objc_getAssociatedObject(self, kTapGestureObjectKey);
    if (action) {
        objc_removeAssociatedObjects(action);
    }
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [obj removeTarget:self action:@selector(longTapGesture:)];
        }
    }];
}


@end
