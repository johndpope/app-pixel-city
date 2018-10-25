import CocoaLumberjack

extension UIColor {
// PLEASE USE SIP to determine color from Zepin - https://sipapp.io/
    
    // Grays RGB
    static let onyx = UIColor.rgb(r: 12, g: 12, b: 12)
    static let blackButtonColor = UIColor.rgb(r: 13, g: 13, b: 13)
    static let blackishBackgroundColor = UIColor.rgb(r: 18, g: 18, b: 18)
    static let jungleGreen = UIColor.rgb(r: 26, g: 26, b: 26)
    static let featuredBarGrey = UIColor.rgb(r: 27, g: 27, b: 27)
    static let rangoonGreen = UIColor.rgb(r: 28, g: 28, b: 28)
    static let darkLine = UIColor.rgb(r: 31, g: 31, b: 31)
    static let tvProviderGray = UIColor.rgb(r: 33, g: 33, b: 33)
    static let mineShaft = UIColor.rgb(r: 48, g: 48, b: 48)
    static let greyButtonColor = UIColor.rgb(r: 52, g: 52, b: 52)
    static let cokeGray = UIColor.rgb(r: 57, g: 56, b: 56)
    static let tuaTaraGray = UIColor.rgb(r: 66, g: 66, b: 66)
    static let thunder = UIColor.rgb(r: 76, g: 76, b: 76)
    static let chicagoGrey = UIColor.rgb(r: 94, g: 94, b: 94)
    static let featuredIconGrey = UIColor.rgb(r: 99, g: 99, b: 99)
    static let mountainMistGray = UIColor.rgb(r: 148, g: 145, b: 150)
    static let grayChateau = UIColor.rgb(r: 163, g: 163, b: 163)
    static let silverChalice = UIColor.rgb(r: 170, g: 170, b: 170)
    static let altoGray = UIColor.rgb(r: 216, g: 216, b: 216)
    static let darkWhiteText = UIColor.rgb(r: 237, g: 237, b: 237)
    
    // Grays RGBA
    static let brightGray = UIColor.rgba(r: 255.0, g: 255.0, b: 255.0, a: 0.3)
    static let neroGray = UIColor.rgba(r: 0, g: 0, b: 0, a: 0.75)
    static let charcoalGray = UIColor.rgba(r: 0, g: 0, b: 0, a: 0.75)
    
    
    // Reds
    static let pinkishRed = UIColor.rgb(r: 235, g: 24, b: 38)
    static let mexicanRed = UIColor.rgb(r: 163, g: 20, b: 33)
    static let fireEngineRed = UIColor.rgb(r: 215, g: 24, b: 42) 
    static let fireEngineRedDisabled = UIColor.rgba(r: 215, g: 24, b: 42, a: 0.3)
    static let governorBay =  UIColor(red:0.29, green:0.31, blue:0.57, alpha:1.00)
    
    // Others
    static let featuredSelectedIconColor = UIColor.rgb(r: 145, g: 115, b: 94)
    static let purpleGrey = UIColor.rgb(r: 148, g: 145, b: 150)
    
    // MARK: - Constructors
    class func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
        return color
    }

    class func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        let color = UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
        return color
    }

    class func colorRandom() -> UIColor {
        return UIColor.rgb(r: CGFloat(arc4random() % 255), g: CGFloat(arc4random() % 255), b: CGFloat(arc4random() % 255))
    }

    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
}
