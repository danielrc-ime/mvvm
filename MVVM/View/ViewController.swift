//
//  ViewController.swift
//  MVVM
//
//  Created by Yonusa iOS on 03/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = RequestManager()
    var columnsItems: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configureView()
        bind()
    }

    func configureView(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.getSimpsonData()
    }

    func bind() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.dataArray.count
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.labelName.text = viewModel.dataArray[indexPath.row].character
        cell.imageView.imageFromServerURL(urlString: self.viewModel.dataArray[indexPath.row].image, PlaceHolderImage: UIImage(systemName: "icloud.slash.fill")!, size: cell.frame.size)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               let padding: CGFloat =  50
               let collectionViewSize = collectionView.frame.size.width - padding
        let print = CGSize(width: collectionViewSize/columnsItems, height: collectionViewSize/columnsItems)
        debugPrint(print)
               return CGSize(width: collectionViewSize/columnsItems, height: collectionViewSize/columnsItems)
           }
    
}

//MARK: - UIImageView Load fromURL
extension UIImageView {

    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage, size: CGSize) {

       if self.image == nil{
             self.image = PlaceHolderImage
       }

       URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

           if error != nil {
               print(error ?? "No Error")
               return
           }
           DispatchQueue.main.async(execute: { () -> Void in
               let image = UIImage(data: data!)
               self.image = self.resizeImage(image: image!, targetSize: size)
           })

       }).resume()
   }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
