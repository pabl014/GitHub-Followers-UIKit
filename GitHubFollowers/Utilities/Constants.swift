//
//  Constants.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 06/03/2024.
//

import UIKit

enum SFSymbols {
    static let location     = "mappin.and.ellipse"
    static let repos        = "folder"
    static let gists        = "text.allignleft"
    static let followers    = "person.2"
    static let following    = "heart"
}

// https://www.appmysite.com/blog/the-complete-guide-to-iphone-screen-resolutions-and-sizes/

// getting the screen size
// when calling ScreenSize.width and .height, I'm getting height and width of the actual screen
enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

enum Images {
    static let ghLogo = UIImage(named: "gh-logo")
}

enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
    
    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXMaxAndXr        = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXMaxAndXr
        // old iPhone SE, iPhone 6, 7, 8 have aspect ratio of 16x9
        // iPhoneX aspect ratio is very close to 2x1, so it's different
    }
    
}

