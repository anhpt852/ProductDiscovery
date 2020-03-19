//
//  APICacheManager.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/18/20.
//  Copyright © 2020 anhpt. All rights reserved.
//


#import "UIImage+Resizable.h"

@implementation UIImage (BNC)

#pragma mark - constructor

#pragma mark - destructor

#pragma mark - public class methods

- (UIImage *)resizable_image
{
    CGSize size = self.size;
    size.width = roundf((size.width)/2);
    size.height = roundf((size.height)/2);

    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(size.height, size.width, size.height, size.width)];
}

- (UIImage *)resizable_image:(CGFloat )width
{
    CGSize size = self.size;
    size.width = roundf((size.width)/2 - width);
    size.height = roundf((size.height)/2);
    
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(size.height, size.width, size.height, size.width) resizingMode:UIImageResizingModeStretch];
}

#pragma mark - private class methods

#pragma mark - override/overload

#pragma mark - public instance methods

#pragma mark - private instance methods

#pragma mark - public get/set methods

#pragma mark - private get/set methods

#pragma mark - public action methods

#pragma mark - private action methods

#pragma mark - delegate methods

@end
