//
//  APICacheManager.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/18/20.
//  Copyright © 2020 anhpt. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (Resizable)

/**
 return resizable image from current image
 edge insest generates from image size
 */
- (UIImage *)resizable_image;
- (UIImage *)resizable_image:(CGFloat )width;
@end
