//
//  productDetailsCollectionViewCell.swift
//  HiBorn
//
//  Created by localadmin on 11/8/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit

class productDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCircle: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    func configure(productDict: [String: Any]) {
       
           if let name = productDict["name"] as? String {
                                                     
                                                     productNameLabel.text = name
        }
           
        if let name = productDict["mrp"] as? String {
                                                     
                                                     productPriceLabel.text =    "₹"   + "\(name)"
        }
           
           
           if let imageUrlStr = productDict["thumbnail"] as? String {
                                             
                                                         self.imageCircle.sd_setShowActivityIndicatorView(true)
                                                         self.imageCircle.sd_setIndicatorStyle(.gray)
                                             
                                                         imageCircle.sd_setImage(with: URL(string: APIRouter.baseURLStringForResource + "/storage/" + imageUrlStr), placeholderImage: UIImage.defaultImage(), options: .cacheMemoryOnly)
                                                         }
           
           
       }
       
    
}
