//
//  ViewController.swift
//  Storm Viewer
//  DAY 18, 100 DAYS WITH SWIFT
//  Created by Igor Polousov on 11.06.2021.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true // Make large letters in title
        
        performSelector(inBackground: #selector(loadNSSLFiles), with: nil)
        
    }
    
    @objc func loadNSSLFiles() {
        let fm = FileManager.default // Data type let us work with file system, where we're looking for files
        let path = Bundle.main.resourcePath! // Bundle is a derictory that contains compiled files and all assets of our programm
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){ // This is a picture to load
                pictures.append(item)
                pictures.sort()
            }
        }
        tableView.performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: false)
        print(pictures)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    // Below used "type casting" for vc that allows to use properties from DetailViewController(Type casting allows to use properties of other classes)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as?  DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            vc.totalPictures = pictures.count
            vc.selectedPictureNumber = indexPath.row + 1
        }
    }
    
}

