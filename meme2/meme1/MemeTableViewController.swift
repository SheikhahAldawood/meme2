//
//  MemeTableViewController.swift
//  meme1
//
//  Created by sh da on 24/12/2018.
//  Copyright © 2018 sh da. All rights reserved.
//

import UIKit

class MemeTableViewController:  UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
        
    }
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let meme1 = self.memes[(indexPath as NSIndexPath).row]
        
        
        cell.tLabelT.text = meme1.topText
        cell.bLabelT.text = meme1.bottomText
        cell.imageViewT?.image = meme1.memedImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
