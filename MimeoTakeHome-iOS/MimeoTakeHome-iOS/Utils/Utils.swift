//
//  Utils.swift
//  MimeoTakeHome-iOS
//
//  Created by Axel Mosiejko on 11/03/2020.
//  Copyright © 2020 Mimeo. All rights reserved.
//

import Foundation
import UIKit

public final class Utils {
    
    // Converts the rotation position (int) to angle (CGFloat)
    static func getAngleValueFor(position: Int) -> CGFloat {
        if position == 1 {
            return CGFloat(Double.pi / 2)
        } else if position == 2 {
            return CGFloat(Double.pi)
        } else if position == 3 {
            return CGFloat((Double.pi * 3) / 2)
        } else {
            return 0.0
        }
    }
    
    static func getDegreeValueFor(position: Int) -> Int {
        if position == 1 {
            return 90
        } else if position == 2 {
            return 180
        } else if position == 3 {
            return 270
        } else {
            return 0
        }
    }
    
    // Save edited image to user defaults
    static func saveEditedImage(edImg: EditImage) {
        let defaults = UserDefaults.standard
        var arrImages = defaults.decode(for: [EditImage].self, using: "EditedImages") ?? [EditImage]()
        var i = 0
        var exists = false
        for item in arrImages {
            if item.filename == edImg.filename {
                arrImages[i] = edImg
                exists = true
                break
            }
            i += 1
        }
        if !exists {
            // If the image was never edited, save it.
            arrImages.append(edImg)
        }
        
        defaults.encode(for:arrImages, using: "EditedImages")
        
    }
    
    static func getEditedImages() -> [EditImage] {

        if let arrImages = UserDefaults.standard.decode(for: [EditImage].self, using: "EditedImages") {
            return arrImages
        } else {
            return [EditImage]()
        }
    }
    
}
