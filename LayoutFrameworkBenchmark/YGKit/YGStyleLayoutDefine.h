//
//  YGStyleLayoutDefine.h
//  XuDevYoga
//
//  Created by zhaoxuzhang on 2022/6/6.
//

#import <UIKit/UIKit.h>
#import <YogaKit/YGLayout.h>
#import "YGStyleOverlayNode.h"

#ifndef YGStyleLayoutDefine_h
#define YGStyleLayoutDefine_h

#define YGSTYLELAYOUT_PROPERTY(name) @property (nonatomic, strong, readonly, nonnull) YGSL_##name name;
#define _YGSTYLELAYOUT_PROPERTY(name) @property (nonatomic, strong) YGSL_##name name;

@class YGStyleLayout;
typedef YGStyleLayout * (^YGSL_addItem)(UIView *view);
typedef YGStyleLayout * (^YGSL_addSpacer)(CGFloat value);
typedef YGStyleLayout * (^YGSL_addStack)(YGFlexDirection direction);
typedef void (^YGStyleLayoutConfigurationBlock)(YGStyleLayout *style);
typedef YGStyleLayout * (^YGSL_define)(YGStyleLayoutConfigurationBlock block);

#define YGSTYLELAYOUT_BLOCK(name, type) typedef YGStyleLayout * (^YGSL_##name)(type value);

