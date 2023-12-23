//
//  CollectionViewControllerInOc.h
//  LayoutFrameworkBenchmark
//
//  Created by zhaoxuzhang on 2023/12/19.
//

#import <UIKit/UIKit.h>
#import "FeedItemDataInOc.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedItemYGStyleLayoutViewCollectionView : UICollectionViewCell

- (void)setData:(FeedItemDataInOc *)data;

@end

@interface CollectionViewControllerInOc : UICollectionViewController <UICollectionViewDelegateFlowLayout>

- (instancetype)initWithData:(NSMutableArray<FeedItemDataInOc *> *)data;

@end

NS_ASSUME_NONNULL_END
