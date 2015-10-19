import UIKit


public class ImageProcessor {
    let imageName: String
    public var image: UIImage? 
    
    public init?(imageName: String) {
        self.imageName = imageName
        self.image = UIImage(named: imageName)
        if (self.image == nil){
            return nil
        }
    }
    
    public func changeToBlackAndWhite(withIndicatorToChangeToBlackAndWhite filterIndicator: Double = 128) -> UIImage{
        let rgbaImage = RGBAImage(image: self.image!)
        let width = rgbaImage!.width
        for x in 0..<rgbaImage!.height {
            for y in 0..<rgbaImage!.width {
                var pixel = rgbaImage!.pixels[y * width + x]
                let indicator = self.getYForBlackAndWhite(forPixel: pixel)
                if indicator < filterIndicator { // black
                    pixel.red = 0
                    pixel.green = 0
                    pixel.blue = 0
                }else {
                    pixel.red = 255
                    pixel.green = 255
                    pixel.blue = 255
                }
                rgbaImage!.pixels[ y * width + x] = pixel
            }
        }
        self.image = rgbaImage!.toUIImage()!
        return rgbaImage!.toUIImage()!
    }
    
    public func changeToBlackAndWhiteThenReverseColors(withIndicatorToChangeToBlackAndWhite filterIndicator: Double = 128) -> UIImage {
        reverseBlackAndWhite()
        return changeToBlackAndWhite(withIndicatorToChangeToBlackAndWhite: filterIndicator)
    }
    
    private func reverseBlackAndWhite() -> UIImage{
        let rgbaImage = RGBAImage(image: self.image!)
        let width = rgbaImage!.width
        for x in 0..<rgbaImage!.height {
            for y in 0..<rgbaImage!.width {
                var pixel = rgbaImage!.pixels[y * width + x]
                if self.isBlackPixel(pixel) {
                    pixel.red = 255
                    pixel.green = 255
                    pixel.blue = 255
                }else {
                    pixel.red = 0
                    pixel.green = 0
                    pixel.blue = 0
                }
                rgbaImage!.pixels[y * width + x] = pixel
            }
        }
        self.image = rgbaImage!.toUIImage()!
        return rgbaImage!.toUIImage()!
    }
    public static func joinTwoImages(leftImage: UIImage, rightImage: UIImage) -> UIImage? {
        let rgbaImageLeft = RGBAImage(image: leftImage)
        let rgbaImageRight = RGBAImage(image: rightImage)
        let leftWidth = rgbaImageLeft!.width
        let leftHeight = rgbaImageLeft!.height
        let rightWidth = rgbaImageRight!.width
        let rightHeight = rgbaImageRight!.height
        
        if leftWidth == rightWidth && leftHeight == rightHeight {
            var pixelsForNewImage = [Pixel?](count: leftWidth * rightWidth, repeatedValue: nil)
            let halfWidth = Int(leftWidth / 2)
            for x in 0..<leftHeight {
                for y in 0..<leftWidth {
                    if x <= halfWidth {
                        let pixel = rgbaImageLeft!.pixels[y * leftWidth + x]
                        pixelsForNewImage[y * leftWidth + x] = pixel
                    }else {
                        let pixel = rgbaImageRight!.pixels[y * rightWidth + x]
                        pixelsForNewImage[y * rightWidth + x] = pixel
                    }
                }
            }
            let temporaryRGBAImage = RGBAImage(image: leftImage)
            for x in 0..<temporaryRGBAImage!.height {
                for y in 0..<temporaryRGBAImage!.width {
                    temporaryRGBAImage!.pixels [ y * temporaryRGBAImage!.width + x] = pixelsForNewImage [ y * temporaryRGBAImage!.width + x]!
                }
            }
            return temporaryRGBAImage!.toUIImage()
        }
        print("Both images don't have the same width/height")
        return nil
    }
    public static func joinTwoImages(leftImageName imageNameLeft: String, withRightImageName imageNameRight: String) -> UIImage? {
        if let leftImage = UIImage(named: imageNameLeft) {
            if let rightImage = UIImage(named: imageNameRight){
                let rgbaImageLeft = RGBAImage(image: leftImage)
                let rgbaImageRight = RGBAImage(image: rightImage)
                let leftWidth = rgbaImageLeft!.width
                let leftHeight = rgbaImageLeft!.height
                let rightWidth = rgbaImageRight!.width
                let rightHeight = rgbaImageRight!.height
                
                if leftWidth == rightWidth && leftHeight == rightHeight {
                    var pixelsForNewImage = [Pixel?](count: leftWidth * rightWidth, repeatedValue: nil)
                    let halfWidth = Int(leftWidth / 2)
                    for x in 0..<leftHeight {
                        for y in 0..<leftWidth {
                            if x <= halfWidth {
                                let pixel = rgbaImageLeft!.pixels[y * leftWidth + x]
                                pixelsForNewImage[y * leftWidth + x] = pixel
                            }else {
                                let pixel = rgbaImageRight!.pixels[y * rightWidth + x]
                                pixelsForNewImage[y * rightWidth + x] = pixel
                            }
                        }
                    }
                    let temporaryUIImage = UIImage(named: imageNameRight)
                    let temporaryRGBAImage = RGBAImage(image: temporaryUIImage!)
                    for x in 0..<temporaryRGBAImage!.height {
                        for y in 0..<temporaryRGBAImage!.width {
                            temporaryRGBAImage!.pixels [ y * temporaryRGBAImage!.width + x] = pixelsForNewImage [ y * temporaryRGBAImage!.width + x]!
                        }
                    }
                    return temporaryRGBAImage!.toUIImage()
                }
                print("Both images don't have the same width/height")
                return nil
            }
            print("Right image doesn't exist")
            return nil
        }
        print("Left image doesn't exist")
        return nil
    }
    
