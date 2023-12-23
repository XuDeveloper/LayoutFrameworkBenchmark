//
//  YGStyleLayoutUtility.h
//  XuDevYoga
//
//  Created by zhaoxuzhang on 2022/4/15.
//

#import <Foundation/Foundation.h>
#import <YogaKit/YGLayout.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YGStyleLayoutUtility : NSObject

+ (YGConfigRef)globalConfig;
+ (CGFloat)roundPixelValue:(CGFloat)value;
+ (YGValue)pointValue:(CGFloat)value;
+ (YGValue)percentValue:(CGFloat)value;

+ (CGSize)calculateViewSize:(UIView *)view constrainedWidth:(CGFloat)constrainedWidth constrainedHeight:(CGFloat)constrainedHeight;

@end

NS_ASSUME_NONNULL_END
