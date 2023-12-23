//
//  YGStyleLayout.m
//  XuDevYoga
//
//  Created by zhaoxuzhang on 2022/4/15.
//

#import <UIKit/UIKit.h>
#import "YGStyleLayout.h"
#import "YGStyleLayout+Private.h"
#import "YGStyleLayoutUtility.h"
#import "UIView+YGStyleLayout.h"

static YGConfigRef globalConfig;

@interface YGStyleLayout ()

@property (nonatomic, weak) UIView *view;
@property (nonatomic, assign) YGNodeRef node;
@property (nonatomic, weak) YGStyleLayout *parent;
@property (nonatomic, strong) NSMutableArray<YGStyleLayout *> *children;
@property (nonatomic, assign) BOOL isIncludedInLayoutInternal;
@property (nonatomic, assign) BOOL isContainer;
@property (nonatomic, assign) CGRect frame;

@property (nonatomic, strong) YGStyleOverlayNode *overlayNode;

_YGSTYLELAYOUT_PROPERTY(addItem);
_YGSTYLELAYOUT_PROPERTY(addSpacer)
_YGSTYLELAYOUT_PROPERTY(addStack)
_YGSTYLELAYOUT_PROPERTY(define)
_YGSTYLELAYOUT_PROPERTY(isIncludedInLayout)
_YGSTYLELAYOUT_PROPERTY(direction)
_YGSTYLELAYOUT_PROPERTY(flexDirection)
_YGSTYLELAYOUT_PROPERTY(justifyContent)
_YGSTYLELAYOUT_PROPERTY(alignContent)
_YGSTYLELAYOUT_PROPERTY(alignItems)
_YGSTYLELAYOUT_PROPERTY(alignSelf)
_YGSTYLELAYOUT_PROPERTY(position)
_YGSTYLELAYOUT_PROPERTY(flexWrap)
_YGSTYLELAYOUT_PROPERTY(overflow)
_YGSTYLELAYOUT_PROPERTY(display)
_YGSTYLELAYOUT_PROPERTY(flexGrow)
_YGSTYLELAYOUT_PROPERTY(flexShrink)
_YGSTYLELAYOUT_PROPERTY(flexBasis)
_YGSTYLELAYOUT_PROPERTY(left)
_YGSTYLELAYOUT_PROPERTY(leftPercent)
_YGSTYLELAYOUT_PROPERTY(top)
_YGSTYLELAYOUT_PROPERTY(topPercent)
_YGSTYLELAYOUT_PROPERTY(right)
_YGSTYLELAYOUT_PROPERTY(rightPercent)
_YGSTYLELAYOUT_PROPERTY(bottom)
_YGSTYLELAYOUT_PROPERTY(bottomPercent)
_YGSTYLELAYOUT_PROPERTY(start)
_YGSTYLELAYOUT_PROPERTY(startPercent)
_YGSTYLELAYOUT_PROPERTY(end)
_YGSTYLELAYOUT_PROPERTY(endPercent)
_YGSTYLELAYOUT_PROPERTY(all)
_YGSTYLELAYOUT_PROPERTY(allPercent)
_YGSTYLELAYOUT_PROPERTY(marginTop)
_YGSTYLELAYOUT_PROPERTY(marginTopPercent)
_YGSTYLELAYOUT_PROPERTY(marginLeft)
_YGSTYLELAYOUT_PROPERTY(marginLeftPercent)
_YGSTYLELAYOUT_PROPERTY(marginBottom)
_YGSTYLELAYOUT_PROPERTY(marginBottomPercent)
_YGSTYLELAYOUT_PROPERTY(marginRight)
_YGSTYLELAYOUT_PROPERTY(marginRightPercent)
_YGSTYLELAYOUT_PROPERTY(marginStart)
_YGSTYLELAYOUT_PROPERTY(marginStartPercent)
_YGSTYLELAYOUT_PROPERTY(marginEnd)
_YGSTYLELAYOUT_PROPERTY(marginEndPercent)
_YGSTYLELAYOUT_PROPERTY(marginHorizontal)
_YGSTYLELAYOUT_PROPERTY(marginHorizontalPercent)
_YGSTYLELAYOUT_PROPERTY(marginVertical)
_YGSTYLELAYOUT_PROPERTY(marginVerticalPercent)
_YGSTYLELAYOUT_PROPERTY(margin)
_YGSTYLELAYOUT_PROPERTY(marginPercent)
_YGSTYLELAYOUT_PROPERTY(marginInsets)
_YGSTYLELAYOUT_PROPERTY(paddingTop)
_YGSTYLELAYOUT_PROPERTY(paddingTopPercent)
_YGSTYLELAYOUT_PROPERTY(paddingLeft)
_YGSTYLELAYOUT_PROPERTY(paddingLeftPercent)
_YGSTYLELAYOUT_PROPERTY(paddingBottom)
_YGSTYLELAYOUT_PROPERTY(paddingBottomPercent)
_YGSTYLELAYOUT_PROPERTY(paddingRight)
_YGSTYLELAYOUT_PROPERTY(paddingRightPercent)
_YGSTYLELAYOUT_PROPERTY(paddingStart)
_YGSTYLELAYOUT_PROPERTY(paddingStartPercent)
_YGSTYLELAYOUT_PROPERTY(paddingEnd)
_YGSTYLELAYOUT_PROPERTY(paddingEndPercent)
_YGSTYLELAYOUT_PROPERTY(paddingHorizontal)
_YGSTYLELAYOUT_PROPERTY(paddingHorizontalPercent)
_YGSTYLELAYOUT_PROPERTY(paddingVertical)
_YGSTYLELAYOUT_PROPERTY(paddingVerticalPercent)
_YGSTYLELAYOUT_PROPERTY(padding)
_YGSTYLELAYOUT_PROPERTY(paddingPercent)
_YGSTYLELAYOUT_PROPERTY(paddingInsets)
_YGSTYLELAYOUT_PROPERTY(size)
_YGSTYLELAYOUT_PROPERTY(width)
_YGSTYLELAYOUT_PROPERTY(widthPercent)
_YGSTYLELAYOUT_PROPERTY(height)
_YGSTYLELAYOUT_PROPERTY(heightPercent)
_YGSTYLELAYOUT_PROPERTY(minWidth)
_YGSTYLELAYOUT_PROPERTY(minWidthPercent)
_YGSTYLELAYOUT_PROPERTY(minHeight)
_YGSTYLELAYOUT_PROPERTY(minHeightPercent)
_YGSTYLELAYOUT_PROPERTY(maxWidth)
_YGSTYLELAYOUT_PROPERTY(maxWidthPercent)
_YGSTYLELAYOUT_PROPERTY(maxHeight)
_YGSTYLELAYOUT_PROPERTY(maxHeightPercent)
_YGSTYLELAYOUT_PROPERTY(borderLeftWidth)
_YGSTYLELAYOUT_PROPERTY(borderTopWidth)
_YGSTYLELAYOUT_PROPERTY(borderRightWidth)
_YGSTYLELAYOUT_PROPERTY(borderBottomWidth)
_YGSTYLELAYOUT_PROPERTY(aspectRatio)
_YGSTYLELAYOUT_PROPERTY(backgroundColor)
_YGSTYLELAYOUT_PROPERTY(cornerRadius)
_YGSTYLELAYOUT_PROPERTY(userInteractionEnabled)
_YGSTYLELAYOUT_PROPERTY(overlay)
_YGSTYLELAYOUT_PROPERTY(overlayPosition)

