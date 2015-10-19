import UIKit

public class TestImageProcessor {
    public static func testBlackAndWhiteFunctions(imageName: String) {
        let imageProcessor = ImageProcessor(imageName: imageName)
        
        imageProcessor!.changeToBlackAndWhite()
        imageProcessor!.changeToBlackAndWhiteThenReverseColors()
        
        imageProcessor!.changeToBlackAndWhite(withIndicatorToChangeToBlackAndWhite: 100)
        imageProcessor!.changeToBlackAndWhiteThenReverseColors(withIndicatorToChangeToBlackAndWhite: 100)
        
        imageProcessor!.changeToBlackAndWhite(withIndicatorToChangeToBlackAndWhite: 150)
        imageProcessor!.changeToBlackAndWhiteThenReverseColors(withIndicatorToChangeToBlackAndWhite: 150)
        
        imageProcessor!.changeToBlackAndWhite(withIndicatorToChangeToBlackAndWhite: 50)
        imageProcessor!.changeToBlackAndWhiteThenReverseColors(withIndicatorToChangeToBlackAndWhite: 50)
    }
    public static func testUpsideDown (imageName: String){
        let imageProcessor = ImageProcessor(imageName: imageName)
        imageProcessor!.upsideDown()
    }
    public static func testLeftToRight (imageName: String) {
        let imageProcessor = ImageProcessor(imageName: imageName)
        imageProcessor!.leftToRight()
    }
    public static func testChangeCorners(imageName: String){
        let imageProcessor = ImageProcessor(imageName: imageName)
        imageProcessor!.changeCorners()
    }
    public static func testGrayScrale(imageName: String) {
        let imageProcessor = ImageProcessor(imageName: imageName)
        imageProcessor!.applyGrayScaleAlgorithm(.Average)
        imageProcessor!.applyGrayScaleAlgorithm(.Lightness)
        imageProcessor!.applyGrayScaleAlgorithm(.Luminosity)
    }
    public static func testJoinImages(){
        let imageProcessor = ImageProcessor(imageName: "sample")
        ImageProcessor.joinTwoImages(UIImage(named: "sample")!, rightImage: imageProcessor!.applyGrayScaleAlgorithm(.Luminosity))
    }
    public static func testDrawCircle(imageName: String){
        let imageProcessor = ImageProcessor(imageName: imageName)
        imageProcessor!.drawCircle(withNumberOfPixelsForTheLine: 10)
        imageProcessor!.drawCircle(withNumberOfPixelsForTheLine: 5)
    }
    public static func testMaximuze(imageName: String){
        let imageProcessor = ImageProcessor(imageName: imageName)
        imageProcessor!.maximize(byFactor: 2)
        imageProcessor!.maximize(byFactor: 4)
    }
    public static func testBrightness(imageName: String, factor: UInt8){
        let imageProcessor = ImageProcessor(imageName: imageName)
        imageProcessor!.mainpulateBrightness(byfactor: factor)
    }
    public static func testBrightnessForColors(imageName: String, factor: UInt8){
        let imageProcessor = ImageProcessor(imageName: imageName)
        imageProcessor!.mainpulateBrightness(byfactor: 150, forColor: PixelColor.Red)
        imageProcessor!.mainpulateBrightness(byfactor: 150, forColor: PixelColor.Green)
        imageProcessor!.mainpulateBrightness(byfactor: 150, forColor: PixelColor.Blue)
    }
}