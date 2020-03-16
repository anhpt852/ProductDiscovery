//
//  UIImage+BNC.h
//  webbnc
//
//  Created by Pham Duc Giam on 09/09/14.
//  Copyright (c) 2014 BNC. All rights reserved.
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
