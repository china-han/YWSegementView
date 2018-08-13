//
//  YWSelectCollectionViewCell.m
//  YWNabTagDemo
//
//  Created by hyw on 2018/7/26.
//  Copyright © 2018年 bksx. All rights reserved.
//

#import "YWSelectCollectionViewCell.h"

@implementation YWSelectCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _textLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _textLabel.font = [UIFont systemFontOfSize:14];
        //_textLabel.backgroundColor = UIColorFromRGB(0xF0F1F5);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.layer.cornerRadius = 3;
        // _textLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        // _textLabel.layer.borderWidth = 0.5;
        _textLabel.layer.masksToBounds = YES;
        _textLabel.textColor = [UIColor blackColor];
        //_textLabel.backgroundColor = [UIColor redColor];
        _textLabel.layer.borderWidth = 1;
        _textLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_textLabel];
        //_textLabel.userInteractionEnabled = YES;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _textLabel.frame = self.contentView.bounds;
}

-(void)setText:(NSString *)text{
    _text = text;
    _textLabel.text = _text;
}

@end
