//
//  ReleaseGoodsViewController.swift
//  App
//
//  Created by mac on 2022/4/29.
//

import UIKit
import JFPopup
import HXPhotoPicker
import Util


class ReleaseGoodsViewController: BaseViewController {
    
    lazy var manager:HXPhotoManager = {
       let manager = HXPhotoManager()
        manager.configuration.openCamera = true
        manager.configuration.photoMaxNum = 6
        //是否可以单选模式下选择图片跳转到编辑界面
        manager.configuration.singleJumpEdit = true
        //是否可以裁剪
        manager.configuration.movableCropBox = true
        //是否可以移动裁剪编辑大小
        manager.configuration.movableCropBoxEditSize = true
        //是否可以保存到媒体库
        manager.configuration.saveSystemAblum = true
        manager.configuration.hideOriginalBtn = false
        return manager
    }()
    
    
    //相册里面图片数组
    var photoContentList:[UIImage] = [UIImage]()
    

    lazy var scrollView:UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        return scrollView
    }()
    
    
    
    lazy var goodsTextView:UITextView = {
        //placeholder
        //placeholderColor
       let goodsTextView = UITextView()
        goodsTextView.placeholder = "请输入商品名称"
        goodsTextView.placeholderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        return goodsTextView
    }()
    
    //图片视图
    lazy var pitureView:UIView = {
       let pitureView = UIView()
        pitureView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        return pitureView
    }()
    
    //添加图片的按键
    lazy var addPitureBtn:UIButton = {
       let addPitureBtn = UIButton()
        addPitureBtn.setTitle("商品图0/6", for: .normal)
        addPitureBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2"), for: .normal)
        addPitureBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        addPitureBtn.setBackgroundImage(UIImage(named: "Group 2650"), for: .normal)
        addPitureBtn.setImagePostion(type: .imageTop, Space: scale(57))
        return addPitureBtn
    }()
    
    
    //商品类目
    lazy var goodsContentLabel:UILabel = {
        let goodsContentLabel = UILabel()
        goodsContentLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        goodsContentLabel.text = "请选择"
        goodsContentLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return goodsContentLabel
    }()

    //商品描述
    lazy var goodsDescribe:UILabel = {
        let goodsDescribe = UILabel()
        goodsDescribe.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        goodsDescribe.text = "未填写"
        goodsDescribe.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return goodsDescribe
    }()
    
    
    
    //商品编码
    lazy var goodsCardTextField:UITextField = {
       let goodsCardTextField = UITextField()
        goodsCardTextField.placeholder = "请输入"
        goodsCardTextField.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        goodsCardTextField.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return goodsCardTextField
    }()
    
    
    
    //商品参数
    lazy var goodsParameter:UILabel = {
        let goodsParameter = UILabel()
        goodsParameter.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#C2C2C2")
        goodsParameter.text = "未设置"
        goodsParameter.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return goodsParameter
    }()
    
    //多规格
    lazy var specificationsSwitch:UISwitch = {
       let specificationsSwitch = UISwitch()
        specificationsSwitch.onTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        specificationsSwitch.isOn = true
        return specificationsSwitch
    }()
    
    //价钱
    lazy var priceTextfield:UITextField = {
        let priceTextfield = UITextField()
        priceTextfield.placeholder = "请输入"
        priceTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        goodsCardTextField.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return priceTextfield
    }()
    
    
    //库存
    lazy var stockTextfield:UITextField = {
        let stockTextfield = UITextField()
        stockTextfield.placeholder = "请输入"
        stockTextfield.attributedPlaceholder = NSAttributedString.init(string:"请输入", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.colorWithDyColorChangObject(lightColor:"#C2C2C2")])
        stockTextfield.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return stockTextfield
    }()
    
    //库存扣减方式
    lazy var stockReduceLabel:UILabel = {
       let stockReduceLabel = UILabel()
        stockReduceLabel.text = "拍下减库存"
        stockReduceLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        stockReduceLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return stockReduceLabel
    }()
    
    //默认模板
    lazy var defaultTemplate:UILabel = {
        let defaultTemplate = UILabel()
        defaultTemplate.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        defaultTemplate.text = "默认模板"
        defaultTemplate.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        return defaultTemplate
    }()
    
    //七天无理由退货
    lazy var returnGoodsSwitch:UISwitch = {
       let returnGoodsSwitch = UISwitch()
        returnGoodsSwitch.onTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        returnGoodsSwitch.isOn = true
        return returnGoodsSwitch
    }()
    
    
    //退换货运费险
    lazy var returnGoodsInsuranceSwitch:UISwitch = {
       let returnGoodsInsuranceSwitch = UISwitch()
        returnGoodsInsuranceSwitch.onTintColor = UIColor.colorWithDyColorChangObject(lightColor: "#333333")
        returnGoodsInsuranceSwitch.isOn = true
        return returnGoodsInsuranceSwitch
    }()
    
    //存为草稿
    lazy var saveBtn:UIButton = {
       let saveBtn = UIButton()
        saveBtn.setTitle("存为草稿", for: .normal)
        saveBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333"), for: .normal)
        saveBtn.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#C4C4C4").cgColor
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        saveBtn.layer.borderWidth = scale(1)
        saveBtn.layer.cornerRadius = scale(4)
        return saveBtn
    }()
    
    //发布
    lazy var publishBtn:UIButton = {
       let publishBtn = UIButton()
        publishBtn.setTitle("发布", for: .normal)
        publishBtn.setTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#ffffff"), for: .normal)
        publishBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#313336")
        publishBtn.titleLabel?.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        publishBtn.layer.cornerRadius = scale(4)
        return publishBtn
    }()
    
    
    //多规格
    var specificationsSView:UIView!
    //价钱
    var priceSView:UIView!
    //库存
    var stockSView:UIView!
    //库存扣减方式
    var stockReduceSView:UIView!
    //商品类目
    var goodsCategorySBtn:UIButton!
    //商品标题
    var goodsTitleSView:UIView!
    //主视图图片
    var mainSImage:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "发布商品"
        
        
        //对返回的按键进行处理
        self.navigationItem.leftBarButtonItem?.customView?.isHidden = true
        
        
        self.navigationItem.leftBarButtonItem?.customView = UIButton(setImage: "返回", setBackgroundImage: "", target: self, action: #selector(saveDraft))
        
        
        
        
        
        
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        //商品标题
        let goodsTitleView = UIView()
        goodsTitleSView = goodsTitleView
        goodsTitleView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(goodsTitleView)
        goodsTitleView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(118))
        }
        
        let goodsStarLabel = UILabel()
        goodsStarLabel.text = "*"
        goodsStarLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#E82626")
        goodsStarLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        goodsTitleView.addSubview(goodsStarLabel)
        
        goodsStarLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(scale(15))
            make.width.equalTo(scale(8))
            make.height.equalTo(scale(20))
        }
        
        
        let goodsTitleLabel = UILabel()
        goodsTitleLabel.text = "商品标题"
        goodsTitleLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        goodsTitleLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .regular)
        goodsTitleView.addSubview(goodsTitleLabel)
        goodsTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsStarLabel.snp.right).offset(scale(1))
            make.top.equalTo(scale(14))
            make.right.equalToSuperview()
            make.height.equalTo(scale(22))
        }
        
        goodsTitleView.addSubview(goodsTextView)
        goodsTextView.snp.makeConstraints { make in
            make.left.equalTo(scale(25))
            make.right.equalTo(-scale(16))
            make.top.equalTo(goodsTitleLabel.snp.bottom).offset(scale(12))
            make.bottom.equalTo(-scale(5))
        }
        
        scrollView.addSubview(pitureView)
        pitureView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.top.equalTo(goodsTitleView.snp.bottom)
            make.height.equalTo(scale(132))
        }
        
        
        pitureView.addSubview(addPitureBtn)
        addPitureBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(25))
            make.centerY.equalToSuperview()
            make.width.height.equalTo(scale(82))
        }
        
        addPitureBtn.addTarget(self, action: #selector(addPitureAction), for: .touchUpInside)
        
        
        let mainImage = UIImageView()
        mainImage.image = UIImage(named: "Group 2786")
        addPitureBtn.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(scale(31))
            make.height.equalTo(scale(19))
        }
        mainSImage = mainImage
        
        //商品类目
        let goodsCategoryBtn = UIButton()
        goodsCategoryBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(goodsCategoryBtn)
        goodsCategoryBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(pitureView.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
        goodsCategorySBtn = goodsCategoryBtn
        goodsCategoryBtn.tag = 0
        goodsCategoryBtn.addTarget(self, action: #selector(choiceCategoryAction), for: .touchUpInside)
        
        let goodsCategoryStarLabel = UILabel()
        goodsCategoryStarLabel.text = "*"
        goodsCategoryStarLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#E82626")
        goodsCategoryStarLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        goodsCategoryBtn.addSubview(goodsCategoryStarLabel)
        goodsCategoryStarLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(8))
            make.height.equalTo(scale(20))
        }
        
        let goodsCategoryLabel = UILabel()
        goodsCategoryLabel.text = "商品类目"
        goodsCategoryLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        goodsCategoryLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        goodsCategoryBtn.addSubview(goodsCategoryLabel)
        goodsCategoryLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsCategoryStarLabel.snp.right).offset(scale(1))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(75))
            make.height.equalTo(scale(22))
        }
        
        goodsCategoryBtn.addSubview(goodsContentLabel)
        goodsContentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(goodsCategoryLabel.snp.right).offset(scale(40))
            make.right.equalTo(-scale(40))
            make.height.equalTo(scale(22))
        }
        
        let goodsCategoryImage = UIImageView()
        goodsCategoryImage.image = UIImage(named: "Frame-goods")
        goodsCategoryBtn.addSubview(goodsCategoryImage)
        goodsCategoryImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        //商品描述
        let goodsDescribeBtn = UIButton()
        goodsDescribeBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(goodsDescribeBtn)
        goodsDescribeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(goodsCategoryBtn.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
        goodsDescribeBtn.tag = 1
        goodsDescribeBtn.addTarget(self, action: #selector(choiceCategoryAction), for: .touchUpInside)
        
        let goodsDescribeStarLabel = UILabel()
        goodsDescribeStarLabel.text = "*"
        goodsDescribeStarLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#E82626")
        goodsDescribeStarLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        goodsDescribeBtn.addSubview(goodsDescribeStarLabel)
        goodsDescribeStarLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(8))
            make.height.equalTo(scale(20))
        }
        
        let goodsDescribeLabel = UILabel()
        goodsDescribeLabel.text = "商品描述"
        goodsDescribeLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        goodsDescribeLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        goodsDescribeBtn.addSubview(goodsDescribeLabel)
        goodsDescribeLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsCategoryStarLabel.snp.right).offset(scale(1))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(75))
            make.height.equalTo(scale(22))
        }
        
        goodsDescribeBtn.addSubview(goodsDescribe)
        goodsDescribe.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(goodsCategoryLabel.snp.right).offset(scale(40))
            make.right.equalTo(-scale(40))
            make.height.equalTo(scale(22))
        }
        
        let goodsDescribeImage = UIImageView()
        goodsDescribeImage.image = UIImage(named: "Frame-goods")
        goodsDescribeBtn.addSubview(goodsDescribeImage)
        goodsDescribeImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        //商品编码    goodsCardTextField
        let goodsCardView = UIView()
        goodsCardView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(goodsCardView)
        goodsCardView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(goodsDescribeBtn.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
        
        let goodsCardLabel = UILabel()
        goodsCardLabel.text = "商品编码"
        goodsCardLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        goodsCardLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        goodsCardView.addSubview(goodsCardLabel)
        goodsCardLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(75))
            make.height.equalTo(scale(22))
        }
        
        goodsCardView.addSubview(goodsCardTextField)
        goodsCardTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(goodsCardLabel.snp.right).offset(scale(48))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        //商品参数部分
        let goodsParameterLabel = UILabel()
        goodsParameterLabel.text = "    商品参数"
        goodsParameterLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        goodsParameterLabel.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        goodsParameterLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        scrollView.addSubview(goodsParameterLabel)
        goodsParameterLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.top.equalTo(goodsCardView.snp.bottom)
            make.height.equalTo(scale(42))
        }
        
        //商品参数
        let goodsParameterBtn = UIButton()
        goodsParameterBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(goodsParameterBtn)
        goodsParameterBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(goodsParameterLabel.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
        goodsParameterBtn.tag = 2
        goodsParameterBtn.addTarget(self, action: #selector(choiceCategoryAction), for: .touchUpInside)
        
        let goodsParameterStarLabel = UILabel()
        goodsParameterStarLabel.text = "*"
        goodsParameterStarLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#E82626")
        goodsParameterStarLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        goodsParameterBtn.addSubview(goodsParameterStarLabel)
        goodsParameterStarLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(8))
            make.height.equalTo(scale(20))
        }
        
        let goodsParametersLabel = UILabel()
        goodsParametersLabel.text = "商品参数"
        goodsParametersLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        goodsParametersLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        goodsParameterBtn.addSubview(goodsParametersLabel)
        goodsParametersLabel.snp.makeConstraints { make in
            make.left.equalTo(goodsCategoryStarLabel.snp.right).offset(scale(1))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(75))
            make.height.equalTo(scale(22))
        }
        
        goodsParameterBtn.addSubview(goodsParameter)
        goodsParameter.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(goodsCategoryLabel.snp.right).offset(scale(40))
            make.right.equalTo(-scale(40))
            make.height.equalTo(scale(22))
        }
        
        let goodsParameterImage = UIImageView()
        goodsParameterImage.image = UIImage(named: "Frame-goods")
        goodsParameterBtn.addSubview(goodsParameterImage)
        goodsParameterImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
        
        //规格部分
        let specificationsLabel = UILabel()
        specificationsLabel.text = "     规格和库存"
        specificationsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        specificationsLabel.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        specificationsLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        scrollView.addSubview(specificationsLabel)
        specificationsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.top.equalTo(goodsParameterBtn.snp.bottom)
            make.height.equalTo(scale(42))
        }
        
        
        //对规格
        let specificationsView = UIView()
        specificationsSView = specificationsView
        specificationsView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(specificationsView)
        specificationsView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(specificationsLabel.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
        
        let specificationLabel = UILabel()
        specificationLabel.text = "多规格"
        specificationLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        specificationLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        specificationsView.addSubview(specificationLabel)
        specificationLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(75))
            make.height.equalTo(scale(22))
        }
        
        specificationsView.addSubview(specificationsSwitch)
        specificationsSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(51))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(30))
        }
        //forcontrolevents:uicontroleventvaluechanged
        specificationsSwitch.addTarget(self, action: #selector(openAndCloseMoreSepcifications), for: .valueChanged)
        
        //价格
        let priceView = UIView()
        priceSView = priceView
        priceView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(specificationsView.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
//        priceBtn.tag = 3
//        priceBtn.addTarget(self, action: #selector(choiceCategoryAction), for: .touchUpInside)
        
        let priceStarLabel = UILabel()
        priceStarLabel.text = "*"
        priceStarLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#E82626")
        priceStarLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        priceView.addSubview(priceStarLabel)
        priceStarLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(8))
            make.height.equalTo(scale(20))
        }
        
        let pricesLabel = UILabel()
        pricesLabel.text = "价格(元)"
        pricesLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        pricesLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        priceView.addSubview(pricesLabel)
        pricesLabel.snp.makeConstraints { make in
            make.left.equalTo(priceStarLabel.snp.right).offset(scale(1))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(75))
            make.height.equalTo(scale(22))
        }
        
        priceView.addSubview(priceTextfield)
        priceTextfield.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(goodsCategoryLabel.snp.right).offset(scale(40))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        //库存
        let stockView = UIView()
        stockSView = stockView
        stockView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(stockView)
        stockView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(priceView.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
//        stockBtn.tag = 4
//        stockBtn.addTarget(self, action: #selector(choiceCategoryAction), for: .touchUpInside)
        
        let stockStarLabel = UILabel()
        stockStarLabel.text = "*"
        stockStarLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#E82626")
        stockStarLabel.font = UIFont.systemFont(ofSize: scale(14), weight: .medium)
        stockView.addSubview(stockStarLabel)
        stockStarLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(8))
            make.height.equalTo(scale(20))
        }
        
        let stocksLabel = UILabel()
        stocksLabel.text = "库存"
        stocksLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        stocksLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        stockView.addSubview(stocksLabel)
        stocksLabel.snp.makeConstraints { make in
            make.left.equalTo(stockStarLabel.snp.right).offset(scale(1))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(75))
            make.height.equalTo(scale(22))
        }
        
        stockView.addSubview(stockTextfield)
        stockTextfield.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(goodsCategoryLabel.snp.right).offset(scale(40))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        //库存扣减方式
        let stockReduceView = UIView()
        stockReduceSView = stockReduceView
        stockReduceView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(stockReduceView)
        stockReduceView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(stockView.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
        
        let stockReductsLabel = UILabel()
        stockReductsLabel.text = "库存扣减方式"
        stockReductsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        stockReductsLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        stockReduceView.addSubview(stockReductsLabel)
        stockReductsLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(112))
            make.height.equalTo(scale(22))
        }
        
        stockReduceView.addSubview(stockReduceLabel)
        stockReduceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(stockReductsLabel.snp.right).offset(scale(16))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(22))
        }
        
        //服务与承诺部分
        let serverLabel = UILabel()
        serverLabel.text = "     服务与承诺"
        serverLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        serverLabel.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#F8F8F8")
        serverLabel.font = UIFont.systemFont(ofSize: scale(13), weight: .regular)
        scrollView.addSubview(serverLabel)
        serverLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(SCW)
            make.top.equalTo(stockReduceView.snp.bottom)
            make.height.equalTo(scale(42))
        }
        
        //运费模板
        
        let freightBtn = UIButton()
        freightBtn.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(freightBtn)
        freightBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(serverLabel.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
        freightBtn.tag = 3
        freightBtn.addTarget(self, action: #selector(choiceCategoryAction), for: .touchUpInside)
        
        
        let freightLabel = UILabel()
        freightLabel.text = "运费模板"
        freightLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        freightLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        freightBtn.addSubview(freightLabel)
        freightLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(75))
            make.height.equalTo(scale(22))
        }
        
        freightBtn.addSubview(defaultTemplate)
        defaultTemplate.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(freightLabel.snp.right).offset(scale(48))
            make.right.equalTo(-scale(40))
            make.height.equalTo(scale(22))
        }
        
        let freightImage = UIImageView()
        freightImage.image = UIImage(named: "Frame-goods")
        freightBtn.addSubview(freightImage)
        freightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-scale(16))
            make.width.height.equalTo(scale(24))
        }
       
        //七天无理由退货
        
        let returnGoodsView = UIView()
        returnGoodsView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(returnGoodsView)
        returnGoodsView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(freightBtn.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
        
        let returnGoodsLabel = UILabel()
        returnGoodsLabel.text = "七天无理由退货"
        returnGoodsLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        returnGoodsLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        returnGoodsView.addSubview(returnGoodsLabel)
        returnGoodsLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(120))
            make.height.equalTo(scale(22))
        }
        
        returnGoodsView.addSubview(returnGoodsSwitch)
        returnGoodsSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(51))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(30))
        }
        
        //退换货运费险
        let transportView = UIView()
        transportView.backgroundColor = UIColor.colorWithDyColorChangObject(lightColor: "#ffffff")
        scrollView.addSubview(transportView)
        transportView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(returnGoodsView.snp.bottom).offset(scale(1))
            make.width.equalTo(SCW)
            make.height.equalTo(scale(50))
        }
        
        let transportLabel = UILabel()
        transportLabel.text = "退换货运费险"
        transportLabel.textColor = UIColor.colorWithDyColorChangObject(lightColor: "#787878")
        transportLabel.font = UIFont.systemFont(ofSize: scale(16), weight: .medium)
        transportView.addSubview(transportLabel)
        transportLabel.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(120))
            make.height.equalTo(scale(22))
        }
        
        transportView.addSubview(returnGoodsInsuranceSwitch)
        returnGoodsInsuranceSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(scale(51))
            make.right.equalTo(-scale(16))
            make.height.equalTo(scale(30))
        }
        
        scrollView.addSubview(saveBtn)
        saveBtn.snp.makeConstraints { make in
            make.left.equalTo(scale(16))
            make.top.equalTo(transportView.snp.bottom).offset(scale(35))
            make.width.equalTo(scale(120))
            make.height.equalTo(scale(44))
        }
        
        scrollView.addSubview(publishBtn)
        publishBtn.snp.makeConstraints { make in
            make.top.equalTo(transportView.snp.bottom).offset(scale(35))
            make.left.equalTo(saveBtn.snp.right).offset(scale(16))
            make.height.equalTo(scale(44))
            make.width.equalTo(SCW - scale(120) - scale(48))
        }
        scrollView.layoutIfNeeded()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        LXFLog(saveBtn.bottom)
        scrollView.contentSize = CGSize(width: 0, height: publishBtn.bottom + scale(127))
    }
    
    
    //商品类目 -- 0
    //商品描述 -- 1
    //商品参数 -- 2
    //运费模板 -- 3
    @objc func choiceCategoryAction(goodsCategoryBtn:UIButton){
        switch goodsCategoryBtn.tag {
        case 0:
            
            break
        case 1:
            let proudctDesciptionVc = ProductDescriptionViewController()
            Coordinator.shared?.pushViewController(self, proudctDesciptionVc, animated: true)
        case 2:
            
            break
            
        default:
            
            break
        }
        
        
        
        
        
    }
    
    //开启或者关闭多规格
    @objc func openAndCloseMoreSepcifications(specificationsSwitch:UISwitch){
        if specificationsSwitch.isOn == true{
            //开启
            priceSView.isHidden = false
            stockSView.isHidden = false
            stockReduceSView.snp.remakeConstraints { make in
                make.left.equalToSuperview()
                make.top.equalTo(stockSView.snp.bottom).offset(scale(1))
                make.width.equalTo(SCW)
                make.height.equalTo(scale(50))
            }
        }else{
           //关闭
            priceSView.isHidden = true
            stockSView.isHidden = true
            stockReduceSView.snp.remakeConstraints { make in
                make.left.equalToSuperview()
                make.top.equalTo(specificationsSView.snp.bottom).offset(scale(1))
                make.width.equalTo(SCW)
                make.height.equalTo(scale(50))
            }
        }
    }
    
    
    
    //返回保存草稿
    @objc func saveDraft(saveBtn:UIButton){
        JFPopup.alert {
            [
                .title("退出后不会保存此商品，你可以选择保存草稿"),
                .titleColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
//                .subTitle("注:取消商品将移至未上架"),
//                .subTitleColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 ")),
                .withoutAnimation(true),
                .cancelAction([
                    .text("直接退出"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#999999 ")),
                    .tapActionCallback({
                        Coordinator.shared?.popViewController(self, true)
                    })
                    
                ]),
                .confirmAction([
                    .text("保存草稿"),
                    .textColor(UIColor.colorWithDyColorChangObject(lightColor: "#333333")),
                    .tapActionCallback({
                        JFPopupView.popup.toast(hit: "点击了保存草稿")
                    })
                ])
            ]
        }
        
        
        
    }
    
    
    //添加图片---这边要处理addPitrueBtn的位置，和pitureView的大小
    @objc func addPitureAction(addPitrueBtn:UIButton){
        
        if self.photoContentList.count > 6 {
            JFPopup.toast(hit: "只能选择6张图片")
        }else{
            manager.type = .photo
            manager.clearSelectedList()
            self.popup.actionSheet {
                [
                    JFPopupAction(with: "从手机相册选择", subTitle: nil, clickActionCallBack: { [weak self] in
                        self?.hx_presentSelectPhotoController(with: self?.manager, didDone: { allList, photoList, videoList, isOriginal, viewController, manager in
                            photoList?.forEach({ HXPhotoModel in
                                //对图片进行
                                guard let image = HXPhotoModel.thumbPhoto else {
                                    return
                                }
                                if (self?.photoContentList.count ?? 7) <= 5{
                                    self?.photoContentList.append(image)
                                }
                            })
                            self?.addAndRefreshPhotoImage()
                        })
                    }),
                    JFPopupAction(with: "拍照", subTitle: nil, clickActionCallBack: {[weak self] in
                        self?.hx_presentCustomCameraViewController(with: self?.manager) { photoList, viewController in
                            LXFLog(photoList)
                            if let photoModel:HXPhotoModel = photoList{
                                //对图片进行
                                guard let image = photoModel.thumbPhoto else {
                                    return
                                }
                                if(self?.photoContentList.count ?? 7) <= 5{
                                    self?.photoContentList.append(image)
                                }
                            }
                            self?.addAndRefreshPhotoImage()
                        } cancel: { viewController in
                        }
                    })
                ]
            }
        }
    }
    
    
    func addAndRefreshPhotoImage(){
        pitureView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        if photoContentList.count > 0{
            mainSImage.isHidden = true
        }else{
            mainSImage.isHidden = false
        }
        let imageW = scale(82)
        for i in 0..<photoContentList.count {
           let imageView = UIImageView()
           if i == 0{
               let mainImage = UIImageView()
               mainImage.image = UIImage(named: "Group 2786")
               imageView.addSubview(mainImage)
               mainImage.snp.makeConstraints { make in
                   make.left.top.equalToSuperview()
                   make.width.equalTo(scale(31))
                   make.height.equalTo(scale(19))
               }
           }
           imageView.isUserInteractionEnabled = true
           imageView.tag = i
           let row = i / 3
           let colom = i % 3
           imageView.image = photoContentList[i]
//            imageView.backgroundColor = UIColor.blue
            let x = CGFloat(colom) * (imageW + scale(25)) + scale(25)
            let y = CGFloat(row) * (imageW + scale(25)) + scale(25)
            pitureView.addSubview(imageView)
            imageView.snp.remakeConstraints { make in
                make.left.equalTo(x)
                make.top.equalTo(y)
                make.width.height.equalTo(imageW)
            }
            imageView.layer.cornerRadius = scale(4)
            imageView.layer.borderWidth = scale(1)
            imageView.layer.borderColor = UIColor.colorWithDyColorChangObject(lightColor: "#E2E2E2").cgColor
            let deleteBtn = UIButton()
            deleteBtn.setBackgroundImage(UIImage(named: "Frame"), for: .normal)
            imageView.addSubview(deleteBtn)
            deleteBtn.addTarget(self, action: #selector(deleteGoodsAction), for: .touchUpInside)
            deleteBtn.tag = i
            deleteBtn.snp.makeConstraints { make in
                make.right.equalTo(scale(5))
                make.top.equalTo(-scale(5))
                make.width.height.equalTo(scale(24))
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(showBigPitrueAction))
            imageView.addGestureRecognizer(tap)
        }
        //这边要判断图片有多少张
        //最后是把selectImageBtn添加进去
        if photoContentList.count >= 3 {
            pitureView.snp.remakeConstraints { make in
                make.left.equalToSuperview()
                make.width.equalTo(SCW)
                make.top.equalTo(goodsTitleSView.snp.bottom)
                make.height.equalTo(scale(239))
            }
            pitureView.addSubview(addPitureBtn)
            if photoContentList.count != 6{
                addPitureBtn.isHidden = false
            }else{
                addPitureBtn.isHidden = true
            }
            let count = photoContentList.count - 3
            addPitureBtn.snp.remakeConstraints { make in
                make.left.equalTo(CGFloat(count) * (imageW + scale(25)) + scale(25))
                make.top.equalTo(2 * scale(25) + imageW)
                make.width.height.equalTo(imageW)
            }
            addPitureBtn.setTitle("商品图" + String(photoContentList.count) + "/6", for: .normal)
        }else{
            pitureView.addSubview(addPitureBtn)
            addPitureBtn.setTitle("商品图" + String(photoContentList.count) + "/6", for: .normal)
            self.addPitureBtn.isHidden = false
//            pitureView.height = imageW + scale(25)
            pitureView.snp.remakeConstraints { make in
                make.left.equalToSuperview()
                make.width.equalTo(SCW)
                make.top.equalTo(goodsTitleSView.snp.bottom)
                make.height.equalTo(scale(132))
            }
            let count = photoContentList.count
            addPitureBtn.snp.remakeConstraints { make in
                make.top.equalTo(scale(25))
                make.left.equalTo(CGFloat(count) * (imageW + scale(25)) + scale(25))
                make.width.height.equalTo(imageW)
            }
        }
    }
    
    //删除图片
    @objc func deleteGoodsAction(deleteBtn:UIButton){
        photoContentList.remove(at: deleteBtn.tag)
        addAndRefreshPhotoImage()
    }
    //图片浏览器
    @objc func showBigPitrueAction(tap:UITapGestureRecognizer){
       let imageView = tap.view as? UIImageView
        LXFLog(imageView?.tag)
    }
    
    
}