@end

@implementation YGStyleLayout

#pragma mark - Override

+ (void)initialize {
    globalConfig = YGStyleLayoutUtility.globalConfig;
    YGConfigSetExperimentalFeatureEnabled(globalConfig, YGExperimentalFeatureWebFlexBasis, true);
    YGConfigSetPointScaleFactor(globalConfig, [UIScreen mainScreen].scale);
}

- (instancetype)initWithView:(nullable UIView *)view {
    self = [super init];
    if (self) {
        _view = view;
        _node = YGNodeNewWithConfig(YGStyleLayoutUtility.globalConfig);
        _children = [NSMutableArray array];
        _isIncludedInLayoutInternal = YES;
        [self reset];
    }
    return self;
}

- (void)dealloc {
    [self resetNode];
    _view = nil;
}

#pragma mark - Public

- (BOOL)isDirty {
    return YGNodeIsDirty(self.node);
}

- (BOOL)isLeaf {
    return self.view != nil && self.children.count == 0;
}

- (void)layout {
    [self innerLayoutWithDimensionFlexibility:YGStyleLayoutFlexibilityFlexibleNone];
}

- (void)layoutWithFlexibility:(YGStyleLayoutFlexibility)flexibility {
    [self innerLayoutWithDimensionFlexibility:flexibility];
}

