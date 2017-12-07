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
    self.textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.textField.returnKeyType=UIReturnKeySearch;
    //[self setTextFieldLeftPadding:self.textField forWidth:25];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  
    
    if ([self.delegate respondsToSelector:@selector(customaSearchClikeReturn:textDid:)]) {
        [self.delegate customaSearchClikeReturn:textField textDid:self.textField.text];
    }
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


//自动弹出键盘
- (BOOL)becomeFirstResponder
{
    return [self.textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self.textField resignFirstResponder];
    return [super resignFirstResponder];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    DLog(@"textClear");
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
