
//
//  WeChatExtScope.h
//  MMCommon
//
//  Created by 陈志炯 on 2018/6/25.
//  Copyright © 2018年 WXG. All rights reserved.
//

#ifndef WeChatExtScope_h
#define WeChatExtScope_h

#import "EXTScope.h"

#define strongify_or_return(var, ...) \
    strongify(var) if (var == NULL) { return __VA_ARGS__; }

#pragma mark - Ignore Warning

// clang-format off
#define _DO_PRAGMA(a) _Pragma(metamacro_stringify(a))
#define _IGNORE_PRAGMA(type) _DO_PRAGMA(clang diagnostic ignored metamacro_stringify(type))

// {...}中的代码忽略指定类型的warning: IgnoreClangWarning(-Wnonnull, {...})
#define IgnoreClangWarning(WarningType, Stuff)                              \
    do {                                                                    \
        _Pragma("clang diagnostic push") _IGNORE_PRAGMA(WarningType) Stuff; \
        _Pragma("clang diagnostic pop")                                     \
    } while (0)

// BeginIgnoreClangWarning(-Wnonnull)
// ...
// EndIgnoreClangWarning
#define BeginIgnoreClangWarning(WarningType) \
    _Pragma("clang diagnostic push") \
    _IGNORE_PRAGMA(WarningType)

#define EndIgnoreClangWarning _Pragma("clang diagnostic pop")

#define BeginIgnoreDeprecatedDeclarationsWarning BeginIgnoreClangWarning(-Wdeprecated-declarations)
#define BeginIgnoreNonnullWarning BeginIgnoreClangWarning(-Wnonnull)

#define IgnorePerformSelectorLeakWarning(Stuff) IgnoreClangWarning(-Warc-performSelector-leaks, Stuff)
#define IgnorePerformSelectorUndeclaredWarning(Stuff) IgnoreClangWarning(-Wundeclared-selector, Stuff)
#define IgnoreNonnullWarning(Stuff) IgnoreClangWarning(-Wnonnull, Stuff)
// clang-format on

#endif /* WeChatExtScope_h */