- (void)markDirty {
    if (self.isDirty || !self.isLeaf) {
        return;
    }

    const YGNodeRef node = self.node;
    if (!YGNodeHasMeasureFunc(node)) {
        YGNodeSetMeasureFunc(node, YGMeasureViewFunc);
    }
    YGNodeMarkDirty(node);
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self calculateLayoutWithSize:size isSubThread:NO];
}

#pragma mark-- Getters

- (YGSL_addItem)addItem {
    if (!_addItem) {
        weakify(self);
        _addItem = ^(UIView *view) {
            strongify(self);
            YGStyleLayout *layout = self.parentLayoutWithNotNilView;
            [layout.view addSubview:view];
            view.ygStyleLayout.parent = self;
            view.ygStyleLayout.parent.isContainer = YES;
            [self.children addObject:view.ygStyleLayout];
            return view.ygStyleLayout;
        };
    }
    return _addItem;
}

- (nonnull YGSL_addSpacer)addSpacer {
    if (!_addSpacer) {
        weakify(self);
        _addSpacer = ^(CGFloat value) {
            strongify(self);
            YGStyleLayout *layout = [[YGStyleLayout alloc] initWithView:nil];
            layout.flexGrow(value).flexShrink(value);
            layout.parent = self;
            [self.children addObject:layout];
            return layout;
        };
    }
    return _addSpacer;
}

- (YGSL_addStack)addStack {
    if (!_addStack) {
        weakify(self);
        _addStack = ^(YGFlexDirection direction) {
            strongify(self);
            YGStyleLayout *layout = [[YGStyleLayout alloc] initWithView:nil];
            layout.flexDirection(direction);
            layout.parent = self;
            [self.children addObject:layout];
            return layout;
        };
    }
    return _addStack;
}

- (YGSL_define)define {
    if (!_define) {
        weakify(self);
        _define = ^(YGStyleLayoutConfigurationBlock block) {
            strongify(self);
            [self clearChildren];
            if (block) {
                block(self);
            }
            return self;
        };
    }
    return _define;
}

- (YGSL_isIncludedInLayout)isIncludedInLayout {
    if (!_isIncludedInLayout) {
        weakify(self);
        _isIncludedInLayout = ^(BOOL value) {
            strongify(self);
            self.isIncludedInLayoutInternal = value;
            return self;
        };
    }
    return _isIncludedInLayout;
}

- (YGSL_position)position {
    if (!_position) {
        weakify(self);
        _position = ^(YGPositionType position) {
            strongify(self);
            YGNodeStyleSetPositionType(self.node, position);
            return self;
        };
    }
    return _position;
}

