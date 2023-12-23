//
//  YGStyleLayout+Private.h
//  XuDevYoga
//
//  Created by zhaoxuzhang on 2022/4/15.
//

#import "YGStyleLayout.h"
#import <YogaKit/YGLayout.h>
#import "WeChatExtScope.h"

NS_ASSUME_NONNULL_BEGIN

#define YGStyleLayoutWorkerThreadName "YGStyleLayoutWorker"

@class UIView;

@interface YGStyleLayout (Private)

@property (nonatomic, assign, readonly) YGNodeRef node;

- (instancetype)initWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
