//
//  CustomSearchBar.h
//  yizu
//
//  Created by myMac on 2017/10/30.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSearchBar;

@protocol CustomSearchBarDelegate <NSObject>

- (void)customSearchBar:(CustomSearchBar *)searchBar textDidChange:(NSString *)text;

- (void)customSearchBarNeedDisMiss:(CustomSearchBar *)searchBar;

- (void)customSearchBarDidBeginEditing:(CustomSearchBar *)searchBar;

@end



@interface CustomSearchBar : UIView

@property (nonatomic,weak)id<CustomSearchBarDelegate>delegate;

+ (instancetype)makeCustomSearchBar;

- (void)changeSearchText:(NSString *)text;

@end
