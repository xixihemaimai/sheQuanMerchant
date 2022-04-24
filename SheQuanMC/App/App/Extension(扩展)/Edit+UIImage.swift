//
//  Edit+UIImage.swift
//  测试暗黑和白天模式
//
//  Created by mac on 2022/3/15.
//

import Foundation
import UIKit
import AVFoundation


extension UIImage{
    // MARK: 1.1、设置图片的圆角
       /// 设置图片的圆角
       /// - Parameters:
       ///   - radius: 圆角大小 (默认:3.0,图片大小)
       ///   - corners: 切圆角的方式
       ///   - imageSize: 图片的大小
       /// - Returns: 剪切后的图片
       func isRoundCorner(radius: CGFloat = 3, byRoundingCorners corners: UIRectCorner = .allCorners, imageSize: CGSize?) -> UIImage? {
           let weakSize = imageSize ?? size
           let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: weakSize)
           // 开始图形上下文
           UIGraphicsBeginImageContextWithOptions(weakSize, false, UIScreen.main.scale)
           guard let contentRef: CGContext = UIGraphicsGetCurrentContext() else {
               // 关闭上下文
               UIGraphicsEndImageContext();
               return nil
           }
           // 绘制路线
           contentRef.addPath(UIBezierPath(roundedRect: rect,
                                       byRoundingCorners: UIRectCorner.allCorners,
                                       cornerRadii: CGSize(width: radius, height: radius)).cgPath)
           // 裁剪
           contentRef.clip()
           // 将原图片画到图形上下文
           draw(in: rect)
           contentRef.drawPath(using: .fillStroke)
           guard let output = UIGraphicsGetImageFromCurrentImageContext() else {
           // 关闭上下文
               UIGraphicsEndImageContext();
               return nil
           }
          // 关闭上下文
           UIGraphicsEndImageContext();
           return output
       }
    
    // MARK: 1.2、设置圆形图片
        /// 设置圆形图片
        /// - Returns: 圆形图片
        func isCircleImage() -> UIImage? {
            return isRoundCorner(radius: (self.size.width < self.size.height ? self.size.width : self.size.height) / 2.0, byRoundingCorners: .allCorners, imageSize: self.size)
        }
    
    
    
    // MARK: 1.3、获取视频的第一帧
       /// 获取视频的第一帧
       /// - Parameters:
       ///   - videoUrl: 视频 url
       ///   - maximumSize: 图片的最大尺寸
       /// - Returns: 视频的第一帧
       static func getVideoFirstImage(videoUrl: String, maximumSize: CGSize = CGSize(width: 1000, height: 1000), closure: @escaping (UIImage?) -> Void) {
           guard let url = URL(string: videoUrl) else {
               closure(nil)
               return
           }
           DispatchQueue.global().async {
               let opts = [AVURLAssetPreferPreciseDurationAndTimingKey: false]
               let avAsset = AVURLAsset(url: url, options: opts)
               let generator = AVAssetImageGenerator(asset: avAsset)
               generator.appliesPreferredTrackTransform = true
               generator.maximumSize = maximumSize
               var cgImage: CGImage? = nil
               let time = CMTimeMake(value: 0, timescale: 600)
               var actualTime : CMTime = CMTimeMake(value: 0, timescale: 0)
               do {
                   try cgImage = generator.copyCGImage(at: time, actualTime: &actualTime)
               } catch {
                   DispatchQueue.main.async {
                       closure(nil)
                   }
                   return
               }
               guard let image = cgImage else {
                   DispatchQueue.main.async {
                       closure(nil)
                   }
                   return
               }
               DispatchQueue.main.async {
                   closure(UIImage(cgImage: image))
               }
           }
       }
    
    
    // MARK: 1.4、layer 转 image
    /// layer 转 image
    /// - Parameters:
    ///   - layer: layer 对象
    ///   - scale: 缩放比例
    /// - Returns: 返回转化后的 image
    static func image(from layer: CALayer, scale: CGFloat = 0.0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    // MARK: 1.5、设置图片透明度
      /// 设置图片透明度
      /// alpha: 透明度
      /// - Returns: newImage
      func imageByApplayingAlpha(_ alpha: CGFloat) -> UIImage {
          UIGraphicsBeginImageContext(size)
          let context = UIGraphicsGetCurrentContext()
          let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)
          context?.scaleBy(x: 1, y: -1)
          context?.translateBy(x: 0, y: -area.height)
          context?.setBlendMode(.multiply)
          context?.setAlpha(alpha)
          context?.draw(self.cgImage!, in: area)
          let newImage = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          return newImage ?? self
      }

    // MARK: 1.6、裁剪给定区域
      /// 裁剪给定区域
      /// - Parameter crop: 裁剪区域
      /// - Returns: 剪裁后的图片
       func cropWithCropRect( _ crop: CGRect) -> UIImage? {
          let cropRect = CGRect(x: crop.origin.x * self.scale, y: crop.origin.y * self.scale, width: crop.size.width * self.scale, height: crop.size.height *  self.scale)
          if cropRect.size.width <= 0 || cropRect.size.height <= 0 {
              return nil
          }
         var image:UIImage?
          autoreleasepool{
              let imageRef: CGImage?  = self.cgImage!.cropping(to: cropRect)
              if let imageRef = imageRef {
                  image = UIImage(cgImage: imageRef)
              }
          }
          return image
      }
    
    // MARK: 1.7、给图片添加文字水印
    /// 给图片添加文字水印
    /// - Parameters:
    ///   - drawTextframe: 水印的 frame
    ///   - drawText: 水印文字
    ///   - withAttributes: 水印富文本
    /// - Returns: 返回水印图片
    func drawTextInImage(drawTextframe: CGRect, drawText: String, withAttributes: [NSAttributedString.Key : Any]? = nil) -> UIImage {
        // 开启图片上下文
        UIGraphicsBeginImageContext(self.size)
        // 图形重绘
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        // 水印文字属性
        let attributes = withAttributes
        // 水印文字和大小
        let text = NSString(string: drawText)
        // 获取富文本的 size
        // let size = text.size(withAttributes: attributes)
        // 绘制文字
        text.draw(in: drawTextframe, withAttributes: attributes)
        // 从当前上下文获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
    
        return image!
    }
