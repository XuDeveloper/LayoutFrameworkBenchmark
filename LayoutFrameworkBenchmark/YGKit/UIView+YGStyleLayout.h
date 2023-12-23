//
//  UIView+YGStyleLayout.h
//  XuDevYoga
//
//  Created by zhaoxuzhang on 2022/6/2.
//

#import <UIKit/UIKit.h>
#import "YGStyleLayout.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YGStyleLayoutViewProtocol <NSObject>

@optional
- (CGSize)ygStyleLayoutMeasureSize:(CGSize)fittingSize;

@end

@interface UIView (YGStyleLayout)

@property (nonatomic, readonly, strong, nonnull) YGStyleLayout *ygStyleLayout;

@end

NS_ASSUME_NONNULL_END
