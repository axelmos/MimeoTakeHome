//
//  UIImage.swift
//  MimeoTakeHome-iOS
//
//  Created by Axel Mosiejko on 10/03/2020.
//  Copyright © 2020 Mimeo. All rights reserved.
//

import UIKit

extension UIImage {
    func resizeImage(newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
