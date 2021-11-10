//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by Igor Polousov on 14.06.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView! // Varialble for imageView in IB
    var selectedImage: String? // Variable optional type if value exists take picture from row from pictures array
    
    var selectedPictureNumber = 0
    var totalPictures = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(selectedPictureNumber) of \(totalPictures)"
        //title = selectedImage // Make title the same as
        navigationItem.largeTitleDisplayMode = .never // Make restriction on big letters in title
    
        assert(selectedImage != nil, "failure")
        
        // So that selectedImage is optional make unwrap
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad) // If selected image !nil image on imageView = imageToLoad with value selectedImage
        }
    }
    // Making navigation controller dissapear on tap
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    // making navigation controller appear on tap
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
  

}
