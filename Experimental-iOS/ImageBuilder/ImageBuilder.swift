//
//  ImageBuilder.swift
//  Experimental-iOS
//
//  Created by William Inx on 30/01/22.
//

import Foundation
import UIKit

@objc
public final class ImageBuilder: NSObject {
    
    
    private static var resultedImage: UIImage = .init()
    
    
    public static func buildImage() -> UIImage {
        return resultedImage
    }
}
