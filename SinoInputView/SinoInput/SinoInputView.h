//
//  SinoInputView.h
//  SinoInputView
//
//  Created by ZKR on 4/16/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewExt.h"

@class  SinoInputView;

@protocol SinoInputDelegate <NSObject>

// 出现键盘
- (void)keyboardWillShow:(SinoInputView *)inputView keyboardHeight:(CGFloat)keyboardHeight animationDuration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve;

// 隐藏键盘
- (void)keyboardWillHide:(SinoInputView *)inputView keyboardHeight:(CGFloat)keyboardHeight animationDuration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve;

// 按钮点击事件
- (void)publishButtonDidClick:(UIButton *)button;

- (void)textViewHeightDidChange:(CGFloat)height;

@end

#pragma mark - SinoInputView

@interface SinoInputView : UIView  <SinoInputDelegate,UITextViewDelegate>

@property(weak,nonatomic) IBOutlet UITextView* inputTextView;// 输入框

@property(weak,nonatomic) IBOutlet UIButton* publishBtn;// 发布按钮

@property (weak, nonatomic) id<SinoInputDelegate> delegate;// 代理

- (IBAction)publishButtonClick:(id)sender;

- (void)resetInputView;


@end