YGSTYLELAYOUT_GETTER(YGDirection, direction, Direction)
YGSTYLELAYOUT_GETTER(YGFlexDirection, flexDirection, FlexDirection)
YGSTYLELAYOUT_GETTER(YGJustify, justifyContent, JustifyContent)
YGSTYLELAYOUT_GETTER(YGAlign, alignContent, AlignContent)
YGSTYLELAYOUT_GETTER(YGAlign, alignItems, AlignItems)
YGSTYLELAYOUT_GETTER(YGAlign, alignSelf, AlignSelf)
YGSTYLELAYOUT_GETTER(YGWrap, flexWrap, FlexWrap)
YGSTYLELAYOUT_GETTER(YGOverflow, overflow, Overflow)
YGSTYLELAYOUT_GETTER(CGFloat, flexGrow, FlexGrow)
YGSTYLELAYOUT_GETTER(CGFloat, flexShrink, FlexShrink)
YGSTYLELAYOUT_GETTER(CGFloat, aspectRatio, AspectRatio)
YGSTYLELAYOUT_GETTER(CGFloat, width, Width)
YGSTYLELAYOUT_GETTER(CGFloat, widthPercent, WidthPercent)
YGSTYLELAYOUT_GETTER(CGFloat, height, Height)
YGSTYLELAYOUT_GETTER(CGFloat, heightPercent, HeightPercent)
YGSTYLELAYOUT_GETTER(CGFloat, minWidth, MinWidth)
YGSTYLELAYOUT_GETTER(CGFloat, minHeight, MinHeight)
YGSTYLELAYOUT_GETTER(CGFloat, maxWidth, MaxWidth)
YGSTYLELAYOUT_GETTER(CGFloat, maxHeight, MaxHeight)
YGSTYLELAYOUT_GETTER_AUTO_VALUE(flexBasis, FlexBasis)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(left, CGFloat, Position, YGEdgeLeft)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(leftPercent, CGFloat, PositionPercent, YGEdgeLeft)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(top, CGFloat, Position, YGEdgeTop)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(topPercent, CGFloat, PositionPercent, YGEdgeTop)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(right, CGFloat, Position, YGEdgeRight)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(rightPercent, CGFloat, PositionPercent, YGEdgeRight)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(bottom, CGFloat, Position, YGEdgeBottom)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(bottomPercent, CGFloat, PositionPercent, YGEdgeBottom)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(start, CGFloat, Position, YGEdgeStart)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(startPercent, CGFloat, PositionPercent, YGEdgeStart)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(end, CGFloat, Position, YGEdgeEnd)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(endPercent, CGFloat, PositionPercent, YGEdgeEnd)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginLeft, CGFloat, Margin, YGEdgeLeft)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginLeftPercent, CGFloat, MarginPercent, YGEdgeLeft)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginTop, CGFloat, Margin, YGEdgeTop)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginTopPercent, CGFloat, MarginPercent, YGEdgeTop)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginRight, CGFloat, Margin, YGEdgeRight)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginRightPercent, CGFloat, MarginPercent, YGEdgeRight)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginBottom, CGFloat, Margin, YGEdgeBottom)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginBottomPercent, CGFloat, MarginPercent, YGEdgeBottom)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginStart, CGFloat, Margin, YGEdgeStart)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginStartPercent, CGFloat, MarginPercent, YGEdgeStart)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginEnd, CGFloat, Margin, YGEdgeEnd)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginEndPercent, CGFloat, MarginPercent, YGEdgeEnd)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginHorizontal, CGFloat, Margin, YGEdgeHorizontal)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginHorizontalPercent, CGFloat, MarginPercent, YGEdgeHorizontal)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginVertical, CGFloat, Margin, YGEdgeVertical)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginVerticalPercent, CGFloat, MarginPercent, YGEdgeVertical)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(margin, CGFloat, Margin, YGEdgeAll)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(marginPercent, CGFloat, MarginPercent, YGEdgeAll)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingLeft, CGFloat, Padding, YGEdgeLeft)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingLeftPercent, CGFloat, PaddingPercent, YGEdgeLeft)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingTop, CGFloat, Padding, YGEdgeTop)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingTopPercent, CGFloat, PaddingPercent, YGEdgeTop)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingRight, CGFloat, Padding, YGEdgeRight)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingRightPercent, CGFloat, PaddingPercent, YGEdgeRight)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingBottom, CGFloat, Padding, YGEdgeBottom)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingBottomPercent, CGFloat, PaddingPercent, YGEdgeBottom)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingStart, CGFloat, Padding, YGEdgeStart)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingStartPercent, CGFloat, PaddingPercent, YGEdgeStart)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingEnd, CGFloat, Padding, YGEdgeEnd)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingEndPercent, CGFloat, PaddingPercent, YGEdgeEnd)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingHorizontal, CGFloat, Padding, YGEdgeHorizontal)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingHorizontalPercent, CGFloat, PaddingPercent, YGEdgeHorizontal)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingVertical, CGFloat, Padding, YGEdgeVertical)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingVerticalPercent, CGFloat, PaddingPercent, YGEdgeVertical)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(padding, CGFloat, Padding, YGEdgeAll)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(paddingPercent, CGFloat, PaddingPercent, YGEdgeAll)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(borderLeftWidth, CGFloat, Border, YGEdgeLeft)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(borderTopWidth, CGFloat, Border, YGEdgeTop)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(borderRightWidth, CGFloat, Border, YGEdgeRight)
YGSTYLELAYOUT_GETTER_EDGE_PROPERTY(borderBottomWidth, CGFloat, Border, YGEdgeBottom)

