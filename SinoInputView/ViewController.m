//
//  ViewController.m
//  SinoInputView
//
//  Created by ZKR on 4/16/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "ViewController.h"
#define FONT_SIZE 15
// 屏幕高度
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width

static inline UIViewAnimationOptions AnimationOptionsForCurve(UIViewAnimationCurve curve)
{
    return curve << 16;
}
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sinoInput = [[[NSBundle mainBundle] loadNibNamed:@"SinoInputView" owner:self options:nil] lastObject];
    _sinoInput.width = SCREEN_WIDTH;
     _sinoInput.bottom = self.view.bottom;
    _sinoInput.delegate = self;
    [self.view addSubview:_sinoInput];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark InputViewDelegate
- (void)textViewHeightDidChange:(CGFloat)height
{
  _sinoInput.height = height + 10;
   _sinoInput.bottom = self.view.height - self.keyboardHeight;
    
}
- (void)keyboardWillShow:(SinoInputView *)inputView keyboardHeight:(CGFloat)keyboardHeight animationDuration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve{
    
    self.keyboardHeight = keyboardHeight;
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:AnimationOptionsForCurve(animationCurve) | UIViewAnimationOptionBeginFromCurrentState
     
                     animations:^{
                         _sinoInput.bottom = self.view.height - keyboardHeight;
                     }
                     completion:^(__unused BOOL finished){
                         
                     }];
    
}

- (void)keyboardWillHide:(SinoInputView *)inputView keyboardHeight:(CGFloat)keyboardHeight animationDuration:(NSTimeInterval)duration animationCurve:(UIViewAnimationCurve)animationCurve
{
    self.keyboardHeight = 0;
    
    self.keyboardHeight = keyboardHeight;
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:AnimationOptionsForCurve(animationCurve) | UIViewAnimationOptionBeginFromCurrentState
     
                     animations:^{
                         _sinoInput.bottom = self.view.height;
                     }
                     completion:^(__unused BOOL finished){
                         
                     }];
}

// 按钮点击事件
- (void)publishButtonDidClick:(UIButton *)button{
    _textField.text =_sinoInput.inputTextView.text;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //判断内容长度是否>0，如果>0,重置键盘
    if ([_sinoInput.inputTextView.text isEqualToString:@""] || _sinoInput.inputTextView.text==nil|| [[_sinoInput.inputTextView.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""] || [_sinoInput.inputTextView.text isEqualToString:@"\n"]) {
        [_sinoInput resetInputView];

        [_sinoInput.inputTextView resignFirstResponder];

    }
    else{
        [_sinoInput.inputTextView resignFirstResponder];
    }
   
}
@end