YGSTYLELAYOUT_BLOCK(isIncludedInLayout, BOOL)
YGSTYLELAYOUT_BLOCK(direction, YGDirection)
YGSTYLELAYOUT_BLOCK(flexDirection, YGFlexDirection)
YGSTYLELAYOUT_BLOCK(justifyContent, YGJustify)
YGSTYLELAYOUT_BLOCK(alignContent, YGAlign)
YGSTYLELAYOUT_BLOCK(alignItems, YGAlign)
YGSTYLELAYOUT_BLOCK(alignSelf, YGAlign)
YGSTYLELAYOUT_BLOCK(position, YGPositionType)
YGSTYLELAYOUT_BLOCK(flexWrap, YGWrap)
YGSTYLELAYOUT_BLOCK(overflow, YGOverflow)
YGSTYLELAYOUT_BLOCK(display, YGDisplay)
YGSTYLELAYOUT_BLOCK(flexGrow, CGFloat)
YGSTYLELAYOUT_BLOCK(flexShrink, CGFloat)
YGSTYLELAYOUT_BLOCK(flexBasis, YGValue)
YGSTYLELAYOUT_BLOCK(left, CGFloat)
YGSTYLELAYOUT_BLOCK(leftPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(top, CGFloat)
YGSTYLELAYOUT_BLOCK(topPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(right, CGFloat)
YGSTYLELAYOUT_BLOCK(rightPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(bottom, CGFloat)
YGSTYLELAYOUT_BLOCK(bottomPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(start, CGFloat)
YGSTYLELAYOUT_BLOCK(startPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(end, CGFloat)
YGSTYLELAYOUT_BLOCK(endPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(all, CGFloat)
YGSTYLELAYOUT_BLOCK(allPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(marginTop, CGFloat)
YGSTYLELAYOUT_BLOCK(marginTopPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(marginLeft, CGFloat)
YGSTYLELAYOUT_BLOCK(marginLeftPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(marginBottom, CGFloat)
YGSTYLELAYOUT_BLOCK(marginBottomPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(marginRight, CGFloat)
YGSTYLELAYOUT_BLOCK(marginRightPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(marginStart, CGFloat)
YGSTYLELAYOUT_BLOCK(marginStartPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(marginEnd, CGFloat)
YGSTYLELAYOUT_BLOCK(marginEndPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(marginHorizontal, CGFloat)
YGSTYLELAYOUT_BLOCK(marginHorizontalPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(marginVertical, CGFloat)
YGSTYLELAYOUT_BLOCK(marginVerticalPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(margin, CGFloat)
YGSTYLELAYOUT_BLOCK(marginPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(marginInsets, UIEdgeInsets)
YGSTYLELAYOUT_BLOCK(paddingTop, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingTopPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingLeft, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingLeftPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingBottom, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingBottomPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingRight, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingRightPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingStart, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingStartPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingEnd, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingEndPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingHorizontal, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingHorizontalPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingVertical, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingVerticalPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(padding, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(paddingInsets, UIEdgeInsets)
YGSTYLELAYOUT_BLOCK(size, CGSize)
YGSTYLELAYOUT_BLOCK(width, CGFloat)
YGSTYLELAYOUT_BLOCK(widthPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(height, CGFloat)
YGSTYLELAYOUT_BLOCK(heightPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(minWidth, CGFloat)
YGSTYLELAYOUT_BLOCK(minWidthPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(minHeight, CGFloat)
YGSTYLELAYOUT_BLOCK(minHeightPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(maxWidth, CGFloat)
YGSTYLELAYOUT_BLOCK(maxWidthPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(maxHeight, CGFloat)
YGSTYLELAYOUT_BLOCK(maxHeightPercent, CGFloat)
YGSTYLELAYOUT_BLOCK(borderLeftWidth, CGFloat)
YGSTYLELAYOUT_BLOCK(borderTopWidth, CGFloat)
YGSTYLELAYOUT_BLOCK(borderRightWidth, CGFloat)
YGSTYLELAYOUT_BLOCK(borderBottomWidth, CGFloat)
YGSTYLELAYOUT_BLOCK(aspectRatio, CGFloat)
YGSTYLELAYOUT_BLOCK(backgroundColor, UIColor *)
YGSTYLELAYOUT_BLOCK(cornerRadius, CGFloat)
YGSTYLELAYOUT_BLOCK(userInteractionEnabled, BOOL)
YGSTYLELAYOUT_BLOCK(display, YGDisplay)
YGSTYLELAYOUT_BLOCK(overlay, BOOL)
YGSTYLELAYOUT_BLOCK(overlayPosition, YGStyleLayoutOverlayPosition)

#define YGSTYLELAYOUT_STACK_VIEW_TAG 10000
#define YGSTYLELAYOUT_SPACER_VIEW_TAG 10001
#define YGSTYLELAYOUT_CALCULATE_SUB_THREAD_WAIT_TIME 2 * NSEC_PER_SEC

// ==========YGSTYLELAYOUT_SETTER/GETTER==========

#define YGSTYLELAYOUT_SETTER(type, lowercased_name, capitalized_name) YGNodeStyleSet##capitalized_name(self.node, lowercased_name)

#define YGSTYLELAYOUT_GETTER(type, lowercased_name, capitalized_name)          \
    -(YGSL_##lowercased_name)lowercased_name {                                 \
        if (!_##lowercased_name) {                                             \
            weakify(self);                                                     \
            _##lowercased_name = ^(type lowercased_name) {                     \
                strongify(self);                                               \
                YGSTYLELAYOUT_SETTER(type, lowercased_name, capitalized_name); \
                return self;                                                   \
            };                                                                 \
        }                                                                      \
        return _##lowercased_name;                                             \
    }

// ==========YGSTYLELAYOUT_SETTER_YGVALUE/GETTER_YGVALUE==========

#define YGSTYLELAYOUT_SETTER_YGVALUE(lowercased_name, capitalized_name)                      \
    {                                                                                        \
        switch (lowercased_name.unit) {                                                      \
            case YGUnitUndefined:                                                            \
                YGNodeStyleSet##capitalized_name(self.node, lowercased_name.value);          \
                break;                                                                       \
            case YGUnitPoint:                                                                \
                YGNodeStyleSet##capitalized_name(self.node, lowercased_name.value);          \
                break;                                                                       \
            case YGUnitPercent:                                                              \
                YGNodeStyleSet##capitalized_name##Percent(self.node, lowercased_name.value); \
                break;                                                                       \
            default:                                                                         \
                NSAssert(NO, @"Not implemented");                                            \
        }                                                                                    \
    }

#define YGSTYLELAYOUT_GETTER_YGVALUE(lowercased_name, capitalized_name)         \
    -(YGSL_##lowercased_name)lowercased_name {                                  \
        if (!_##lowercased_name) {                                              \
            weakify(self);                                                      \
            _##lowercased_name = ^(YGValue lowercased_name) {                   \
                strongify(self);                                                \
                YGSTYLELAYOUT_SETTER_YGVALUE(lowercased_name, capitalized_name) \
                return self;                                                    \
            };                                                                  \
        }                                                                       \
        return _##lowercased_name;                                              \
    }

// ==========YGSTYLELAYOUT_SETTER_AUTO_VALUE/GETTER_AUTO_VALUE==========

#define YGSTYLELAYOUT_SETTER_AUTO_VALUE(lowercased_name, capitalized_name)                   \
    {                                                                                        \
        switch (lowercased_name.unit) {                                                      \
            case YGUnitPoint:                                                                \
                YGNodeStyleSet##capitalized_name(self.node, lowercased_name.value);          \
                break;                                                                       \
            case YGUnitPercent:                                                              \
                YGNodeStyleSet##capitalized_name##Percent(self.node, lowercased_name.value); \
                break;                                                                       \
            case YGUnitAuto:                                                                 \
                YGNodeStyleSet##capitalized_name##Auto(self.node);                           \
                break;                                                                       \
            default:                                                                         \
                NSAssert(NO, @"Not implemented");                                            \
        }                                                                                    \
    }

#define YGSTYLELAYOUT_GETTER_AUTO_VALUE(lowercased_name, capitalized_name)         \
    -(YGSL_##lowercased_name)lowercased_name {                                     \
        if (!_##lowercased_name) {                                                 \
            weakify(self);                                                         \
            _##lowercased_name = ^(YGValue lowercased_name) {                      \
                strongify(self);                                                   \
                YGSTYLELAYOUT_SETTER_AUTO_VALUE(lowercased_name, capitalized_name) \
                return self;                                                       \
            };                                                                     \
        }                                                                          \
        return _##lowercased_name;                                                 \
    }

// ==========YGSTYLELAYOUT_SETTER_EDGE_PROPERTY/GETTER_EDGE_PROPERTY==========

#define YGSTYLELAYOUT_SETTER_EDGE_PROPERTY(lowercased_name, property, edge) YGNodeStyleSet##property(self.node, edge, lowercased_name)

#define YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(lowercased_name, type, property, edge)    \
    -(YGSL_##lowercased_name)lowercased_name {                                       \
        if (!_##lowercased_name) {                                                   \
            weakify(self);                                                           \
            _##lowercased_name = ^(type lowercased_name) {                           \
                strongify(self);                                                     \
                YGSTYLELAYOUT_SETTER_EDGE_PROPERTY(lowercased_name, property, edge); \
                return self;                                                         \
            };                                                                       \
        }                                                                            \
        return _##lowercased_name;                                                   \
    }

// ==========YGSTYLELAYOUT_SETTER_YGVALUE_EDGE_PROPERTY/GETTER_YGVALUE_EDGE_PROPERTY==========

#define YGSTYLELAYOUT_SETTER_YGVALUE_EDGE_PROPERTY(objc_lowercased_name, c_name, edge)        \
    {                                                                                         \
        switch (objc_lowercased_name.unit) {                                                  \
            case YGUnitUndefined:                                                             \
                YGNodeStyleSet##c_name(self.node, edge, objc_lowercased_name.value);          \
                break;                                                                        \
            case YGUnitPoint:                                                                 \
                YGNodeStyleSet##c_name(self.node, edge, objc_lowercased_name.value);          \
                break;                                                                        \
            case YGUnitPercent:                                                               \
                YGNodeStyleSet##c_name##Percent(self.node, edge, objc_lowercased_name.value); \
                break;                                                                        \
            default:                                                                          \
                NSAssert(NO, @"Not implemented");                                             \
        }                                                                                     \
    }

#define YGSTYLELAYOUT_GETTER_YGVALUE_EDGE_PROPERTY(lowercased_name, property, edge)          \
    -(YGSL_##lowercased_name)lowercased_name {                                               \
        if (!_##lowercased_name) {                                                           \
            weakify(self);                                                                   \
            _##lowercased_name = ^(YGValue lowercased_name) {                                \
                strongify(self);                                                             \
                YGSTYLELAYOUT_SETTER_YGVALUE_EDGE_PROPERTY(lowercased_name, property, edge); \
                return self;                                                                 \
            };                                                                               \
        }                                                                                    \
        return _##lowercased_name;                                                           \
    }

#endif /* YGStyleLayoutDefine_h */
