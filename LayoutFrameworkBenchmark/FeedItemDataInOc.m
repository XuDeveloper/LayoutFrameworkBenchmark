//
//  FeedItemDataInOc.m
//  LayoutFrameworkBenchmark
//
//  Created by zhaoxuzhang on 2023/12/19.
//

#import "FeedItemDataInOc.h"

@implementation FeedItemDataInOc

+ (NSMutableArray<FeedItemDataInOc *> *)generateWithCount:(NSInteger)count {
    NSMutableArray<FeedItemDataInOc *> *datas = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        FeedItemDataInOc *data = [[FeedItemDataInOc alloc] init];
        data.actionText = [NSString stringWithFormat:@"action text %ld", (long)i];
        data.posterName = [NSString stringWithFormat:@"poster name %ld", (long)i];
        data.posterHeadline = [NSString stringWithFormat:@"poster title %ld with some longer stuff", (long)i];
        data.posterTimestamp = [NSString stringWithFormat:@"poster timestamp %ld", (long)i];
        data.posterComment = [NSString stringWithFormat:@"poster comment %ld", (long)i];
        data.contentTitle = [NSString stringWithFormat:@"content title %ld", (long)i];
        data.contentDomain = [NSString stringWithFormat:@"content domain %ld", (long)i];
        data.actorComment = [NSString stringWithFormat:@"actor comment %ld", (long)i];
        [datas addObject:data];
    }
    return [datas mutableCopy];
}
@end

