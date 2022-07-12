//
//  CollectionViewController.swift
//  FlipkartHackathon
//
//  Created by Kushagra Sharma on 09/07/22.
//

import UIKit

class CollectionViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet weak var collectionView: UICollectionView!
    
    let names = ["BigDial","Blue","BrownGold","Yellow"]
    let images :[UIImage] = [
        UIImage(named: "BigDial")!,
        UIImage(named: "Blue")!,
        UIImage(named: "BrownGold")!,
        UIImage(named: "Yellow")!,
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
//        // Do any additional setup after loading the view.
//        let layout  = self.collectionView as! UICollectionViewFlowLayout
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ARViewController
        
        if let indexPath = collectionView.indexPathsForSelectedItems{
            destinationVC.imageName = names[indexPath[0].row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ARSegue", sender: self)
      }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.collectionLabel.text = names[indexPath.item]
        cell.collectionImageView.image = images[indexPath.item]
        return cell
    }

}
