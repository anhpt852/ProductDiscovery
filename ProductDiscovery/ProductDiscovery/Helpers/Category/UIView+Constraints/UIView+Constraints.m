//
//  UIView+Constraints.m
//  vatgia
//
//  Created by Pham Duc Giam on 03/03/16.
//  Copyright © 2016 maGicuD. All rights reserved.
//

#import "UIView+Constraints.h"

@implementation UIView (Constraints)

#pragma mark - constructor

#pragma mark - destructor

#pragma mark - public class methods

#pragma mark - private class methods

#pragma mark - override/overload

#pragma mark - public instance methods

- (void)addSubview:(UIView *)subview
            insets:(UIEdgeInsets)insets
{
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:subview];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:insets.top]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:insets.left]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-insets.bottom]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:-insets.right]];
}

#pragma mark - private instance methods

#pragma mark - public get/set methods

#pragma mark - private get/set methods

#pragma mark - public action methods

#pragma mark - private action methods

#pragma mark - delegate methods

@end
