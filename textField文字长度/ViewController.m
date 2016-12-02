//
//  ViewController.m
//  textField文字长度
//
//  Created by mybook on 2016/12/2.
//  Copyright © 2016年 石塔Mr.GC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self testTextField];
}
- (void)testTextField
{
    UITextField *field = [[UITextField alloc] init];
    field.frame = CGRectMake(100, 155, 200, 50);
    [self.view addSubview:field];
    field.backgroundColor = [UIColor grayColor];
    [field addTarget:self action:@selector(fieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)fieldTextDidChange:(UITextField *)textField
{
    /**
     *  最大输入长度,中英文字符都按一个字符计算
     */
    static int kMaxLength = 6;
    NSString *toBeString = textField.text;
    // 获取键盘输入模式
    NSString *lang = [[[UITextInputMode activeInputModes] firstObject] primaryLanguage];
    // 中文输入的时候,可能有markedText(高亮选择的文字),需要判断这种状态
    // zh-Hans表示简体中文输入, 包括简体拼音，健体五笔，简体手写
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮选择部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，表明输入结束,则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                // 截取子串
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    } else {
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            // 截取子串
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