- (YGSL_all)all {
    if (!_all) {
        weakify(self);
        _all = ^(CGFloat value) {
            strongify(self);
            YGValue pointValue = [YGStyleLayoutUtility pointValue:value];
            YGNodeStyleSetPosition(self.node, YGEdgeTop, pointValue.value);
            YGNodeStyleSetPosition(self.node, YGEdgeLeft, pointValue.value);
            YGNodeStyleSetPosition(self.node, YGEdgeRight, pointValue.value);
            YGNodeStyleSetPosition(self.node, YGEdgeBottom, pointValue.value);
            return self;
        };
    }
    return _all;
}

- (YGSL_all)allPercent {
    if (!_allPercent) {
        weakify(self);
        _allPercent = ^(CGFloat value) {
            strongify(self);
            YGValue pointValue = [YGStyleLayoutUtility percentValue:value];
            YGNodeStyleSetPositionPercent(self.node, YGEdgeTop, pointValue.value);
            YGNodeStyleSetPositionPercent(self.node, YGEdgeLeft, pointValue.value);
            YGNodeStyleSetPositionPercent(self.node, YGEdgeRight, pointValue.value);
            YGNodeStyleSetPositionPercent(self.node, YGEdgeBottom, pointValue.value);
            return self;
        };
    }
    return _allPercent;
}

- (YGSL_marginInsets)marginInsets {
    if (!_marginInsets) {
        weakify(self);
        _marginInsets = ^(UIEdgeInsets value) {
            strongify(self);
            YGNodeStyleSetMargin(self.node, YGEdgeTop, [YGStyleLayoutUtility pointValue:value.top].value);
            YGNodeStyleSetMargin(self.node, YGEdgeLeft, [YGStyleLayoutUtility pointValue:value.left].value);
            YGNodeStyleSetMargin(self.node, YGEdgeBottom, [YGStyleLayoutUtility pointValue:value.bottom].value);
            YGNodeStyleSetMargin(self.node, YGEdgeRight, [YGStyleLayoutUtility pointValue:value.right].value);
            return self;
        };
    }
    return _marginInsets;
}

- (YGSL_paddingInsets)paddingInsets {
    if (!_paddingInsets) {
        weakify(self);
        _paddingInsets = ^(UIEdgeInsets value) {
            strongify(self);
            YGNodeStyleSetPadding(self.node, YGEdgeTop, [YGStyleLayoutUtility pointValue:value.top].value);
            YGNodeStyleSetPadding(self.node, YGEdgeLeft, [YGStyleLayoutUtility pointValue:value.left].value);
            YGNodeStyleSetPadding(self.node, YGEdgeBottom, [YGStyleLayoutUtility pointValue:value.bottom].value);
            YGNodeStyleSetPadding(self.node, YGEdgeRight, [YGStyleLayoutUtility pointValue:value.right].value);
            return self;
        };
    }
    return _paddingInsets;
}

- (YGSL_size)size {
    if (!_size) {
        weakify(self);
        _size = ^(CGSize value) {
            strongify(self);
            YGNodeStyleSetWidth(self.node, [YGStyleLayoutUtility pointValue:value.width].value);
            YGNodeStyleSetHeight(self.node, [YGStyleLayoutUtility pointValue:value.height].value);
            return self;
        };
    }
    return _size;
}

- (YGSL_backgroundColor)backgroundColor {
    if (!_backgroundColor) {
        weakify(self);
        _backgroundColor = ^(UIColor *value) {
            strongify(self);
            self.view.backgroundColor = value;
            return self;
        };
    }
    return _backgroundColor;
}

- (YGSL_cornerRadius)cornerRadius {
    if (!_cornerRadius) {
        weakify(self);
        _cornerRadius = ^(CGFloat value) {
            strongify(self);
            self.view.layer.cornerRadius = value;
            self.view.layer.masksToBounds = YES;
            return self;
        };
    }
    return _cornerRadius;
}

- (YGSL_userInteractionEnabled)userInteractionEnabled {
    if (!_userInteractionEnabled) {
        weakify(self);
        _userInteractionEnabled = ^(BOOL value) {
            strongify(self);
            self.view.userInteractionEnabled = value;
            return self;
        };
    }
    return _userInteractionEnabled;
}

