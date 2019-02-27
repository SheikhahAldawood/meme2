//
//  MemeCollectionViewController.swift
//  meme1
//
//  Created by sh da on 24/12/2018.
//  Copyright © 2018 sh da. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController  {
    
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!

    var memes : [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2*space))/3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView!.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let meme1 = self.memes[(indexPath as NSIndexPath).row]
        
        cell.tLabel.text = meme1.topText
        cell.bLabel.text = meme1.bottomText
        cell.imageView?.image = meme1.memedImage
        
        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailsViewController") as! MemeDetailsViewController
        detailController.image = memes[indexPath.row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
