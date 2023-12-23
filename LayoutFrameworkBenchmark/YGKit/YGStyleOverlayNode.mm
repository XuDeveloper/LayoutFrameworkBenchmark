//
//  YGStyleOverlayNode.m
//  XuDevYoga
//
//  Created by zhaoxuzhang on 2022/8/12.
//

#import "YGStyleOverlayNode.h"

@implementation YGStyleOverlayNode

- (instancetype)init {
    self = [super init];
    if (self) {
        // 默认是center
        _position = YGStyleLayoutOverlayPositionCenter;
    }
    return self;
}

@end
