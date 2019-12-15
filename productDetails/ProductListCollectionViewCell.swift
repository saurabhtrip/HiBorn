//
//  ProductListCollectionViewCell.swift
//  HiBorn
//
//  Created by localadmin on 11/6/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
import SDWebImage
class ProductListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var imageCircle: UIImageView!
    

    override var bounds: CGRect {
           didSet {
               self.layoutIfNeeded()
           }
       }
       
       override func awakeFromNib() {
           super.awakeFromNib()

           self.imageCircle.layer.masksToBounds = true
       }

       override func layoutSubviews() {
           super.layoutSubviews()
           
           self.setCircularImageView()
       }

       func setCircularImageView() {
        
               imageCircle.layer.cornerRadius = imageCircle.frame.height/2
         
       }
    
     func configure(productDict: [String: Any]) {
    
        if let name = productDict["name"] as? String {
                                                  
                                                  productNameLabel.text = name
     }
        
        
        if let imageUrlStr = productDict["thumbnail"] as? String {
                                          
                                                      self.imageCircle.sd_setShowActivityIndicatorView(true)
                                                      self.imageCircle.sd_setIndicatorStyle(.gray)
                                          
                                                      imageCircle.sd_setImage(with: URL(string: APIRouter.baseURLStringForResource + "/storage/" + imageUrlStr), placeholderImage: UIImage.defaultImage(), options: .cacheMemoryOnly)
                                                      }
        
        
    }
}
extension UIImage {
    
    class func defaultImage() -> UIImage {
        
        return UIImage(named: "logo")!
    }
}
