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
    var arrImages = [String]()
    let cellWidth = (UIScreen.main.bounds.width / 3) - 4
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! + "/Images"
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nicole-king") {
                    arrImages.append("\(path)/\(item)")
                    print(item)
                }
            }
        } catch {
            print ("Error reading directory!!")
        }
        
        collectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showEditView"{
            let detailVC = segue.destination as! EditViewController
            let indexPath = sender as! IndexPath
            detailVC.imagePath = arrImages[indexPath.row]
        }
    }
}

// MARK: UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            
            let image = UIImage(named: arrImages[indexPath.row])
            let resizedImage = image?.resizeImage(newSize: CGSize(width: cellWidth, height: cellWidth))
            cell.imageView.image = resizedImage
            
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
