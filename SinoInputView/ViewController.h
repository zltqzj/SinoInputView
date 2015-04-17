//
//  ViewController.h
//  SinoInputView
//
//  Created by ZKR on 4/16/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinoInputView.h"
#import "UIViewExt.h"
@interface ViewController : UIViewController<SinoInputDelegate>

@property(strong,nonatomic) IBOutlet UITextField* textField;

@property(strong,nonatomic) SinoInputView* sinoInput;
@property(nonatomic) CGFloat keyboardHeight;// 键盘高度

@end

