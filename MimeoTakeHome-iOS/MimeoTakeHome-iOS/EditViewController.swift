//
//  EditViewController.swift
//  MimeoTakeHome-iOS
//
//  Created by Axel Mosiejko on 10/03/2020.
//  Copyright © 2020 Mimeo. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var imagePath: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: imagePath)
        let resizedImage = image?.resizeImage(newSize: CGSize(width: imageView.frame.size.width, height: imageView.frame.size.height))
        DispatchQueue.main.async {
            self.imageView.image = resizedImage
        }
    }
    
    @IBAction func onCounterClockwise(sender: UIButton) {
        
    }
    
    @IBAction func onClockwise(sender: UIButton) {
        
    }
    
    @IBAction func onOriginal(sender: UIButton) {
        let alert = UIAlertController(title: "Original", message: "Are you sure you want to go back this image to its original state?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.setOriginalState()
        })
        alert.addAction(okAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onShare(sender: UIButton) {
        
    }
    
    func setOriginalState() {
        
    }
    
}