- (YGSL_display)display {
    if (!_display) {
        weakify(self);
        _display = ^(YGDisplay display) {
            strongify(self);
            YGNodeStyleSetDisplay(self.node, display);
            self.view.hidden = display != YGDisplayFlex;
            return self;
        };
    }
    return _display;
}

- (YGSL_overlay)overlay {
    if (!_overlay) {
        weakify(self);
        _overlay = ^(BOOL isOverlay) {
            strongify(self);
            if (isOverlay) {
                self.overlayNode = [[YGStyleOverlayNode alloc] init];
            } else {
                self.overlayNode = nil;
            }
            return self;
        };
    }
    return _overlay;
}

- (YGSL_overlayPosition)overlayPosition {
    if (!_overlayPosition) {
        weakify(self);
        _overlayPosition = ^(YGStyleLayoutOverlayPosition position) {
            strongify(self);
            if (self.overlayNode == nil) {
                self.overlayNode = [[YGStyleOverlayNode alloc] init];
            }
            self.overlayNode.position = position;
            return self;
        };
    }
    return _overlayPosition;
}

#pragma mark - Private

static YGSize YGMeasureViewFunc(YGNodeRef node, float width, YGMeasureMode widthMode, float height, YGMeasureMode heightMode) {
    const CGFloat constrainedWidth = (widthMode == YGMeasureModeUndefined) ? CGFLOAT_MAX : width;
    const CGFloat constrainedHeight = (heightMode == YGMeasureModeUndefined) ? CGFLOAT_MAX : height;
    UIView *view = (__bridge UIView *)YGNodeGetContext(node);
    __block CGSize sizeThatFits = CGSizeZero;
    if (![view isMemberOfClass:[UIView class]] || view.subviews.count > 0) {
        if ([[NSThread currentThread] isMainThread]) {
            sizeThatFits = [YGStyleLayoutUtility calculateViewSize:view constrainedWidth:constrainedWidth constrainedHeight:constrainedHeight];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                sizeThatFits = [YGStyleLayoutUtility calculateViewSize:view constrainedWidth:constrainedWidth constrainedHeight:constrainedHeight];
            });
        }
    }
    YGSize resultYGSize = YGSize();
    resultYGSize.width = YGSanitizeMeasurement(constrainedWidth, sizeThatFits.width, widthMode);
    resultYGSize.height = YGSanitizeMeasurement(constrainedHeight, sizeThatFits.height, heightMode);
    return resultYGSize;
}

static CGFloat YGSanitizeMeasurement(CGFloat constrainedSize, CGFloat measuredSize, YGMeasureMode measureMode) {
    CGFloat result = 0;
    if (measureMode == YGMeasureModeExactly) {
        result = constrainedSize;
    } else if (measureMode == YGMeasureModeAtMost) {
        result = MIN(constrainedSize, measuredSize);
    } else {
        result = measuredSize;
    }
    return result;
}

static void YGRemoveAllChildren(const YGNodeRef node) {
    if (node == NULL) {
        return;
    }
    YGNodeRemoveAllChildren(node);
}

static void YGAttachNodesFromViewHierachy(YGStyleLayout *const ygStyleLayout) {
    const YGNodeRef rootNode = ygStyleLayout.node;
    YGRemoveAllChildren(rootNode);

    if (ygStyleLayout.isLeaf) {
        YGNodeSetMeasureFunc(rootNode, YGMeasureViewFunc);
    } else {
        YGNodeSetMeasureFunc(rootNode, NULL);
    }
    for (YGStyleLayout *childNode in ygStyleLayout.children) {
        if (!childNode.isIncludedInLayoutInternal) {
            continue;
        }

        if (childNode.view == nil || childNode.view.hidden == NO) {
            YGNodeRef parentNode = YGNodeGetParent(childNode.node);
            if (parentNode != NULL) {
                YGNodeRemoveChild(parentNode, childNode.node);
            }
            YGNodeInsertChild(rootNode, childNode.node, YGNodeGetChildCount(rootNode));
            YGAttachNodesFromViewHierachy(childNode);
        }
    }
}

