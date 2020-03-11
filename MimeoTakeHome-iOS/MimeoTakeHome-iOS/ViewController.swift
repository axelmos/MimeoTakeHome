//
//  ViewController.swift
//  MimeoTakeHome-iOS
//
//  Created by pgoracke on 3/6/20.
//  Copyright © 2020 Mimeo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var arrImages = [EditImage]()
    let cellWidth = (UIScreen.main.bounds.width / 3) - 4
    var firstLaunch = true
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! + "/Images"
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nicole-king") {
                    let img = EditImage(fullPath: "\(path)/\(item)", filename: item, position: 0, uuid: "0")
                    arrImages.append(img)
                    print(item)
                }
            }
        } catch {
            print ("Error reading directory!!")
        }
        
        collectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")

	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let editedImages = Utils.getEditedImages()
        var i:Int!
        var needUpdate = false
        
        for editImg in editedImages {
            i = 0
            for img in arrImages {
                if img.filename == editImg.filename {
                    arrImages[i].position = editImg.position // Replace image for the edited image that was stored in userdefaults.
                    needUpdate = true
                }
                i += 1
            }
            
        }
        
        if firstLaunch {
            firstLaunch = false
            return
        }
        
        if needUpdate {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showEditView"{
            let editVC = segue.destination as! EditViewController
            let indexPath = sender as! IndexPath
            editVC.editImage = arrImages[indexPath.row]
            editVC.modalPresentationStyle = .fullScreen
        }
    }
}

// MARK: UICollectionView Delegate

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            
            let image = UIImage(named: arrImages[indexPath.row].fullPath)
            let resizedImage = image?.resizeImage(newSize: CGSize(width: cellWidth, height: cellWidth))
            cell.imageView.image = resizedImage
            cell.imageView.transform = .identity
            // Rotate image if it was edited
            cell.imageView.transform = cell.imageView.transform.rotated(by: Utils.getAngleValueFor(position: arrImages[indexPath.row].position ?? 0))
            print (Utils.getAngleValueFor(position: arrImages[indexPath.row].position ?? 0))
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showEditView", sender: indexPath)
        }
    }
}

// MARK: UICollectionView Flow Layout

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
}
