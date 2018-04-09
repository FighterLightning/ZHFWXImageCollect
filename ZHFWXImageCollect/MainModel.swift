//
//  MainModel.swift
//  ZHFWXImageCollect
//
//  Created by 张海峰 on 2017/12/20.
//  Copyright © 2017年 张海峰. All rights reserved.
//

import UIKit

@objcMembers class MainModel: NSObject {
    var nickname :String? // 昵称
    var user_pic :String? //头像
    var content :String? // 内容
    var time :String?//时间
    var pics : [String] = [] // 图片数组
    var imageW : CGFloat = 0 //图片的宽（确切的说时item的宽）
    var imageH : CGFloat = 0 //图片的高（确切的说时item的高）
}
