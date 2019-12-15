//
//  CartTableViewCell.swift
//  HiBorn
//
//  Created by localadmin on 11/11/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
        @IBOutlet weak var productDiscriptionLAbel: UILabel!
 
    @IBOutlet weak var productNameLabel: UILabel!
        @IBOutlet weak var priceLabel: UILabel!
     @IBOutlet weak var sizeLabel: UILabel!
       @IBOutlet weak var MoLabel: UILabel!
    
    var product  = [DataModel]()
    

      @IBOutlet weak var changeQuantityLabel: UILabel!
       @IBOutlet weak var minusButton: UIButton!
       @IBOutlet weak var plusButton: UIButton!
          @IBOutlet weak var removeproduct : UIButton!
    
      @IBAction func addAction(_ sender: UIButton) {
          
          
          var indexpath = sender.tag

          if let quantity = Int(self.changeQuantityLabel.text!) {
             
               self.changeQuantityLabel.text = "\(quantity + 1)"
              product[indexpath].quantity = quantity + 1
              let appDelegate = UIApplication.shared.delegate as! AppDelegate
       //       appDelegate.changeQuantityLabel =  self.changeQuantityLabel.text!

              }
 
      }
      var sau = [""]
      
      @IBAction func minusAction(_ sender: UIButton) {
          
            var indexpath = sender.tag
          if let quantity = Int(self.changeQuantityLabel.text!) {
              
                if quantity > 0 {
                   self.changeQuantityLabel.text = "\(quantity - 1)"
             //      products[indexpath].change = quantity - 1
                   self.sau =    [self.changeQuantityLabel.text!]

              }
          }
      }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
