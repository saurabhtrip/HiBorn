//
//  DataModel.swift
//  HiBorn
//
//  Created by localadmin on 11/19/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import Foundation
class DataModel : NSObject, NSCoding  {
    let product :[String : Any]?
     var   quantity : Int?
    

    
    func encode(with aCoder: NSCoder)
       {
           aCoder.encode(self.product, forKey: "itemID")
            aCoder.encode(self.quantity, forKey: "quantity")
       }
       
       required init?(coder aDecoder: NSCoder)
       {
        self.product = aDecoder.decodeObject(forKey: "itemID") as? [String : Any]
        
        self.quantity = aDecoder.decodeObject(forKey: "quantity") as?Int
       }
    
        
      
   
    
      

    init( quantity : Int? , product: [String : Any]?   ) {
               self.quantity = quantity
               self.product = product
           }
        
       }


