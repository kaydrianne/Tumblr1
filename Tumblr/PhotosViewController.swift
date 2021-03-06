//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by TiAuna Dodd on 2/4/18.
//  Copyright © 2018 TiAuna Dod. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var posts: [[String: Any]] = [] //array to store posts
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @objc override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPosts()
        
       //REFRESH CONTROL
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (PhotosViewController.didPullToRefresh(_:)), for:.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        
        //configure the datasource and delegate of the table view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 250
    
        
        
    }
    //function to tell if refresh is being pulled or not
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        fetchPosts()
    }
    
    
    //number of cells in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    //info in each cell in table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let post = posts[indexPath.row]
        let photoURL = post["photos"] as? [[String:Any]]
        let singlePhoto = photoURL![0]
        let original = singlePhoto["original_size"] as! [String:Any]
        let urlString = original["url"] as! String
        print(urlString)
        let url = URL(string: urlString)
        cell.photoImageView.af_setImage(withURL: url!)
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photoDetailsViewController = segue.destination as! PhotoDetailsViewController
   //     PhotoDetailsViewController.image = self.imageView.image
        
        
   //     let vc = segue.destination as! PhotoDetailsViewController
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        print(indexPath.row)
        
        let post = posts[indexPath.row]
        let photoURL = post["photos"] as? [[String:Any]]
        let singlePhoto = photoURL![0]
        let original = singlePhoto["original_size"] as! [String:Any]
        
        let urlString = original["url"] as! String
        photoDetailsViewController.urlString = urlString
        
      //  print(urlString)
        let url = URL(string: urlString)
       // cell.photoImageView.af_setImage(withURL: url!)
        //tableView:didSelectRowAtIndexPath
       // tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    func fetchPosts(){
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                //print(dataDictionary)
                
                
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                // Reload the table view
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
        
    }

}

