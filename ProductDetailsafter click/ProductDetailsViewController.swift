//
//  ProductDetailsViewController.swift
//  HiBorn
//
//  Created by localadmin on 11/8/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
 import MBProgressHUD

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var collectionViewCell: UICollectionView!
 
    @IBOutlet weak var ProductcollectionView: UICollectionView!
       let cartButton = SSBadgeButton()
     var productcategoryList = [[String: Any]]()
    var productid : Int = 0
       static var produuctDetailId : Int = 0
    var productList: [[String: Any]]? {
        
        didSet {
            
            ProductcollectionView.reloadData()

        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
               productListfetch()
        var count = 0
        
        if var  decodedColorsData = UserDefaults.standard.data(forKey: "items"),
                           let colorsArray = NSKeyedUnarchiver.unarchiveObject(with: decodedColorsData) as? [DataModel] {
                         
                           count    = colorsArray.count
                               cartButton.badge =    "\(count)"
                       } else {
                           buyProductViewController.buyDetails = []
                       }
        
                  cartButton.frame = CGRect(x: 0, y: 0, width: 44, height: 40)
                    cartButton.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    cartButton.badgeEdgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 10)
                    cartButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
//                      cartButton.badge = "\( buyProductViewController.buyDetails.count)"
                       let backButton  = UIImage(named: "back")!
                 let backButtonNavigation = UIBarButtonItem(image: backButton,  style: .plain, target: self, action: #selector(didTapSearchButton))

                 navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: cartButton)]


                 self.navigationItem.leftBarButtonItem = nil

                 let button = UIButton(type: .custom)
                 button.setImage(UIImage (named: "navigation"), for: .normal)
                 button.frame = CGRect(x: 0.0, y: 0.0, width: 60, height: 60)
                 //button.addTarget(target, action: nil, for: .touchUpInside)
                 let barButtonItem = UIBarButtonItem(customView: button)
                self.navigationItem.leftBarButtonItems =  [backButtonNavigation,barButtonItem]
    }
    
    @objc func didTapEditButton(sender: AnyObject){

                   let Controller = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
      
                      self.navigationController?.pushViewController(Controller, animated: false)

      }


        @objc func didTapSearchButton(sender: UIBarButtonItem){
            
             self.navigationController?.backToViewController(viewController: ProductListViewController.self)
            

        }
  

}
extension ProductDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        var count : Int = 0

   
        if collectionView == self.collectionViewCell {
            return productcategoryList.count
            collectionView.setEmptyMessage("")
              }

              else {
               if let value = productList {
               count = productList!.count
                if (count == 0) {
                  collectionView.setEmptyMessage("Products Comming Soon.")
           
                }
                else {
                     collectionView.setEmptyMessage("")
                }

                              }
               return count

              }

      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        if collectionView == self.collectionViewCell {
           let width = view.frame.size.width
          return CGSize.init(width: width * 0.25, height: collectionView.frame.height - 5)
        }
      else {
            return CGSize.init(width: floor((collectionView.frame.width - 1 ) / 2), height: collectionView.frame.height / 3)

        }
        
      }
      
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          
          if collectionView.frame.width.truncatingRemainder(dividingBy: 2) == 0 {
              return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
              
          } else {
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0.0)
          }
      }
      
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if collectionView == self.collectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCatagoryCollectionViewCell", for: indexPath) as! subCatagoryCollectionViewCell
                let  product  =  productcategoryList[indexPath.row]
                if let name = product["name"] as? String {
                                                               
                 cell.subNameLabel.text    = name
            }

         return cell
        }
        else {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productDetailsCollectionViewCell", for: indexPath) as! productDetailsCollectionViewCell
            let product = (productList?[indexPath.row])!
                                   cell.configure(productDict: product)
             return cell
        }
  

    }
    
    
        
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        
           if collectionView == self.collectionViewCell {
          
              let  product  =  productcategoryList[indexPath.row]

                                           
             if        let value = product["id"] as? Int {
                ProductDetailsViewController.produuctDetailId = value
                                       
          }
            
           productListfetch()
            
              }
         
  else {
        
   let Controller = self.storyboard?.instantiateViewController(withIdentifier: "buyProductViewController") as! buyProductViewController
        buyProductViewController.productDetailsID =  (productList?[indexPath.row]["id"]  as? Int)!
     
                self.navigationController?.pushViewController(Controller, animated: false)

        }
      }
//
  
}



extension UINavigationController {

    func backToViewController(viewController: Swift.AnyClass) {

            for element in viewControllers as Array {
                if element.isKind(of: viewController) {
                    self.popToViewController(element, animated: true)
                break
            }
        }
    }
}
extension ProductDetailsViewController  {
      func productListfetch()
           {

                  let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.label.text = "Please wait..."


                   let url = "api/public/categories/get"

                     let param = ["url": url]
                           print(param)

                    APIManager.defaultManager.categoriesList(apiRouter: .categoriesList(param)) { (responseDict) in
                           print(param)
                        if let responseDict = responseDict {


                            if let status = responseDict["status"] as? String {
                             MBProgressHUD.hide(for: self.view, animated: true)

                               if status == "success" {

                                self.productList     =  responseDict["product_details"] as! [[String : Any]]

                                for i in   self.productList! {
                                     if i["parent_id"] as? Int  ==  0 {
     
                                        
                                    }
                                }

                                
                               }
                                self.ProductcollectionView.reloadData()

                            }
                        }
                    }


        }
}

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
