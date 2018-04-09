//
//  MLPhotoBrowserDatas.h
//  MLPhotoBrowser
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <UIKit/UIKit.h>

// 回调
typedef void(^callBackBlock)(id obj);

@interface MLPhotoBrowserDatas : NSObject

/**
 *  获取所有组
 */
+ (instancetype) defaultPicker;

/**
 *  传入一个AssetsURL来获取UIImage
 */
- (void) getAssetsPhotoWithURL:(NSURL *)url callBack:(callBackBlock)callBack;

@end