    public func upsideDown () -> UIImage {
        let rgbaImage = RGBAImage(image: self.image!)
        let temporaryRgbaImage = RGBAImage(image: self.image!)
        let width = rgbaImage!.width
        let heigh = rgbaImage!.height
        for x in 0..<heigh {
            for y in 0..<width {
                let pixel = rgbaImage!.pixels[y * width + x]
                let newHeigh = max(heigh-y-1, y-heigh-1)
                temporaryRgbaImage!.pixels[ newHeigh * width + x ] = pixel
            }
        }
        self.image = temporaryRgbaImage!.toUIImage()!
        return temporaryRgbaImage!.toUIImage()!
    }
    
    public func leftToRight () -> UIImage {
        let rgbaImage = RGBAImage(image: self.image!)
        let temporaryRgbaImage = RGBAImage(image: self.image!)
        let width = rgbaImage!.width
        let heigh = rgbaImage!.height
        for x in 0..<heigh {
            for y in 0..<width {
                let pixel = rgbaImage!.pixels [ y * width + x]
                let newWidth = width - x
                temporaryRgbaImage!.pixels[y * width + newWidth] = pixel
            }
        }
        self.image = temporaryRgbaImage!.toUIImage()!
        return temporaryRgbaImage!.toUIImage()!
    }
    
    public func changeCorners() -> UIImage {
        let rgbaImage = RGBAImage(image: self.image!)
        let temporaryRgbaImage = RGBAImage(image: self.image!)
        let width = rgbaImage!.width
        let heigh = rgbaImage!.height
        for x in 0..<heigh {
            for y in 0..<width {
                let pixel = rgbaImage!.pixels[y * width + x]
                let newWidth = max(width-1-y, y - (width-1))
                let newHeigh = max(x - (heigh-1), heigh-1 - x)
                temporaryRgbaImage!.pixels[newWidth * width + newHeigh] = pixel
            }
        }
        self.image = temporaryRgbaImage!.toUIImage()!
        return temporaryRgbaImage!.toUIImage()!
    }
    
