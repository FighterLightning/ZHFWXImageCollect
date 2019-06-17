//
//  MainCell.swift
//  ZHFWXImageCollect
//
//  Created by 张海峰 on 2017/12/20.
//  Copyright © 2017年 张海峰. All rights reserved.
// 这是一个tableView与collectionView组合而成的demo，类似微信朋友圈浏览的部分功能，欢迎下载使用
//  使用说明：
// 1》引进OC第三方：SDWebImage，MLPhotoBrowser，DACircularProgress。这三个第三方主要实现图片点击浏览缩放功能，及图片保存功能。
// 2》桥接OC文件
// 3》根据个人项目需求，比照我的代码搭出框架即可使用。注释比较清晰，需要写的代码也比较清晰简单。（自己写的总代码不超过300行）
// 4》新手需要注意桥接Build Settings ------> Objective-C Bridging Header  把ZHFWXImageCollect-Bridging-Header.h在你电脑的位置拖进去。
// 该demo地址：https://github.com/FighterLightning/ZHFWXImageCollect.git

import UIKit
private let collectionCell = "collectionCell"
let edgeMargin : CGFloat = 5
class MainCell: UITableViewCell {
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!//昵称
    @IBOutlet weak var contentLabel: UILabel! //内容
    @IBOutlet weak var timeLabel: UILabel!//时间
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewW: NSLayoutConstraint!
    @IBOutlet weak var collectionViewH: NSLayoutConstraint!
    var mainModel :MainModel = MainModel(){
          didSet{
            portraitImageView.image = UIImage.init(named: mainModel.user_pic!)
            titleLabel.text = mainModel.nickname
            contentLabel.text = mainModel.content
            timeLabel.text = mainModel.time
        }
    }
    var images: [String] = [String](){
        didSet{
            let itemWH : CGFloat = (ScreenWidth - 80 - 25 - 4 * edgeMargin)/3 //80左边距离 25右边距离
            //根据图片数量计算collectionView的宽高进行布局
            let layout  = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            //默认是正方形item
            layout.itemSize = CGSize.init(width: itemWH, height: itemWH)
            if images.count == 0{
                collectionViewH.constant = 0
            }
            else if images.count == 1{
                collectionViewW.constant = mainModel.imageW
                collectionViewH.constant = mainModel.imageH
                layout.itemSize = CGSize.init(width: mainModel.imageW - 10 , height:  mainModel.imageH - 10 )
            }
            else if images.count < 4{
                collectionViewW.constant = (itemWH + 5) * CGFloat(images.count) + 5 + 1 //加1 中和误差
                collectionViewH.constant = itemWH + 5
            }
            else if images.count == 4 {
                collectionViewW.constant = itemWH * 2 + 5 + 5 + 5 + 1 //加1 中和误差
                collectionViewH.constant = itemWH * 2 + 5 + 5 + 1 //加1 中和误差
            }
            else if images.count <= 6
            {
                collectionViewW.constant = ScreenWidth - 80 - 25
                collectionViewH.constant = itemWH * 2 + 5 + 5
            }
            else{
                collectionViewW.constant = ScreenWidth - 80 - 25
                collectionViewH.constant = ScreenWidth - 80 - 25 + 5
            }
            layout.minimumLineSpacing = edgeMargin
            layout.minimumInteritemSpacing = edgeMargin
            //注册cell
            collectionView.register(UINib.init(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: collectionCell)
            collectionView.dataSource = self
            collectionView.delegate = self
            //设置collectionView的内边距
            collectionView.contentInset = UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: 0, right: edgeMargin)
           // UIApplication.shared.keyWindow?.addSubview()
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
extension MainCell :UICollectionViewDataSource,UICollectionViewDelegate,MLPhotoBrowserViewControllerDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as! CollectionCell
        cell.imageView.image = UIImage.init(named: images[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       lookImage(indexRow: indexPath.item)
    }
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func lookImage(indexRow: NSInteger){
        // 图片游览器
        let photoBrowser :MLPhotoBrowserViewController = MLPhotoBrowserViewController.init()
        // 缩放动画
        photoBrowser.status = UIViewAnimationAnimationStatus.zoom
        // 可以删除
        photoBrowser.isEditing = false;
        // delegate
        // photoBrowser.delegate = self as! MLPhotoBrowserViewControllerDelegate;
        // 数据源
        photoBrowser.dataSource = self
        // 当前选中的值
        photoBrowser.currentIndexPath = NSIndexPath.init(item: indexRow, section: 0) as IndexPath?
        // 展示控制器
        photoBrowser.show()
    }
    func numberOfSectionInPhotos(inPhotoBrowser photoBrowser: MLPhotoBrowserViewController!) -> Int {
        return 1
    }
    func photoBrowser(_ photoBrowser: MLPhotoBrowserViewController!, numberOfItemsInSection section: UInt) -> Int {
        return images.count
    }
    func photoBrowser(_ photoBrowser: MLPhotoBrowserViewController!, photoAt indexPath: IndexPath!) -> MLPhotoBrowserPhoto! {
        let image: UIImage = UIImage.init(named: images[indexPath.row])!
        let photo :MLPhotoBrowserPhoto = MLPhotoBrowserPhoto.init(anyImageObjWith: image)
        let cell : CollectionCell = collectionView.cellForItem(at: indexPath) as! CollectionCell
        photo.toView = cell.imageView
        photo.thumbImage = cell.imageView.image;
        return photo
    }
    
}

