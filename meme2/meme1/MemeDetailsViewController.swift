//
//  MemeDetailsViewController.swift
//  meme1
//
//  Created by sh da on 26/12/2018.
//  Copyright © 2018 sh da. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {

    var image : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = image {
            detailsImageView.image = image
            
        }
        // Do any additional setup after loading the view.
    }
    
    var meMe:Meme!
    
    @IBOutlet weak var detailsImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.detailsImageView = meMe?.memedImage
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