    public func applyGrayScaleAlgorithm(algorithmName: GrayScaleAlgorithm) -> UIImage{
        let rgbaImage = RGBAImage(image: self.image!)
        let width = rgbaImage!.width
        let heigh = rgbaImage!.height
        for x in 0..<heigh {
            for y in 0..<width{
                var pixel = rgbaImage!.pixels[y * width + x ]
                var newValue:UInt8 = 0
                switch(algorithmName) {
                case .Lightness:
                    newValue = calculateLightness(forPixel: pixel)
                    break
                case .Average:
                    newValue = calculateAverage(forPixel: pixel)
                    break
                case .Luminosity:
                    newValue = calcuateLuminosity(forPixel: pixel)
                    break
                }
                pixel.red = newValue
                pixel.green = newValue
                pixel.blue = newValue
                rgbaImage!.pixels[y * width + x] = pixel
            }
        }
        self.image = rgbaImage!.toUIImage()!
        return rgbaImage!.toUIImage()!
    }
    
    public func drawCircle(withNumberOfPixelsForTheLine lineWidth: Int = 1) -> UIImage?{
        let rgbaImage = RGBAImage(image: self.image!)
        let width = rgbaImage!.width
        let heigh = rgbaImage!.height
        var diameter = min(width, heigh)
        if diameter % 2 != 0 {
            diameter = diameter - 1
        }
        let centerX = diameter  / 2
        let centerY = diameter  / 2
        diameter = diameter - lineWidth
        for x in 0..<heigh {
            for y in 0..<width {
                var pixel = rgbaImage!.pixels[y * width + x]
                let distance = calcuateDistance(fromPointX: x, fromPointX: y, toPointX: centerX, toPointY: centerY)
                print(distance)
                if distance > Double (diameter/2 - lineWidth/2) && distance < Double(diameter/2 + lineWidth/2)
                {
                    pixel.red = 255
                    pixel.green = 0
                    pixel.blue = 0
                }
                rgbaImage!.pixels[y * width + x] = pixel
            }
        }
        self.image = rgbaImage!.toUIImage()!
        return rgbaImage!.toUIImage()!
    }
    
    public func maximize(byFactor factor: Int) -> UIImage{
        var rgbaImage = RGBAImage(image: self.image!)
        let width = rgbaImage!.width
        let height = rgbaImage!.height
        let newWidth = width * factor
        let newHeight = height * factor
        let imageData = UnsafeMutablePointer<Pixel>.alloc(width * height * factor)
        let pixels = UnsafeMutableBufferPointer<Pixel>(start: imageData, count: width * height * factor)
        for x in 0..<height {
            for y in 0..<width {
                let pixel = rgbaImage!.pixels[y * width + x]
                for x1 in (x * factor)..<((x + 1) * factor) {
                    for y1 in (y * factor)..<((y + 1) * factor){
                        pixels[y1 * newWidth + x1] = pixel
                    }
                }
            }
        }
        rgbaImage!.pixels = pixels
        
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var bitmapInfo: UInt32 = CGBitmapInfo.ByteOrder32Big.rawValue
        bitmapInfo |= CGImageAlphaInfo.PremultipliedLast.rawValue & CGBitmapInfo.AlphaInfoMask.rawValue
        let bytesPerRow = newWidth * 4
        let imageContext = CGBitmapContextCreateWithData(pixels.baseAddress, newWidth, newHeight, 8, bytesPerRow, colorSpace, bitmapInfo, nil, nil)
        let cgImage = CGBitmapContextCreateImage(imageContext)
        let imageFinal = UIImage(CGImage: cgImage!)
        self.image = imageFinal
        return imageFinal
    }
    
