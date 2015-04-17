//
//  SinoInputView.m
//  SinoInputView
//
//  Created by ZKR on 4/16/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "SinoInputView.h"

static const NSInteger INPUT_HEIGHT = 30;
static const NSInteger WHOLE_VIEW_HEIGHT = 44;

@implementation SinoInputView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    _inputTextView.delegate = self;
}

- (IBAction)publishButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(publishButtonDidClick:)]) {
        [self.delegate publishButtonDidClick:sender];
    }
}

#pragma  mark - SinoInputDelegate

//键盘弹起
- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
     CGRect keyboardEndFrameWindow;
    [[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardEndFrameWindow];
   
    double keyboardTransitionDuration;
    [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardTransitionDuration];
    
    UIViewAnimationCurve keyboardTransitionAnimationCurve;
    [[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardTransitionAnimationCurve];
    
    // 参数 ： 高度，时间，速度
    if ([self.delegate respondsToSelector:@selector(keyboardWillShow:keyboardHeight:animationDuration:animationCurve:)]) {
        
        [self.delegate keyboardWillShow:self keyboardHeight:keyboardEndFrameWindow.size.height animationDuration:keyboardTransitionDuration animationCurve:keyboardTransitionAnimationCurve];
    }
}


// 键盘隐藏
- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];

    
    CGRect keyboardEndFrameWindow;//动画结束后的键盘位置
    [[userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardEndFrameWindow];
    
    double keyboardTransitionDuration;// 获取键盘的速度
    [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardTransitionDuration];
    
    UIViewAnimationCurve keyboardTransitionAnimationCurve;
    [[userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardTransitionAnimationCurve];
    if ([self.delegate respondsToSelector:@selector(keyboardWillHide:keyboardHeight:animationDuration:animationCurve:)]) {
        
        [self.delegate keyboardWillHide:self keyboardHeight:keyboardEndFrameWindow.size.height animationDuration:keyboardTransitionDuration animationCurve:keyboardTransitionAnimationCurve];
    }
}

-(void)resetInputView{
    self.height = WHOLE_VIEW_HEIGHT;
    self.inputTextView.height = INPUT_HEIGHT;
    [self setNeedsLayout];

}


#pragma  mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    //计算文本的高度
    CGSize constraintSize = CGSizeMake(textView.frame.size.width-16, 60);
    CGRect sizeFrame = CGRectZero;
    
    NSDictionary *attributes = @{NSFontAttributeName:textView.font};
    NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
    sizeFrame = [textView.text boundingRectWithSize:constraintSize options:options attributes:attributes context:NULL];
    
    sizeFrame.size.height += textView.font.lineHeight;
    textView.height = sizeFrame.size.height;
    //重新调整textView的高度
    if ([self.delegate respondsToSelector:@selector(textViewHeightDidChange:)]) {
        [self.delegate textViewHeightDidChange:textView.size.height];
    }

}




-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
