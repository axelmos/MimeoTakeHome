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
    var position = 0
    var oldPosition:Int!
    var editImage: EditImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Image
        let image = UIImage(named: editImage.fullPath)
        let resizedImage = image?.resizeImage(newSize: CGSize(width: imageView.frame.size.width, height: imageView.frame.size.height))
        DispatchQueue.main.async {
            self.imageView.image = resizedImage
        }
        
        // Rotate Image
        position = editImage.position ?? 0
        oldPosition = position
        self.imageView.transform = self.imageView.transform.rotated(by: Utils.getAngleValueFor(position: position))
        
        // Save image dimensions for sharing
        editImage.width = "\(image?.size.width ?? 0)"
        editImage.height = "\(image?.size.height ?? 0)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (oldPosition != position) {
            Utils.saveEditedImage(edImg: editImage) // Save changes in UserDefaults
        }
        
    }
    
    func setOriginalState() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.imageView.transform = .identity
            }
        }
        position = 0
        editImage.position = 0
        // Reset all stored rotated images
        UserDefaults.standard.encode(for:[EditImage](), using: "EditedImages")
    }
    
    // MARK: - IBActions
    
    @IBAction func onBack(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCounterClockwise(sender: UIButton) {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.imageView.transform = self.imageView.transform.rotated(by: CGFloat(-Double.pi / 2))
            }
        }
        
        position -= 1
        if position == -1 {
            position = 3
        }
        editImage.position = position
    }
    
    @IBAction func onClockwise(sender: UIButton) {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.imageView.transform = self.imageView.transform.rotated(by: CGFloat(Double.pi / 2))
            }
        }
        
        position += 1
        if position > 3 {
            position = 0
        }
        editImage.position = position
    }
    
    @IBAction func onOriginal(sender: UIButton) {
        let alert = UIAlertController(title: "Original", message: "Are you sure you want to reset all changes?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.setOriginalState()
        })
        alert.addAction(okAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func onShare(sender: UIButton) {
        
        APIClient.shared.getUUID { (model) in
            
            print(model?.uuid ?? "n/a")
            self.editImage.uuid = model?.uuid ?? ""
            
            APIClient.shared.postRequest(image: self.editImage) { (response) in
                print (response ?? "No response!")
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Server response:", message: "\(String(describing: response))", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                
            }
        }
    }
}