/**
 -------------------------图片的拉伸和缩放
 
 */
    
    // MARK: 3.1、获取固定大小的 image
       /// 获取固定大小的image
       /// - Parameter size: 图片尺寸
       /// - Returns: 固定大小的 image
       func solidTo(size: CGSize) -> UIImage? {
           let w = size.width
           let h = size.height
           if self.size.height <= self.size.width {
               if self.size.width >= w {
                   let scaleImage = fixOrientation().scaleTo(size: CGSize(width: w, height: w * self.size.height / self.size.width))
                   return scaleImage
               } else {
                   return fixOrientation()
               }
           } else {
               if self.size.height >= h {
                   let scaleImage = fixOrientation().scaleTo(size: CGSize(width: h * self.size.width / self.size.height, height: h))
                   return scaleImage
               } else {
                   return fixOrientation()
               }
           }
       }

       // MARK: 3.2、按宽高比系数：等比缩放
       /// 按宽高比系数：等比缩放
       /// - Parameter scale: 要缩放的 宽高比 系数
       /// - Returns: 等比缩放 后的图片
       func scaleTo(scale: CGFloat) -> UIImage? {
           let w = self.size.width
           let h = self.size.height
           let scaledW = w * scale
           let scaledH = h * scale
           UIGraphicsBeginImageContext(size)
           self.draw(in: CGRect(x: 0, y: 0, width: scaledW, height: scaledH))
           let newImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return newImage;
       }

       // MARK: 3.3、按指定尺寸等比缩放
       /// 按指定尺寸等比缩放
       /// - Parameter size: 要缩放的尺寸
       /// - Returns: 缩放后的图片
       func scaleTo(size: CGSize) -> UIImage? {
           if self.cgImage == nil { return nil }
           var w = CGFloat(self.cgImage!.width)
           var h = CGFloat(self.cgImage!.height)
           let verticalRadio = size.height / h
           let horizontalRadio = size.width / w
           var radio: CGFloat = 1
           if verticalRadio > 1 && horizontalRadio > 1 {
               radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio
           } else {
               radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio
           }
           w = w * radio;
           h = h * radio;
           let xPos = (size.width - w) / 2;
           let yPos = (size.height - h) / 2;
           UIGraphicsBeginImageContext(size);
           draw(in: CGRect(x: xPos, y: yPos, width: w, height: h))
           let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
           UIGraphicsEndImageContext();
           return scaledImage;
       }
    
    
    
    // MARK: 3.4、图片中间 1*1 拉伸——如气泡一般
    /// 图片中间1*1拉伸——如气泡一般
    /// - Returns: 拉伸后的图片
    func strechAsBubble() -> UIImage {
        let top = self.size.height * 0.5;
        let left = self.size.width * 0.5;
        let bottom = self.size.height * 0.5;
        let right = self.size.width * 0.5;
        let edgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right);
        // 拉伸
        return self.resizableImage(withCapInsets: edgeInsets, resizingMode: .stretch)
    }

    // MARK: 3.5、调整图像方向 避免图像有旋转
    /// 调整图像方向 避免图像有旋转
    /// - Returns: 返正常的图片
    func fixOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -.pi / 2)
        default:
            break
        }
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: (self.cgImage?.bitsPerComponent)!, bytesPerRow: 0, space: (self.cgImage?.colorSpace)!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        ctx.concatenate(transform)
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        let cgImage: CGImage = ctx.makeImage()!
        return UIImage(cgImage: cgImage)
    }
    
    /**
     
     
     ----------------------------UIImage 压缩相关
     */
    
    
    // MARK: 压缩模式
    public enum CompressionMode {
        /// 分辨率规则
        private static let resolutionRule: (min: CGFloat, max: CGFloat, low: CGFloat, default: CGFloat, high: CGFloat) = (10, 4096, 512, 1024, 2048)
        /// 数据大小规则
        private static let  dataSizeRule: (min: Int, max: Int, low: Int, default: Int, high: Int) = (1024 * 10, 1024 * 1024 * 20, 1024 * 512, 1024 * 1024 * 2, 1024 * 1024 * 10)
        // 低质量
        case low
        // 中等质量 默认
        case medium
        // 高质量
        case high
        // 自定义(最大分辨率, 最大输出数据大小)
        case other(CGFloat, Int)

        fileprivate var maxDataSize: Int {
            switch self {
            case .low:
                return CompressionMode.dataSizeRule.low
            case .medium:
                return CompressionMode.dataSizeRule.default
            case .high:
                return CompressionMode.dataSizeRule.high
            case .other(_, let dataSize):
                if dataSize < CompressionMode.dataSizeRule.min {
                    return CompressionMode.dataSizeRule.default
                }
                if dataSize > CompressionMode.dataSizeRule.max {
                    return CompressionMode.dataSizeRule.max
                }
                return dataSize
            }
        }
    }
    
   
    
        // MARK: 4.3、压缩图片质量
        /// 压缩图片质量
        /// - Parameter maxSize: 最大数据大小
        /// - Returns: 压缩后数据
        func compressDataSize(maxSize: Int = 1024 * 1024 * 2) -> Data? {
            let maxSize = maxSize
            var quality: CGFloat = 0.8
            var data = self.jpegData(compressionQuality: quality)
            var dataCount = data?.count ?? 0
        
            while (data?.count ?? 0) > maxSize {
                if quality <= 0.6 {
                    break
                }
                quality  = quality - 0.05
                data = self.jpegData(compressionQuality: quality)
                if (data?.count ?? 0) <= dataCount {
                    break
                }
                dataCount = data?.count ?? 0
            }
            return data
        }

        // MARK: 4.4、ImageIO 方式调整图片大小 性能很好
        /// ImageIO 方式调整图片大小 性能很好
        /// - Parameter resizeSize: 图片调整Size
        /// - Returns: 调整后图片
        func resizeIO(resizeSize: CGSize) -> UIImage? {
            if size == resizeSize {
                return self
            }
            guard let imageData = pngData() else { return nil }
            guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil) else { return nil }
        
            let maxPixelSize = max(size.width, size.height)
            let options = [kCGImageSourceCreateThumbnailWithTransform: true,
                       kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
                       kCGImageSourceThumbnailMaxPixelSize: maxPixelSize]  as CFDictionary
        
            let resizedImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options).flatMap{
                UIImage(cgImage: $0)
            }
        
            return resizedImage
        }
    
    // MARK: 4.5、CoreGraphics 方式调整图片大小 性能很好
        /// CoreGraphics 方式调整图片大小 性能很好
        /// - Parameter resizeSize: 图片调整Size
        /// - Returns: 调整后图片
        func resizeCG(resizeSize: CGSize) -> UIImage? {
            if size == resizeSize {
                return self
            }
            guard  let cgImage = self.cgImage else { return nil }
            guard  let colorSpace = cgImage.colorSpace else { return nil }
            guard let context = CGContext(data: nil,
                                      width: Int(resizeSize.width),
                                      height: Int(resizeSize.height),
                                      bitsPerComponent: cgImage.bitsPerComponent,
                                      bytesPerRow: cgImage.bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: cgImage.bitmapInfo.rawValue) else { return nil }
            context.interpolationQuality = .high
            context.draw(cgImage, in: CGRect(origin: .zero, size: resizeSize))
            let resizedImage = context.makeImage().flatMap {
                UIImage(cgImage: $0)
            }
            return resizedImage
        }
        
        
        /**
          -------------------------二维码的处理
         */
        
        // MARK: 5.1、生成二维码图片
            /// 生成二维码图片
            /// - Parameters:
            ///   - content: 二维码里面的内容
            ///   - size: 二维码的大小
            ///   - logoSize: logo的大小
            ///   - logoImage: logo图片
            /// - Returns: 返回生成二维码图片
            static func QRImage(with content: String, size: CGSize, isLogo: Bool = true, logoSize: CGSize?, logoImage: UIImage? = nil, logoRoundCorner: CGFloat? = nil) -> UIImage? {
                // 1、创建名为"CIQRCodeGenerator"的CIFilter
                let filter = CIFilter(name: "CIQRCodeGenerator")
                // 2、将filter所有属性设置为默认值
                filter?.setDefaults()
                // 3、将所需尽心转为UTF8的数据，并设置给filter
                let data = content.data(using: String.Encoding.utf8)
                filter?.setValue(data, forKey: "inputMessage")
                // 4、设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
                /*
                 L: 7%
                 M: 15%
                 Q: 25%
                 H: 30%
                 */
                filter?.setValue("H", forKey: "inputCorrectionLevel")
                // 5、拿到二维码图片，此时的图片不是很清晰，需要二次加工
                guard let outPutImage = filter?.outputImage else { return nil }
            
                return getHDImgWithCIImage(with: outPutImage, size: size, isLogo: isLogo, logoSize: logoSize, logoImage: logoImage, logoRoundCorner: logoRoundCorner)
            }
        
        
        
        // MARK: 调整二维码清晰度，添加水印图片
        /// 调整二维码清晰度，添加水印图片
        /// - Parameters:
        ///   - image: 模糊的二维码图片
        ///   - size: 二维码的宽高
        ///   - logoSize: logo的大小
        ///   - logoImage: logo图片
        /// - Returns: 添加 logo 图片后，清晰的二维码图片
        private static func getHDImgWithCIImage(with image: CIImage, size: CGSize, isLogo: Bool = true, logoSize: CGSize?, logoImage: UIImage? = nil, logoRoundCorner: CGFloat? = nil) -> UIImage? {
            let extent = image.extent.integral
            let scale = min(size.width / extent.width, size.height / extent.height)
            //1.创建bitmap
            let width = extent.width * scale
            let height = extent.height * scale
        
            // 创建基于GPU的CIContext对象,性能和效果更好
            let context = CIContext(options: nil)
            // 创建CoreGraphics image
            guard let bitmapImage = context.createCGImage(image, from: extent) else { return nil }
        
            // 创建一个DeviceGray颜色空间
            let cs = CGColorSpaceCreateDeviceGray()
            // CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
            // width：图片宽度像素
            // height：图片高度像素
            // bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
            // bitmapInfo：指定的位图应该包含一个alpha通道
            let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue) //图形上下文，画布
            bitmapRef?.interpolationQuality = CGInterpolationQuality.none //写入质量
            bitmapRef?.scaleBy(x: scale, y: scale) //调整“画布”的缩放
            bitmapRef?.draw(bitmapImage, in: extent) //绘制图片
        
            //2.保存bitmap到图片
            guard let scaledImage = bitmapRef?.makeImage() else { return nil }
        
            // 清晰的二维码图片
            let outputImage = UIImage(cgImage: scaledImage)
        
            guard isLogo == true, let logoSize = logoSize, let logoImage = logoImage else {
                return outputImage
            }
        
            var newLogo: UIImage = logoImage
            if let newLogoRoundCorner = logoRoundCorner, let roundCornerLogo = logoImage.isRoundCorner(radius: newLogoRoundCorner, byRoundingCorners: .allCorners, imageSize: logoSize) {
                newLogo = roundCornerLogo
            }
        
            // 给二维码加 logo 图
            UIGraphicsBeginImageContextWithOptions(outputImage.size, false, UIScreen.main.scale)
            outputImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            // 把水印图片画到生成的二维码图片上，注意尺寸不要太大（根据上面生成二维码设置的纠错程度设置），否则有可能造成扫不出来
            let waterImgW = logoSize.width
            let waterImgH = logoSize.height
            let waterImgX = (size.width - waterImgW) * 0.5
            let waterImgY = (size.height - waterImgH) * 0.5
            newLogo.draw(in: CGRect(x: waterImgX, y: waterImgY, width: waterImgW, height: waterImgH))
            let newPicture = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        
            return newPicture
        }
}
