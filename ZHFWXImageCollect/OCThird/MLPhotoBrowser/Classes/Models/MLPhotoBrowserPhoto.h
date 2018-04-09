//
//  MLPhotoBrowserPhoto.h
//  MLPhotoBrowser
//
//  Created by 张磊 on 14-11-15.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MLPhotoBrowserAssets.h"

@interface MLPhotoBrowserPhoto : NSObject

/**
 *  自动适配是不是以下几种数据
 */
@property (nonatomic , strong) id photoObj;
/**
 *  传入对应的View,记录坐标
 */
@property (strong,nonatomic) UIView *toView;
/**
 *  保存相册模型
 */
@property (nonatomic , strong) MLPhotoBrowserAssets *asset;
/**
 *  URL地址
 */
@property (nonatomic , strong) NSURL *photoURL;
/**
 *  原图
 */
@property (nonatomic , strong) UIImage *photoImage;
/**
 *  缩略图
 */
@property (nonatomic , strong) UIImage *thumbImage;
/**
 *  传入一个图片对象，可以是URL/UIImage/NSString，返回一个实例
 */
+ (instancetype)photoAnyImageObjWith:(id)imageObj;
/**
 *  传入一个MLPhotoBrowserAssets对象，返回一个UIImage
 */
+ (UIImage *)getImageWithAssets:(MLPhotoBrowserAssets *)asset;

@end
