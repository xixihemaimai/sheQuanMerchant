//
//  BaseViewController.swift
//  SheQuanMC
//
//  Created by mac on 2022/4/24.
//

import UIKit
import MJRefresh
import DZNEmptyDataSet
import Util

open class BaseViewController: UIViewController {

    
    //这边创建uitablview和collection的基础，并创建一些向下刷新，向上获取更多得一些数据
    
   public lazy var tableview:UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.estimatedSectionFooterHeight = 0
        tableview.estimatedSectionHeaderHeight = 0
        tableview.separatorStyle = .none
        if #available(iOS 15.0, *){
            tableview.sectionHeaderTopPadding = 0
        }
        if #available(iOS 11.0, *){
            tableview.contentInsetAdjustmentBehavior = .never
        }
        //这边要进行对没有数据进行设置
       tableview.emptyDataSetSource = self
       tableview.emptyDataSetDelegate = self
       
        //还需要对上拉和下拉的设置
       tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: {[unowned self] in
           self.headerRereshing()
       })
       
       
       let foot = MJRefreshAutoStateFooter(refreshingBlock: {[unowned self] in
           self.footerRereshing()
       })
       foot.setTitle("", for: MJRefreshState.idle)
       foot.setTitle("加载中...", for: MJRefreshState.refreshing)
       foot.setTitle("到底了～", for: MJRefreshState.noMoreData)
       tableview.mj_footer = foot
       return tableview
    }()
    
    
  public lazy var collection:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 0, height: 0)
        if #available(iOS 11.0, *){
            collection.contentInsetAdjustmentBehavior = .never
        }
        //这边要进行对没有数据的背景进行设置
      collection.emptyDataSetSource = self
      collection.emptyDataSetDelegate = self
      
      
      
        //还需要对上拉和下拉的设置
      collection.mj_header = MJRefreshNormalHeader(refreshingBlock: {[unowned self] in
          self.headerRereshing()
      })
        
      let foot = MJRefreshAutoStateFooter(refreshingBlock: {[unowned self] in
          self.footerRereshing()
      })
      foot.setTitle("", for: MJRefreshState.idle)
      foot.setTitle("加载中...", for: MJRefreshState.refreshing)
      foot.setTitle("到底了～", for: MJRefreshState.noMoreData)
      collection.mj_footer = foot
        return collection
    }()
    
    
    
   open override func viewDidLoad() {
        super.viewDidLoad()
       navigationController?.navigationBar.barTintColor = UIColor.white
       //设置背景颜色
       view.backgroundColor = viewControllerBackGroundColor
    }
    
    
   open func headerRereshing(){
       tableview.mj_header?.endRefreshing()
       collection.mj_header?.endRefreshing()
    }
    
   open func footerRereshing(){
       tableview.mj_footer?.endRefreshing()
       collection.mj_footer?.endRefreshing()
    }
    
    
    
}



extension BaseViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    
    //显示图片
    open func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "Group 2757")
    }
    
    
    //是否显示
    open func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    
}
