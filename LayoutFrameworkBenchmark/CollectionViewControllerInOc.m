//
//  CollectionViewControllerInOc.m
//  LayoutFrameworkBenchmark
//
//  Created by zhaoxuzhang on 2023/12/19.
//

#import "CollectionViewControllerInOc.h"
#import "FeedItemDataInOc.h"
#import "FeedItemYGStyleLayoutView.h"

@interface CollectionViewControllerInOc ()

@property (nonatomic, strong) NSMutableArray<FeedItemDataInOc *> *data;
@property (nonatomic, strong) FeedItemYGStyleLayoutViewCollectionView *manequinCell;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation CollectionViewControllerInOc

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithData:(NSMutableArray<FeedItemDataInOc *> *)data {
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:self.flowLayout];
    if (self) {
        self.data = data;
        self.manequinCell = [[FeedItemYGStyleLayoutViewCollectionView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[FeedItemYGStyleLayoutViewCollectionView class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedItemYGStyleLayoutViewCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setData:self.data[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.manequinCell setData:self.data[indexPath.row]];
    CGSize size = [self.manequinCell sizeThatFits:CGSizeMake(collectionView.bounds.size.width, FLT_MAX)];
    size.width = collectionView.bounds.size.width;
    return size;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.flowLayout invalidateLayout];
}

@end

@interface FeedItemYGStyleLayoutViewCollectionView ()

@property (nonatomic, strong) FeedItemYGStyleLayoutView *layoutView;

@end

@implementation FeedItemYGStyleLayoutViewCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layoutView = [[FeedItemYGStyleLayoutView alloc] init];
        self.layoutView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.layoutView];
        self.layoutView.frame = self.contentView.bounds;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layoutView.frame = self.contentView.bounds;
}

- (void)setData:(FeedItemDataInOc *)data {
    [self.layoutView setData:data];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self.layoutView sizeThatFits:size];
}

@end

