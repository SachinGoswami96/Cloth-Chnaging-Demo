//
//  SelectionViewController.swift
//  SceneKit Lighting and UV
//
//  Created by Mohak Parmar on 04/11/22.
//  Copyright © 2022 Black Pixel. All rights reserved.
//

import UIKit

protocol SelectionDeleagte  {
    func sendImageDataWithIndex(index:Int, image:String)
}

class SelectionViewController: UIViewController {

    @IBOutlet weak var collectionShirts: UICollectionView!
    var arrShirt : [String] = ["TTBJacket01", "TTBJacket02", "TTBJacket03",
                               "TTBJacket04", "TTBJacket05", "TTBJacket06",
                               "TTBJacket07", "TTBJacket08", "TTBJacket09",
                               "TTBJacket10", "TTBJacket11", "TTBJacket12"]
    var arrPants : [String] = ["TTLegs01", "TTLegs02", "TTLegs03",
                               "TTLegs04", "TTLegs05", "TTLegs06",
                               "TTLegs07", "TTLegs08", "TTLegs09",
                               "TTLegs10", "TTLegs11", "TTLegs12",
                               "TTLegs13", "TTLegs14", "TTLegs15",
                               "TTLegs16", "TTLegs17", "TTLegs18",
                               "TTLegs19", "TTLegs20", "TTLegs21" , "TTLegs22"]
    var arrSweater : [String] = ["TTSweater01", "TTSweater02", "TTSweater03",
                               "TTSweater04", "TTSweater05", "TTSweater06",
                               "TTSweater07", "TTSweater08", "TTSweater09",
                               "TTSweater10", "TTSweater11", "TTSweater12"]
    var selectedType : Int = 0

    var delegate: SelectionDeleagte?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionShirts.register(UINib(nibName: "ImageCCell", bundle: nil), forCellWithReuseIdentifier: "ImageCCell")

        // Do any additional setup after loading the view.
    }
    


}

extension SelectionViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionShirts.dequeueReusableCell(withReuseIdentifier: "ImageCCell", for: indexPath  ) as! ImageCCell

        if selectedType == 1 {
            cell.imgView.image = UIImage(named: arrShirt[indexPath.row])
        } else if selectedType == 2 {
            cell.imgView.image = UIImage(named: arrPants[indexPath.row])
        } else if selectedType == 3 {
            cell.imgView.image = UIImage(named: arrSweater[indexPath.row])
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedType == 1 {
            return arrShirt.count
        } else if selectedType == 2 {
            return arrPants.count
        } else if selectedType == 3 {
            return arrSweater.count
        }
        return arrShirt.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedType == 1 {
            self.delegate?.sendImageDataWithIndex(index: selectedType, image: arrShirt[indexPath.row])
        } else if selectedType == 2 {
            self.delegate?.sendImageDataWithIndex(index: selectedType, image: arrPants[indexPath.row])
        } else if selectedType == 3 {
            self.delegate?.sendImageDataWithIndex(index: selectedType, image: arrSweater[indexPath.row])
        }

        self.dismiss(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (self.view.frame.size.width - 45) / 3
        return CGSize(width: width, height: width)
    }

}
