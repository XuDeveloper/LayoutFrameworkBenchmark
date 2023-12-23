//
//  UIView+YGStyleLayout.m
//  XuDevYoga
//
//  Created by zhaoxuzhang on 2022/6/2.
//

#import "UIView+YGStyleLayout.h"
#import <objc/runtime.h>

static const void *kYGStyleLayoutAssociatedKey = &kYGStyleLayoutAssociatedKey;

@implementation UIView (YGStyleLayout)

- (YGStyleLayout *)ygStyleLayout {
    YGStyleLayout *styleLayout = objc_getAssociatedObject(self, kYGStyleLayoutAssociatedKey);
    if (!styleLayout) {
        styleLayout = [[YGStyleLayout alloc] initWithView:self];
        objc_setAssociatedObject(self, kYGStyleLayoutAssociatedKey, styleLayout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return styleLayout;
}

@end
