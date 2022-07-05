//
//  FeedBackView.swift
//  App
//
//  Created by mac on 2022/7/5.
//

import UIKit
import Util

class FeedBackView: UIView {

    /// collectionView
    private lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = itemSpace
            layout.minimumInteritemSpacing = itemSpace
            let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isScrollEnabled = false
            collectionView.backgroundColor = .clear
            collectionView.register(FeedBackCell.self, forCellWithReuseIdentifier: "FeedBackCell")
            addSubview(collectionView)
            return collectionView
        }()
    
    /// 上传按钮
       private lazy var btnPost: FeedBacksPostButton = {
           $0.addTarget(self, action: #selector(btnPostClick(_:)), for: .touchUpInside)
           $0.isHidden = true
           addSubview($0)
           return $0
       }(FeedBacksPostButton())
       
       /// 长按拖拽元素
       private lazy var dragingItem: UIImageView = {
           $0.contentMode = .scaleAspectFill
           $0.layer.masksToBounds = true
//           superview?.insertSubview($0, aboveSubview: self)
           superview?.addSubview($0)
//           superview?.superview?.addSubview($0)
           return $0
       }(UIImageView())
       
       /// 拖拽位置
       private var indexPath: IndexPath?
    
    
    /// 宽高
        var itemLength: CGFloat = 0 {
            willSet {
                btnPost.snp.updateConstraints { (make) in
                    make.size.equalTo(CGSize(width: newValue, height: newValue))
                }
            }
            didSet {
                numberOfLines = 0
            }
        }
        
        /// 行数
        private var numberOfLines: Int = 0 {
            willSet {
                heightBlock?(itemLength + CGFloat(newValue) * (itemLength + itemSpace) + scale(24))
            }
        }
        
        /// 是否能删除
        private var canDelete: Bool = false
    
    /// 最大个数
        var maxCount: Int = 6
        
        /// 一行个数
        var rowCount: Int = 3
        
        /// 间隔
        var itemSpace: CGFloat = scale(20)
        
        /// 高度变化
        var heightBlock: ((CGFloat)->Void)?
        
        /// 按钮回调
        var btnPostBlock: (()->Void)?
        ///删除的回调
        var selectBlock:((_ arrData:[String])->Void)?
     
        
        /// 删除区域
        weak var vDeleteArea: MomentsDeleteView?
        
        /// 数据
        var arrData: [String] = [] {
            didSet {
                collectionView.reloadData()
            }
        }
    
    
    /// 初始化
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            collectionView.snp.makeConstraints { (make) in
                make.left.top.right.bottom.equalToSuperview()
            }
            
            btnPost.snp.makeConstraints { (make) in
//                make.left.top.equalTo(0)
                make.left.equalTo(scale(25))
                make.top.equalTo(scale(12))
//                make.size.equalTo(scale(82))
                make.width.height.equalTo(scale(82))
            }
            
        }
        
        /// 上传按钮点击回调
        @objc private func btnPostClick(_ sender: UIButton) {
            btnPostBlock?()
        }
    
    
    /// 长按事件
       public func longPress(_ gesture: UILongPressGestureRecognizer) {
           guard let target = gesture.view, isUserInteractionEnabled else {
               return
           }
           switch gesture.state {
           case .began:
               beginInteractiveMovement(target, position: gesture.location(in: target))
           case .changed:
               updateInteractiveMovement(target, position: gesture.location(in: target))
           case .ended:
               endInteractiveMovement(target)
           case .cancelled:
               endInteractiveMovement(target)
           default:
               break
           }
       }
    
    
    /// 长按开始
       private func beginInteractiveMovement(_ target: UIView, position: CGPoint) {
           
           guard let indexPath = collectionView.indexPathForItem(at: target.convert(position, to: collectionView)), indexPath.row < arrData.count else {
               return
           }
           
           let cell: FeedBackCell = collectionView.cellForItem(at: indexPath) as! FeedBackCell
           cell.isHidden = true
           
           dragingItem.frame = CGRect(origin: collectionView.convert(cell.frame.origin, to: target), size: cell.frame.size)
           dragingItem.image = cell.imageView.image
           dragingItem.isHidden = false
           
           UIView.animate(withDuration: 0.1, animations: {
               self.dragingItem.center = position
               self.dragingItem.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
               self.vDeleteArea?.showView()
           }) { (finished) in
               self.indexPath = indexPath
           }
       }
    
    
    /// 长按过程
        private func updateInteractiveMovement(_ target: UIView, position: CGPoint) {
            
            guard let indexPath = indexPath else {
                return
            }
            
            dragingItem.center = position
            
            if let vDeleteArea = vDeleteArea {
                if vDeleteArea.frame.contains(position) {
                    canDelete = true
                    vDeleteArea.isDelete = true
                } else {
                    canDelete = false
                    vDeleteArea.isDelete = false
                }
            }
            
            guard let targetIndexPath = collectionView.indexPathForItem(at: target.convert(position, to: collectionView)), targetIndexPath.row < arrData.count else {
                return
            }
            /// 交换位置
            collectionView.moveItem(at: indexPath, to: targetIndexPath)
            let obj = arrData[indexPath.row]
            arrData.remove(at: indexPath.row)
            arrData.insert(obj, at: targetIndexPath.row)
            self.indexPath = targetIndexPath
        }
    /// 长按结束
        private func endInteractiveMovement(_ target: UIView) {
            
            guard let indexPath = indexPath, let cell = collectionView.cellForItem(at: indexPath) else {
                return
            }
            
            isUserInteractionEnabled = false
            
            if (canDelete) {
                UIView.animate(withDuration: 0.1, animations: {
                    self.vDeleteArea?.hideView()
                }, completion: { (finished) in
                    self.arrData.remove(at: indexPath.row)
                    self.collectionView.reloadData()
                    cell.isHidden = false
                    self.dragingItem.isHidden = true
                    self.indexPath = nil
                    self.vDeleteArea?.isDelete = false
                    self.isUserInteractionEnabled = true
                    self.selectBlock?(self.arrData)
                })
            } else {
                let center = target.convert(cell.center, from: collectionView)
                UIView.animate(withDuration: 0.25, animations: {
                    self.dragingItem.transform = .identity
                    self.dragingItem.center = center
                    self.vDeleteArea?.hideView()
                }, completion: { (finished) in
                    cell.isHidden = false
                    
                    self.collectionView.reloadData()
                    
                    self.dragingItem.isHidden = true
                    self.indexPath = nil
                    self.vDeleteArea?.isDelete = false
                    self.isUserInteractionEnabled = true
                    self.selectBlock?(self.arrData)
                })
            }
         }

    /// 判断是不是按钮点击
      override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
          if !btnPost.isHidden && (collectionView.convert(btnPost.frame, from: self).contains(point)) {
              return btnPost
          }
          return super.hitTest(point, with: event)
      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    
    @objc func deleteGoodsAction(deleteBtn:UIButton){
        LXFLog("=========================\(deleteBtn.tag)")
        UIView.animate(withDuration: 0.1, animations: {
            self.vDeleteArea?.hideView()
        }, completion: { (finished) in
            self.arrData.remove(at: deleteBtn.tag)
            self.collectionView.reloadData()
            self.dragingItem.isHidden = true
            self.indexPath = nil
            self.vDeleteArea?.isDelete = false
            self.isUserInteractionEnabled = true
            self.selectBlock?(self.arrData)
        })
    }
}


