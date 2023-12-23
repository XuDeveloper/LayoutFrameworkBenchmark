//
//  YGStyleOverlayNode.h
//  XuDevYoga
//
//  Created by zhaoxuzhang on 2022/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, YGStyleLayoutOverlayPosition) {
    YGStyleLayoutOverlayPositionNone = 0,
    YGStyleLayoutOverlayPositionTop = 1 << 0,
    YGStyleLayoutOverlayPositionLeft = 1 << 1,
    YGStyleLayoutOverlayPositionBottom = 1 << 2,
    YGStyleLayoutOverlayPositionRight = 1 << 3,
    YGStyleLayoutOverlayPositionCenter = 1 << 4,
};

@interface YGStyleOverlayNode : NSObject

@property (nonatomic, assign) YGStyleLayoutOverlayPosition position;
 
@end

NS_ASSUME_NONNULL_END
