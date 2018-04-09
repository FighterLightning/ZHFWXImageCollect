//
//  ViewController.swift
//  ZHFWXImageCollect
//
//  Created by 张海峰 on 2017/12/20.
//  Copyright © 2017年 张海峰. All rights reserved.
//

import UIKit
import YYModel
class ViewController: UIViewController {
    let cellIdentity = "cellIdentity"
    var images: [UIImage] = [UIImage]()
    lazy var dataMarr: NSMutableArray = NSMutableArray()
    // MARK:- 懒加载属性
    lazy var tableView :UITableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()//设置UI
        setData()//设置数据源
    }
}
extension ViewController
{
    func setupUI(){
        //0.将tableView放进控制器的View中
        view.addSubview(tableView)
        //1. 设置tableView 的frame
        tableView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        //2. 设置代理
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: cellIdentity)
    }
    func setData(){
        var contentStr = "飞一般的感觉，"
        for i in 0 ..< 10 {
            contentStr =  contentStr + "每天一小步！"
            var arr : [String] =  [String]()
            for j in 0 ..< i{
             arr.append("\(j).jpg")
            }
            var dic1 :[String : Any] = ["nickname":"昵称\(i)",
                "user_pic":"\(i).jpg",
                "content":contentStr,
                "time":"\(i)小时前",
                "pics":arr ]
            //只有一张图片
            if i == 1{
                //可以换不同的图片进行尝试
                let image : UIImage = UIImage.init(named: "4.jpg")!
                if image.size.width > image.size.height{
                    //宽大于高时
                    dic1["imageW"] = ScreenWidth * 2 / 3
                    dic1["imageH"] = ScreenWidth * 2 / 3 * (image.size.height/image.size.width)
                }
                else{
                    //高大于等于宽时
                    dic1["imageW"] = ScreenWidth * 2 / 3 * (image.size.width/image.size.height)
                    dic1["imageH"] = ScreenWidth * 2 / 3
                }
            }
          let  mainModel:MainModel  =
            MainModel.yy_model(with: dic1)!
          self.dataMarr.add(mainModel)
            tableView.reloadData()
        }
    }
}
//MARK:-  设置TableViewDelegate,UITableViewDataSource 顺便实现起方法
extension ViewController :UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataMarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //此处要用var
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity) as! MainCell
        let mainModel:MainModel  = self.dataMarr[indexPath.row] as! MainModel;
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.mainModel = mainModel
        cell.images = mainModel.pics
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击\(indexPath.row)")
    }
}


