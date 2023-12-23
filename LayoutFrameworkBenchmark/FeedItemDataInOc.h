//
//  FeedItemDataInOc.h
//  LayoutFrameworkBenchmark
//
//  Created by zhaoxuzhang on 2023/12/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedItemDataInOc : NSObject

@property (nonatomic, strong) NSString *actionText;
@property (nonatomic, strong) NSString *posterName;
@property (nonatomic, strong) NSString *posterHeadline;
@property (nonatomic, strong) NSString *posterTimestamp;
@property (nonatomic, strong) NSString *posterComment;
@property (nonatomic, strong) NSString *contentTitle;
@property (nonatomic, strong) NSString *contentDomain;
@property (nonatomic, strong) NSString *actorComment;

+ (NSMutableArray<FeedItemDataInOc *> *)generateWithCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
