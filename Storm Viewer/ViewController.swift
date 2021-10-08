//
//  ViewController.swift
//  Storm Viewer
//  DAY 18, 100 DAYS WITH SWIFT
//  Created by Igor Polousov on 11.06.2021.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [Picture]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true // Make large letters in title
        
        let fm = FileManager.default // Data type let us work with file system, where we're looking for files
        let path = Bundle.main.resourcePath! // Bundle is a derictory that contains compiled files and all assets of our programm
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){ // This is a picture to load
                let picture = Picture(name: item, viewCount: 0)
                pictures.append(picture)
//                pictures.append(item)
//                pictures.sort()
            }
        }
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.row]
        cell.textLabel?.text = picture.name
        cell.detailTextLabel?.text = "Times viewed = \(picture.viewCount) "
        return cell
    }
    // Below used "type casting" for vc that allows to use properties from DetailViewController(Type casting allows to use properties of other classes)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as?  DetailViewController {
            // Добавил константу чтобы можно было получить имя из структуры в массиве
            let picForShow = pictures[indexPath.row]
            // Добавил переменную которая будет считать сколько раз нажали на картинку
            var counters = picForShow.viewCount
            vc.selectedImage = picForShow.name
            // Счетчик нажатий
            counters += 1
            // Изменение переменной viewCount в структуре согласно indexPath
            pictures[indexPath.row].viewCount = counters
            // Перезагрузка данных в таблице чтобы данные сразу отобразились при возворате с картинки на таблицу
            tableView.reloadData()
            
            
            navigationController?.pushViewController(vc, animated: true)
            vc.totalPictures = pictures.count
            vc.selectedPictureNumber = indexPath.row + 1
        }
    }
    
}

