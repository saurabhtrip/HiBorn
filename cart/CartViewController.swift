//
//  CartViewController.swift
//  HiBorn
//
//  Created by localadmin on 11/11/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
 import MBProgressHUD
class CartViewController: UIViewController {
//    var data = buyProductViewController.buyDetails
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func orderNow(_ sender: UIButton) {
        orderNow()
    }
    
    var orderremove : [DataModel]?
    override func viewDidLoad() {
        super.viewDidLoad()


          self.navigationItem.leftBarButtonItem = nil
              let backButton  = UIImage(named: "back")!
             let backNavigationButton = UIBarButtonItem(image: backButton ,  style: .plain, target: self, action: #selector(didTapSearchButton))
         let button = UIButton(type: .custom)
         button.setImage(UIImage (named: "navigation"), for: .normal)
         button.frame = CGRect(x: 0.0, y: 0.0, width: 60, height: 60)
     
         let barButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItems =  [backNavigationButton,barButtonItem]
    }
    
               
         @objc func didTapSearchButton(sender: UIBarButtonItem){
                      
                      _ = navigationController?.popViewController(animated: true)
                      
                      
               

           }
}
extension CartViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
//        for decodedArray1 in decodedArray {
//            count    = decodedArray.count
//        }
        
        if var  decodedColorsData = UserDefaults.standard.data(forKey: "items"),
                           let colorsArray = NSKeyedUnarchiver.unarchiveObject(with: decodedColorsData) as? [DataModel] {
                         
                           count    = colorsArray.count
                           
                       } else {
                           buyProductViewController.buyDetails = []
                       }

        
        
     
        
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        
        
        if let decodedColorsData = UserDefaults.standard.data(forKey: "items"),
                               let colorsArray = NSKeyedUnarchiver.unarchiveObject(with: decodedColorsData) as? [DataModel] {
            
        
            let productvalue =  colorsArray
            
            cell.product  = productvalue
                            
            let  decodedArray1 =  colorsArray[indexPath.row]
            
              self.orderremove = colorsArray
            
            
            cell.productNameLabel.text = decodedArray1.product?["name"] as! String
          
            
            if let quantity =    decodedArray1.quantity {
                cell.changeQuantityLabel.text =    "\(quantity)"
             }
            
            if let imageUrlStr = decodedArray1.product?["thumbnail"] as? String {
                                                      
                                                                  cell.productImage.sd_setShowActivityIndicatorView(true)
                                                                     cell.productImage.sd_setIndicatorStyle(.gray)
                                                      
                                                                   cell.productImage.sd_setImage(with: URL(string: APIRouter.baseURLStringForResource + "/storage/" + imageUrlStr), placeholderImage: UIImage.defaultImage(), options: .cacheMemoryOnly)
                                                                  }
    
             } else {
                               buyProductViewController.buyDetails = []
                           }

        
        cell.removeproduct.tag = indexPath.row

        cell.removeproduct.addTarget(self,action:#selector(buttonClicked(sender:)), for: .touchUpInside)

      
        
        

        return cell
    }
    
}

extension CartViewController    {
    func orderNow()
    {
        
        
            var param =  [String: Any]()
   
        var      jsonObject = [String : Any]()
             var      variabledata  =   " "
    var sizedetaits = String()
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Please wait..."
 
   
        
        
        if let decodedColorsData = UserDefaults.standard.data(forKey: "items"),
        let colorsArray = NSKeyedUnarchiver.unarchiveObject(with: decodedColorsData) as? [DataModel] {
       
   
            
            
            for array in   colorsArray{
                
                guard let  productid  =    array.product?["id"] else { return}
                
                
                             let sizeDetails    =    array.product!["sizes"] as? [[String : Any]]
                                   for i in  sizeDetails!{
                                       for (key,value) in  i {
                                           
                                           if key == "key" {
                                               
                                               if let sizesValue =  value  as? String {
                                                   
                                             
                                                sizedetaits.append(sizesValue)
                                                          
                                                       print(sizedetaits)
                                                             //                                                            self.sizeLabel.text = "\(self.sizedetaits)"
                                                    variabledata = " "
                                                for i in sizedetaits  {
                                                
                                                    variabledata    =  variabledata  +  "\(i)"
                                 
                                                }
           
                                                   
                                               }
                                           }
                                           
                                       }
                                       
                                   }
                                   
         
                
                
                var para : [String:Any] = [String:Any]()
                var prodArray : [[String:Any]] = [[String:Any]]()

                para["retailer_id"] = 20
                para["status"] = "initial"

                for product in colorsArray {
                    var prod : [String : Any] = [String : Any]()
                    if let productId = product.product?["id"] {
                         prod["product_id"] = productId
                    }

                    prod["quantity"] =  1
                    prod["size_key"] = variabledata

                    prodArray.append(prod)
                }
 
                para["orderItems"] =   ("\(prodArray)")
                

                
                let jsonData = try! JSONSerialization.data(withJSONObject: prodArray)
                let arrayString = String(data: jsonData, encoding: .utf8)!
                para["orderItems"] = arrayString
                let resultData = try! JSONSerialization.data(withJSONObject: para)
                    let jsonString = String(data: resultData, encoding: .utf8)!
                
          
                guard  let token  = UserDefaults.standard.string(forKey: "token") else{
                         return
                     }
                

             let trimmedString = jsonString.trimmingCharacters(in: .whitespaces)
     
           param = ["json": trimmedString ,  "token" :  "Bearer " +  token  ]
                 print("============")
                 print(param)
                  print("============")
                       APIManager.defaultManager.productsDetails(apiRouter: .orderNow(param)) { (responseDict) in
                      
                           if let responseDict = responseDict {
                               if let status = responseDict["status"] as? String {
                                   MBProgressHUD.hide(for: self.view, animated: true)
                                //   self.productDetailsList =  [String: Any]()
                                   if status == "success" {
        
                                       }

                                   }
                               }
                           }
                
                }
            
        
            
            
            

        } else {
                                      buyProductViewController.buyDetails = []
                                  }
            
         
     
        
        
     
        
      }
    
    @objc func buttonClicked(sender:UIButton) {

                   let buttonRow = sender.tag
         
         buyProductViewController.buyDetails = [DataModel]()
                
        var   decodedArray1 =   orderremove

        decodedArray1?.remove(at: buttonRow)
      
        for i in decodedArray1! {
       
            buyProductViewController.buyDetails.append(DataModel(quantity  : i.quantity  ,product: i.product))
              
        }
        
        let itemA =  buyProductViewController.buyDetails
                                   let encodedData = NSKeyedArchiver.archivedData(withRootObject: itemA)
                                  UserDefaults.standard.set(encodedData, forKey: "items")
        
                                            tableView.reloadData()
             
             
      
               }
 
    
 }

