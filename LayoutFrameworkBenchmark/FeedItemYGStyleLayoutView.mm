//
//  FeedItemYGStyleLayoutView.m
//  LayoutFrameworkBenchmark
//
//  Created by zhaoxuzhang on 2023/12/19.
//

#import "FeedItemYGStyleLayoutView.h"
#import "UIView+YGStyleLayout.h"

@interface FeedItemYGStyleLayoutView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *actionLabel;
@property (nonatomic, strong) UILabel *optionsLabel;
@property (nonatomic, strong) UIImageView *posterImageView;
@property (nonatomic, strong) UILabel *posterNameLabel;
@property (nonatomic, strong) UILabel *posterHeadlineLabel;
@property (nonatomic, strong) UILabel *posterTimeLabel;
@property (nonatomic, strong) UILabel *posterCommentLabel;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UILabel *contentTitleLabel;
@property (nonatomic, strong) UILabel *contentDomainLabel;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *shareLabel;
@property (nonatomic, strong) UIImageView *actorImageView;
@property (nonatomic, strong) UILabel *actorCommentLabel;

@end

@implementation FeedItemYGStyleLayoutView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.ygStyleLayout.addItem(self.contentView).alignSelf(YGAlignStretch).flexDirection(YGFlexDirectionColumn).justifyContent(YGJustifyFlexStart).flexGrow(1).flexShrink(1).padding(8).define(^(YGStyleLayout *style) {
            style.addStack(YGFlexDirectionRow).justifyContent(YGJustifySpaceBetween).define(^(YGStyleLayout *style) {
                style.addItem(self.actionLabel).flexShrink(1);
                style.addItem(self.optionsLabel).flexShrink(1);
            });
            
            style.addStack(YGFlexDirectionRow).alignItems(YGAlignCenter).define(^(YGStyleLayout *style) {
                style.addItem(self.posterImageView).width(50).height(50).marginRight(8);
                style.addStack(YGFlexDirectionColumn).alignItems(YGAlignFlexStart).define(^(YGStyleLayout *style) {
                    style.addItem(self.posterNameLabel);
                    style.addItem(self.posterHeadlineLabel);
                    style.addItem(self.posterTimeLabel);
                });
            });
            
            style.addItem(self.posterCommentLabel);
            
            style.addItem(self.contentImageView).aspectRatio(350 / 200.0);
            style.addItem(self.contentTitleLabel);
            style.addItem(self.contentDomainLabel);
            
            style.addStack(YGFlexDirectionRow).justifyContent(YGJustifySpaceBetween).marginTop(4).define(^(YGStyleLayout *style) {
                style.addItem(self.likeLabel);
                style.addItem(self.commentLabel);
                style.addItem(self.shareLabel);
            });
            
            style.addStack(YGFlexDirectionRow).marginTop(2).define(^(YGStyleLayout *style) {
                style.addItem(self.actorImageView).width(50).height(50).marginRight(8);
                style.addItem(self.actorCommentLabel).flexGrow(1);
            });
        });
    }
    return self;
}

- (void)setData:(FeedItemDataInOc *)data {
    self.actionLabel.text = data.actionText;
    self.posterNameLabel.text = data.posterName;
    self.posterHeadlineLabel.text = data.posterHeadline;
    self.posterTimeLabel.text = data.posterTimestamp;
    self.posterCommentLabel.text = data.posterComment;
    self.contentTitleLabel.text = data.contentTitle;
    self.contentDomainLabel.text = data.contentDomain;
    self.actorCommentLabel.text = data.actorComment;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self p_layout:self.bounds.size];
}

- (void)p_layout:(CGSize)size {
    [self.ygStyleLayout layout];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize ret = [self.ygStyleLayout sizeThatFits:CGSizeMake(size.width != FLT_MAX ? size.width : 1000, NAN)];
    return CGSizeMake(ret.width, ret.height + 4);
}

#pragma mark - Properties

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UILabel *)actionLabel {
    if (!_actionLabel) {
        _actionLabel = [[UILabel alloc] init];
        _actionLabel.font = [UIFont systemFontOfSize:17];
        _actionLabel.numberOfLines = 0;
    }
    return _actionLabel;
}

- (UILabel *)optionsLabel {
    if (!_optionsLabel) {
        _optionsLabel = [[UILabel alloc] init];
        _optionsLabel.font = [UIFont systemFontOfSize:17];
        _optionsLabel.text = @"...";
        _optionsLabel.numberOfLines = 0;
    }
    return _optionsLabel;
}

- (UIImageView *)posterImageView {
    if (!_posterImageView) {
        _posterImageView = [[UIImageView alloc] init];
        _posterImageView.image = [UIImage imageNamed:@"50x50.png"];
    }
    return _posterImageView;
}

- (UILabel *)posterNameLabel {
    if (!_posterNameLabel) {
        _posterNameLabel = [[UILabel alloc] init];
        _posterNameLabel.backgroundColor = UIColor.yellowColor;
    }
    return _posterNameLabel;
}

- (UILabel *)posterHeadlineLabel {
    if (!_posterHeadlineLabel) {
        _posterHeadlineLabel = [[UILabel alloc] init];
        _posterHeadlineLabel.backgroundColor = [UIColor yellowColor];
        _posterHeadlineLabel.numberOfLines = 3;
    }
    return _posterHeadlineLabel;
}

- (UILabel *)posterTimeLabel {
    if (!_posterTimeLabel) {
        _posterTimeLabel = [[UILabel alloc] init];
        _posterTimeLabel.backgroundColor = [UIColor yellowColor];
    }
    return _posterTimeLabel;
}

- (UILabel *)posterCommentLabel {
    if (!_posterCommentLabel) {
        _posterCommentLabel = [[UILabel alloc] init];
    }
    return _posterCommentLabel;
}

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.image = [UIImage imageNamed:@"350x200.png"];
        _contentImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _contentImageView;
}

- (UILabel *)contentTitleLabel {
    if (!_contentTitleLabel) {
        _contentTitleLabel = [[UILabel alloc] init];
    }
    return _contentTitleLabel;
}

- (UILabel *)contentDomainLabel {
    if (!_contentDomainLabel) {
        _contentDomainLabel = [[UILabel alloc] init];
    }
    return _contentDomainLabel;
}

- (UILabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.backgroundColor = [UIColor greenColor];
        _likeLabel.text = @"Like";
    }
    return _likeLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.text = @"Comment";
        _commentLabel.backgroundColor = [UIColor greenColor];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _commentLabel;
}

- (UILabel *)shareLabel {
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc] init];
        _shareLabel.text = @"Share";
        _shareLabel.backgroundColor = [UIColor greenColor];
        _shareLabel.textAlignment = NSTextAlignmentRight;
    }
    return _shareLabel;
}

- (UIImageView *)actorImageView {
    if (!_actorImageView) {
        _actorImageView = [[UIImageView alloc] init];
        _actorImageView.image = [UIImage imageNamed:@"50x50.png"];
    }
    return _actorImageView;
}

- (UILabel *)actorCommentLabel {
    if (!_actorCommentLabel) {
        _actorCommentLabel = [[UILabel alloc] init];
    }
    return _actorCommentLabel;
}

@end
