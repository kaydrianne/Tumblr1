//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by TiAuna Dodd on 2/13/18.
//  Copyright © 2018 TiAuna Dod. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var image: UIImage!
    var urlString: String!
    @IBOutlet weak var photoImageView: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("URL PASSED: \(urlString)")
        let url = URL(string: urlString)
         photoImageView.image = image
         photoImageView.af_setImage(withURL: url!)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
