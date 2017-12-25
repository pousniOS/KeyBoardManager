//
//  UIResponder+YYResponder.m
//  Base
//
//  Created by POSUN-MAC on 17/2/4.
//  Copyright © 2017年 POSUN-MAC. All rights reserved.
//

#import "UIResponder+YYResponder.h"
#import <objc/runtime.h>

static CGRect initFrame;
static UIButton *endButton=nil;

#define MainWindow [[UIApplication sharedApplication].delegate window]
#define IsEvent [self isMemberOfClass:[UITextField class]]||[self isMemberOfClass:[UITextView class]]
@implementation UIResponder (YYResponder)

-(instancetype)init
{
    if (self=[super init])
    {
        [self registerKeyboardManagement];
    }
    return self;
}
#pragma mark - ============ 其他 ============
-(void)registerKeyboardManagement
{
    if (IsEvent)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotificationAction:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotificationAction:) name:UIKeyboardWillShowNotification object:nil];
    }
}
-(void)dealloc
{
    if (IsEvent)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    }
}
#pragma mark - ============ 给类触发事件 ============
#pragma mark - 键盘通知
- (void)keyboardNotificationAction:(NSNotification *)notification
{
    if (!self.isFirstResponder)
    {
    }
    else
    {
        if ([notification.name isEqualToString:UIKeyboardWillHideNotification])
        {
            UIView *view =[MainWindow.subviews objectAtIndex:0];
            NSValue *value =[NSValue valueWithCGRect:initFrame];
            if (!([value isEqualToValue:[NSValue valueWithCGRect:CGRectNull]]||[value isEqualToValue:[NSValue valueWithCGRect:CGRectZero]]))
            {
                view.frame=initFrame;
                initFrame=CGRectZero;
            }
            [endButton removeFromSuperview];
            MainWindow.backgroundColor=[UIColor clearColor];
        }
        else if ([notification.name isEqualToString:UIKeyboardWillShowNotification])
        {
            CGRect keyboardFrame = ((NSValue *) notification.userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
            UIView *sfView=(UIView*)self;
            CGRect rect =[MainWindow convertRect:sfView.frame fromView:sfView.superview];
            CGFloat y=rect.origin.y+rect.size.height-keyboardFrame.origin.y;

            UIView *view =[MainWindow.subviews objectAtIndex:0];
            NSValue *value =[NSValue valueWithCGRect:initFrame];
            if ([value isEqualToValue:[NSValue valueWithCGRect:CGRectNull]]||[value isEqualToValue:[NSValue valueWithCGRect:CGRectZero]])
            {
                initFrame=view.frame;
            }
            if (!endButton)
            {
                endButton=[UIButton buttonWithType:UIButtonTypeSystem];
                endButton.frame=CGRectMake(keyboardFrame.size.width-69, keyboardFrame.origin.y-22, 64, 22);
                endButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                [endButton setTitle:@"结束编辑" forState:UIControlStateNormal];
                endButton.titleLabel.font=[UIFont systemFontOfSize:15.0f];
                [endButton addTarget:MainWindow action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            [MainWindow addSubview:endButton];
            MainWindow.backgroundColor=[UIColor whiteColor];
            if (y>0)
            {
                view.frame=CGRectMake(view.frame.origin.x, view.frame.origin.y-y-endButton.frame.size.height, view.frame.size.width, view.frame.size.height);
            }
        }
    }
}
#pragma mark - buttonAction
-(void)buttonAction:(UIButton *)sender
{
    [MainWindow endEditing:YES];
}
@end