- (void)applyLayoutToViewHierarchy:(YGStyleLayout *)ygStyleLayout {
    NSCAssert([NSThread mainThread], @"[YGStyleLayout]Frame Setting should only be done on main thread!");

    if (!ygStyleLayout.isIncludedInLayoutInternal) {
        return;
    }

    YGNodeRef node = ygStyleLayout.node;
    UIView *view = ygStyleLayout.view;

    const CGFloat nodeX = YGNodeLayoutGetLeft(node);
    const CGFloat nodeY = YGNodeLayoutGetTop(node);
    const CGFloat nodeWidth = YGNodeLayoutGetWidth(node);
    const CGFloat nodeHeight = YGNodeLayoutGetHeight(node);

    const CGFloat x = nodeX + ((ygStyleLayout.parent != nil && ygStyleLayout.parent.view == nil) ? ygStyleLayout.parent.frame.origin.x : 0);
    const CGFloat y = nodeY + ((ygStyleLayout.parent != nil && ygStyleLayout.parent.view == nil) ? ygStyleLayout.parent.frame.origin.y : 0);
    const CGFloat width = nodeWidth;
    const CGFloat height = nodeHeight;

    ygStyleLayout.frame = CGRectMake([YGStyleLayoutUtility roundPixelValue:x],
                                     [YGStyleLayoutUtility roundPixelValue:y],
                                     [YGStyleLayoutUtility roundPixelValue:width],
                                     [YGStyleLayoutUtility roundPixelValue:height]);

    if (view != nil && view.hidden) {
        return;
    }
    if (view != nil && view != _view) {
        view.frame = ygStyleLayout.frame;
    }
    for (YGStyleLayout *childLayout in ygStyleLayout.children) {
        [self applyLayoutToViewHierarchy:childLayout];
    }
}

- (CGSize)calculateLayoutWithSize:(CGSize)size isSubThread:(BOOL)isSubThread {
    YGAttachNodesFromViewHierachy(self);
    const YGNodeRef node = self.node;
    //    if (!isSubThread) {
    YGNodeCalculateLayout(node, size.width, size.height, YGNodeStyleGetDirection(node));

    return CGSizeMake(YGNodeLayoutGetWidth(node), YGNodeLayoutGetHeight(node));
    //    } else {
    //        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //        weakify(self);
    //        dispatch_async(self.workerThread, ^{
    //            strongify_or_return(self);
    //            YGNodeCalculateLayout(node, size.width, size.height, YGNodeStyleGetDirection(node));
    //            dispatch_semaphore_signal(semaphore);
    //        });
    //        dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, YGSTYLELAYOUT_CALCULATE_SUB_THREAD_WAIT_TIME));
    //        return CGSizeMake(YGNodeLayoutGetWidth(node), YGNodeLayoutGetHeight(node));
    //    }
}

- (void)innerLayoutWithDimensionFlexibility:(YGStyleLayoutFlexibility)dimensionFlexibility {
    CGSize size = CGSizeZero;
    if (self.view != nil) {
        size = self.view.bounds.size;
    } else {
        size = self.frame.size;
    }
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return;
    }
    if (dimensionFlexibility & YGStyleLayoutFlexibilityFlexibleWidth) {
        size.width = YGUndefined;
    }
    if (dimensionFlexibility & YGStyleLayoutFlexibilityFlexibleHeight) {
        size.height = YGUndefined;
    }
    [self calculateLayoutWithSize:size isSubThread:NO];
    [self applyLayoutToViewHierarchy:self];
}

- (YGStyleLayout *)ancestorLayout {
    YGStyleLayout *layout = self;
    while (layout.parent != nil) {
        layout = layout.parent;
    }
    return layout;
}

- (YGStyleLayout *)parentLayoutWithNotNilView {
    YGStyleLayout *layout = self;
    while (layout != nil && layout.view == nil) {
        layout = layout.parent;
    }
    return layout;
}

- (void)clearChildren {
    for (YGStyleLayout *layout in _children) {
        if (layout.view != nil) {
            [layout.view removeFromSuperview];
        } else {
            [layout clearChildren];
        }
        layout.parent = nil;
    }
    [_children removeAllObjects];
}

- (void)reset {
    [self resetNode];
    _node = YGNodeNewWithConfig(globalConfig);
    YGNodeSetContext(_node, (__bridge void *)_view);
}

- (void)resetNode {
    if (_node != NULL) {
        YGNodeFree(_node);
    }
    _node = NULL;
}

@end
