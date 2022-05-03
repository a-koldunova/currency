import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        DispatchQueue.main.async {
            self.image = placeHolder
        }
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error!)")
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

extension UIImage {
    
    public func rotateImageByDegrees(_ degrees: CGFloat) -> UIImage {
        
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat.pi
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: self.size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
        
        // Rotate the image context
        bitmap?.rotate(by: degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        bitmap?.scaleBy(x: 1.0, y: -1.0)
        bitmap?.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
        
        let cgimage:CGImage  = bitmap!.makeImage()!
        return UIImage(cgImage: cgimage)
    }
    
    class func imageFromLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}


struct PictureUtils{
    
    static func resizeImageByWidth(_ image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        return resizeImage(image, newWidth: newWidth, newHeight: newHeight)
    }
    
    static func resizeImageByHeight(_ image: UIImage, newHeight: CGFloat) -> UIImage {
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        return resizeImage(image, newWidth: newWidth, newHeight: newHeight)
    }
    
     static func resizeImage(_ image: UIImage, newWidth: CGFloat, newHeight: CGFloat) ->UIImage{
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
//    static func imageFromUrl(_ urlString:String, completionHandler: @escaping (UIImage?)->()){
//        if !isStringValid(urlString){
//            completionHandler(nil)
//            return
//        }
//        var request=URLRequest(url: URL(string: urlString)!)
//        for header in defaultHeaders{
//            let fieldValues=header.components(separatedBy: ":")
//            request.addValue(fieldValues[1], forHTTPHeaderField: fieldValues[0])
//        }
//        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//            if error == nil && data != nil{
//                let img=UIImage(data: data!)
//                completionHandler(img)
//            }
//            else{
//                completionHandler(nil)
//            }
//            })
//            .resume()
//    }
    
    static func saveImage(_ image: UIImage?, fileName:String?, imoNo:Int){
        if fileName == nil || image == nil{
            return
        }
        
        if let data = image!.jpegData(compressionQuality: 0.8) {
            let fn = FileUtils.getDirectoryUrl(imoNo.description).appendingPathComponent(fileName!)
            try? data.write(to: URL(fileURLWithPath: fn.path), options: [.atomic])
        }
    }
    
    static func saveTitleImage(_ image: UIImage, imoNo:Int){
        let screenSize: CGRect = UIScreen.main.bounds
        let pic=PictureUtils.resizeImageByWidth(image, newWidth: screenSize.width)
        if let data = pic.jpegData(compressionQuality: 0.8) {
            let filename = FileUtils.getDirectoryUrl(imoNo.description).appendingPathComponent("title.jpg")
            try? data.write(to: URL(fileURLWithPath: filename.path), options: [.atomic])
        }
    }
    
    static func saveTitleThumb(_ image:UIImage, imoNo:Int){
        let h=image.size.height
        let w=image.size.width
        
        var k=w/128.0
        if h/k>96{
            k=h/96.0
        }
        if k>0{
            let newWidth=w/k
            let thumb=PictureUtils.resizeImageByWidth(image, newWidth: newWidth)
            if let data = thumb.jpegData(compressionQuality: 0.8) {
                let filename = FileUtils.getDirectoryUrl(imoNo.description).appendingPathComponent("title_thumb.jpg")
                try? data.write(to: URL(fileURLWithPath: filename.path), options: [.atomic])
            }
        }
    }
    
    static func getImageWithColor(_ color: UIColor) -> UIImage {
        let size=CGSize(width: 1.0, height: 1.0)
        let rect = CGRect(x:0, y:0, width:size.width, height:size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    static func convertImageToBW(image:UIImage) -> UIImage {
        
        let filter = CIFilter(name: "CIPhotoEffectMono")
        let ciInput = CIImage(image: image)
        filter?.setValue(ciInput, forKey: "inputImage")
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciInput?.extent)!)  //ciOutput?.extent
        return UIImage(cgImage: cgImage!)
    }
    
    static func convertToGrayScale(image: UIImage) -> UIImage {
        let imageRect:CGRect = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        //CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image.cgImage!, in: imageRect)
        //CGContextDrawImage(context, imageRect, image.cgImage)
        
        if let imageRef = context?.makeImage(){
            return UIImage.init(cgImage: imageRef)
        }
        
        else{
            return image
        }
    }
    
    static func convertViewToImage(view: UIView)->UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshotImageFromMyView!
    }
    
    static func textToImage(drawText text: NSString, inImage image: UIImage, textColor: UIColor) -> UIImage {
        //let textColor = UIColor.yellow
        let textFont = UIFont(name: "Apple SD Gothic Neo", size: 12)!
        let textFontAttributes = [NSAttributedString.Key.font: textFont,NSAttributedString.Key.foregroundColor: textColor]
        
        let attributes = [NSAttributedString.Key.font: textFont]
        let textSize=text.size(withAttributes: attributes)
        //let textSize=text.size( (withAttributes: textFontAttributes)
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let x=image.size.width-15-textSize.width
        let y=image.size.height-15-textSize.height
        
        let rect = CGRect(origin: CGPoint.init(x: x, y: y), size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)
        //text.draw(in: rect, withAttributes: [NSAttributedStringKey.font:textFont,NSAttributedStringKey.foregroundColor:textColor])
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static fileprivate let vtPic="https://images.vesseltracker.com/images/vessels/"
    static fileprivate let ssPic="http://www.shipspotting.com/photos/"
    static fileprivate let msPic="http://static.myship.com/photos/"
    static fileprivate let mtPic="https://photos.marinetraffic.com/ais/showphoto.aspx?photoid="
    static fileprivate let csPic="http://www.containership-info.com/photo_"
    
    static func getPicSourceLowResUrl(src:Int, photoId:String)->String{
        switch (src){
        case 1: return vtPic+"midres/"+photoId
        case 2: return ssPic+"small/"+photoId
        case 3: return msPic+photoId
        case 4: return mtPic+photoId
        case 5: return csPic+photoId
        default: return ""
        }
    }
    
    static func getPicSourceHiReUrl(src:Int, photoId:String)->String{
        switch (src){
        case 1: return vtPic+"hires/"+photoId
        case 2: return ssPic+"middle/"+photoId
        case 3: return msPic+photoId
        case 4: return mtPic+photoId.replacingOccurrences(of: "&size=thumb", with: "")
        case 5: return csPic+photoId
        default: return ""
        }
    }
}

