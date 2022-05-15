//
//  FreightTemplateViewController.swift
//  App
//
//  Created by mac on 2022/5/12.
//

import UIKit
import JFPopup
import Util

class FreightTemplateViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "运费模板"
        
        view.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(iPhoneX ? -scale(92) : -scale(58))
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(FreightTemplateCell.self, forCellReuseIdentifier: "FreightTemplateCell")
        
        
        
        let addTemplateBtn = UIButton()
        addTemplateBtn.setTitle("新建模板", for: .normal)
        addTemplateBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        addTemplateBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        addTemplateBtn.setImage(UIImage(named: "Group 2688"), for: .normal)
        addTemplateBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        addTemplateBtn.addTarget(self, action: #selector(addTemplateAction), for: .touchUpInside)
        view.addSubview(addTemplateBtn)
        
        addTemplateBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(44))
            make.bottom.equalTo(iPhoneX ? -scale(34) : -scale(10))
        }
        
        addTemplateBtn.layer.cornerRadius = scale(4)
        
        
        
    }
    
    @objc func addTemplateAction(addTemplateBtn:UIButton){
        
        let templateContentVc = TemplateContentViewController()
        templateContentVc.title = "新建模板"
        Coordinator.shared?.pushViewController(self, templateContentVc, animated: true)
    }
    
    //删除
    @objc func setDeleteAction(deleteBtn:UIButton){
        JFPopup.alert {
            [
                .title("确定要删除此模板吗？"),
                .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
//                .subTitle("注:取消商品将移至未上架"),
//                .subTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 ")),
                .withoutAnimation(true),
                .cancelAction([
                    .text("取消"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                    .tapActionCallback({
                        Coordinator.shared?.popViewController(self, true)
                    })
                    
                ]),
                .confirmAction([
                    .text("确定"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
                        JFPopupView.popup.toast(hit: "点击了保存草稿")
                    })
                ])
            ]
        }
    }
    
    //设置为默认
    @objc func setIsDefaultAction(isDefaultBtn:UIButton){
        var title:String;
        if isDefaultBtn.isSelected {
            title = "确定要将此模板取消默认吗"
        }else{
            title = "确定要将此模板设置为默认吗"
        }
        
        JFPopup.alert {
            [
                .title(title),
                .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
//                .subTitle("注:取消商品将移至未上架"),
//                .subTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 ")),
                .withoutAnimation(true),
                .cancelAction([
                    .text("取消"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999")),
                    .tapActionCallback({
                        
                        
                        
                    })
                    
                ]),
                .confirmAction([
                    .text("确定"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
//                        JFPopupView.popup.toast(hit: "点击了确定")
                        for i in 0..<3{
                            let cell = self.tableview.cellForRow(at: IndexPath(row: i, section: 0)) as! FreightTemplateCell
                            if isDefaultBtn.tag == i{
                            }else{
                                cell.isDefaultBtn.isSelected = false
                            }
                        }
                        isDefaultBtn.isSelected = !isDefaultBtn.isSelected
                    })
                ])
            ]
        }
    }
    
    //编辑
    @objc func setEditAction(editBtn:UIButton){
        let templateContentVc = TemplateContentViewController()
        templateContentVc.title = "修改模板"
        Coordinator.shared?.pushViewController(self, templateContentVc, animated: true)
    }


}

extension FreightTemplateViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FreightTemplateCell") as! FreightTemplateCell
        
        cell.isDefaultBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        
        cell.isDefaultBtn.addTarget(self, action: #selector(setIsDefaultAction), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(setDeleteAction), for: .touchUpInside)
        cell.editBtn.addTarget(self, action: #selector(setEditAction), for: .touchUpInside)
        
        return cell
    }
    
    
    
    
}
