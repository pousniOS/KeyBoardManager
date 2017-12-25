//
//  ViewController.m
//  引入类别解决所有键盘遮挡输入框问题
//
//  Created by POSUN-MAC on 17/2/13.
//  Copyright © 2017年 POSUN-MAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (NSInteger i=0; i<13; i++)
    {
        UITextField *textField=[[UITextField alloc] initWithFrame:CGRectMake(0, (44+5)*i, self.view.frame.size.width, 44)];
        [self.view addSubview:textField];
        textField.borderStyle=UITextBorderStyleRoundedRect;
        textField.placeholder=[NSString stringWithFormat:@"%ld",i];
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
