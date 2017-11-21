//
//  CustomSearchBar.m
//  yizu
//
//  Created by myMac on 2017/10/30.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CustomSearchBar.h"

@interface CustomSearchBar ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation CustomSearchBar

+ (instancetype)makeCustomSearchBar
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CustomSearchBar" owner:nil options:nil] firstObject];
}
- (IBAction)pressCancelBtn:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(customSearchBarNeedDisMiss:)]) {
        [self.delegate customSearchBarNeedDisMiss:self];
    }
}

-(void)changeSearchText:(NSString *)text
{
    self.textField.text = text;
    [self searchTextDidChanged:self.textField];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //self.backgroundColor = subjectColor;
    self.textField.delegate = self;
    self.textField.clearButtonMode=UITextFieldViewModeAlways;
    self.textField.returnKeyType=UIReturnKeySearch;
    //[self setTextFieldLeftPadding:self.textField forWidth:25];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}
#pragma mark-搜索框输入内容
- (IBAction)searchTextDidChanged:(UITextField *)sender
{
    //self.placeBtn.titleLabel.hidden = self.textField.text.length > 0;
    if ([self.delegate respondsToSelector:@selector(customSearchBar:textDidChange:)]) {
        [self.delegate customSearchBar:self textDidChange:self.textField.text];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //[self beginOrEndEditing:YES];
    if ([self.delegate respondsToSelector:@selector(customSearchBarDidBeginEditing:)]) {
        [self.delegate customSearchBarDidBeginEditing:self];
    }
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    NSLog(@"456");
//    return YES;
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