extension FeedBackView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    /// cell个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = arrData.count
        if (count > 0 && count < maxCount) {
            if count >= 3{
                numberOfLines = 1
            }else{
                numberOfLines = 0
            }
//            let lines = count / rowCount
//            if (lines != numberOfLines) {
//                numberOfLines = lines
//            }
        }else{
            if count >= 3{
                numberOfLines = 1
            }else{
                numberOfLines = 0
            }
        }
        return min(count + 1, maxCount)
    }
    
    /// cell样式
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedBackCell", for: indexPath) as! FeedBackCell
        //cell.imageView.image = indexPath.row < arrData.count ? arrData[indexPath.row] : nil
        cell.imageView.sd_setImage(with: URL(string: indexPath.row < arrData.count ? arrData[indexPath.row] : ""))
        cell.deleteBtn.tag = indexPath.row
        cell.imageView.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteGoodsAction), for: .touchUpInside)
        
        
//        btnPost.setTitle("商品图" + String(arrData.count) + "/6", for: .normal)
        btnPost.tag = indexPath.row
        if arrData.count < 1{
            cell.deleteBtn.isHidden = true
        }
        if arrData.count > 0 {
            if indexPath.row == arrData.count {
                cell.deleteBtn.isHidden = true
            }else
            {
                cell.deleteBtn.isHidden = false
            }
//            btnPost.mainImage.isHidden = true
        }
        return cell
    }
    
    /// cell将要展示
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == arrData.count && indexPath.row < maxCount {
            let pos = convert(cell.frame.origin, from: collectionView)
            btnPost.snp.updateConstraints { (make) in
                make.top.equalTo(pos.y)
                make.left.equalTo(pos.x)
            }
        }
        btnPost.isHidden = arrData.count + 1 > maxCount
    }
    
    /// cell宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (itemLength == 0) {
            itemLength = (collectionView.frame.width - itemSpace * CGFloat(rowCount - 1)) / CGFloat(rowCount)
        }
        return CGSize(width: itemLength, height: itemLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: scale(12), left: scale(20), bottom: scale(12), right: scale(20))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return scale(12)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return scale(20)
    }
    
    
}

