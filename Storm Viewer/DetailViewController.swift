//
//  DetailViewController.swift
//  Storm Viewer
//  Day 22
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
    
        // So that selectedImage is optional make unwrap
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad) // If selected image !nil image on imageView = imageToLoad with value selectedImage
        }
        // Add top right button in navigation panel with system photo .action
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped)) // # is shoing on objc method
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
    
    @objc func shareTapped() {
        guard let image = imageView.image else {
            print("No image found")
            return
        }

        let watermarkedImage = watermark(image: image)
        
        var shareable: [Any] = [watermarkedImage]
        if let imageText = selectedImage {
            shareable.append(imageText)
        }
        
        let vc = UIActivityViewController(activityItems: shareable, applicationActivities: [])
        // mandatory on ipad to show where the sharing comes from
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    func watermark(image: UIImage) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: image.size)
        
        let renderedImage = renderer.image { ctx in
            image.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            let string = "From Storm Viewer"

            let attrs: [NSAttributedString.Key : Any] = [
                .strokeWidth: -1.0,
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "HelveticaNeue", size: 36)!,
                .paragraphStyle: paragraphStyle
            ]
            
            let margin = 32
            let textWidth = Int(image.size.width) - (margin * 2)
            let textHeight = Int(image.size.height) - (margin * 2)
            string.draw(with: CGRect(x: margin, y: margin, width: textWidth, height: textHeight), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }

        return renderedImage
    }
}
