//
//  YGStyleLayoutUtility.m
//  XuDevYoga
//
//  Created by zhaoxuzhang on 2022/4/15.
//

#import "YGStyleLayoutUtility.h"
#import "YGStyleLayoutDefine.h"
#import "UIView+YGStyleLayout.h"

@implementation YGStyleLayoutUtility

+ (YGConfigRef)globalConfig {
    return YGConfigNew();
}

+ (CGFloat)roundPixelValue:(CGFloat)value {
    if (isnan(value)) {
        return 0;
    }
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    return roundf(value * scale) / scale;
}

+ (YGValue)pointValue:(CGFloat)value {
    return (YGValue){ .value = (float)value, .unit = YGUnitPoint };
}

+ (YGValue)percentValue:(CGFloat)value {
    return (YGValue){ .value = (float)value, .unit = YGUnitPercent };
}

+ (CGSize)calculateViewSize:(UIView *)view constrainedWidth:(CGFloat)constrainedWidth constrainedHeight:(CGFloat)constrainedHeight {
    CGSize sizeThatFits = CGSizeZero;
    if ([view conformsToProtocol:@protocol(YGStyleLayoutViewProtocol)] && [view respondsToSelector:@selector(ygStyleLayoutMeasureSize:)]) {
        sizeThatFits = [(id<YGStyleLayoutViewProtocol>)view ygStyleLayoutMeasureSize:CGSizeMake(constrainedWidth, constrainedHeight)];
    } else {
        sizeThatFits = [view sizeThatFits:CGSizeMake(constrainedWidth, constrainedHeight)];
    }
    return sizeThatFits;
}

@end