    public func mainpulateBrightness(byfactor factor:UInt8) -> UIImage{
        let rgbaImage = RGBAImage(image: self.image!)
        let width = rgbaImage!.width
        let height = rgbaImage!.height
        for x in 0..<height {
            for y in 0..<width {
                var pixel = rgbaImage!.pixels[y * width + x]
                var newRed: Int = Int(pixel.red) + Int(factor)
                newRed = min(255, newRed)
                pixel.red = UInt8(newRed)
                var newGreen: Int = Int(pixel.green) + Int(factor)
                newGreen = min(255, newGreen)
                pixel.green = UInt8(newGreen)
                var newBlue: Int = Int(pixel.blue) + Int(factor)
                newBlue = min(255, newBlue)
                pixel.blue = UInt8(newBlue)
                rgbaImage!.pixels [ y * width + x ] = pixel
            }
        }
        self.image = rgbaImage!.toUIImage()!
        return rgbaImage!.toUIImage()!
    }
    
    public func mainpulateBrightness(byfactor factor: UInt8, forColor color: PixelColor) -> UIImage {
        let rgbaImage = RGBAImage(image: self.image!)
        let width = rgbaImage!.width
        let height = rgbaImage!.height
        for x in 0..<height {
            for y in 0..<width {
                var pixel = rgbaImage!.pixels[ y * width + x ]
                switch(color){
                case PixelColor.Red:
                    var newRed: Int = Int(pixel.red) + Int(factor)
                    newRed = min(255, newRed)
                    pixel.red = UInt8(newRed)
                    break
                case PixelColor.Green:
                    var newGreen: Int = Int(pixel.green) + Int(factor)
                    newGreen = min(255, newGreen)
                    pixel.green = UInt8(newGreen)
                    break
                case PixelColor.Blue:
                    var newBlue: Int = Int(pixel.blue) + Int(factor)
                    newBlue = min(255, newBlue)
                    pixel.blue = UInt8(newBlue)
                    break
                }
                rgbaImage!.pixels [ y * width + x ] = pixel
            }
        }
        self.image = rgbaImage!.toUIImage()!
        return rgbaImage!.toUIImage()!
    }
    
    
    private func calcuateDistance(fromPointX x1: Int, fromPointX y1: Int, toPointX x2: Int, toPointY y2: Int) -> Double{
        return sqrt(pow(Double(x1-x2), Double(2)) + pow(Double(y1 - y2), Double(2)))
    }
    
    private func calcuateLuminosity(forPixel pixel: Pixel) -> UInt8 {
        let newRed: Double = 0.21 * Double(pixel.red)
        let newGreen: Double = 0.72 * Double(pixel.green)
        let newBlue: Double = 0.07 * Double(pixel.blue)
        var sum = newRed + newGreen + newBlue
        sum = min(sum, 255)
        return UInt8(sum)
    }
    
    private func calculateAverage(forPixel pixel:Pixel) -> UInt8 {
        var sum: Double = Double(pixel.red) + Double(pixel.green) + Double(pixel.blue)
        sum = min(sum/3, 255)
        return UInt8(sum)
    }
    
    private func calculateLightness (forPixel pixel: Pixel) -> UInt8 {
        let maxValue = Double(max(pixel.red, pixel.green, pixel.blue))
        let minValue = Double(min(pixel.red, pixel.green,pixel.blue))
        var sum = maxValue + minValue
        sum = min(255, sum)
        return UInt8(sum / 2)
    }
    
    private func getYForBlackAndWhite(forPixel pixel: Pixel) -> Double {
        let newRed = 0.2126 * Double(pixel.red)
        let newGreen = 0.7152 * Double(pixel.green)
        let newBlue = 0.0722 * Double(pixel.blue)
        return newRed + newGreen + newBlue
    }
    
    private func isBlackPixel(pixel: Pixel) -> Bool{
        if pixel.red == 0 && pixel.green == 0 && pixel.blue == 0 {
            return true
        }
        return false
    }
}


public enum GrayScaleAlgorithm {
    case Lightness
    case Average
    case Luminosity
}

public enum PixelColor {
    case Red
    case Green
    case Blue
}