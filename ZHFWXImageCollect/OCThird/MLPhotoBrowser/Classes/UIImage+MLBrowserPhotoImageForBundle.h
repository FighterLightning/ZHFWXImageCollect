//
//  UIImage+MLImageForBundle.h
//  MLCamera
//
//  Created by 张磊 on 15/4/25.
//  Copyright (c) 2015年 www.weibo.com/makezl All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MLBrowserPhotoImageForBundle)
+ (instancetype)ml_imageFromBundleNamed:(NSString *)name;
@end
