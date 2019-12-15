//
//  NewArrivalViewController.swift
//  HiBorn
//
//  Created by localadmin on 11/19/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
 import MBProgressHUD
class NewArrivalViewController: UIViewController {
       @IBOutlet weak var collectionCell: UICollectionView!
    

    var  productwithparentid   = [[String : Any]]()
    let cartButton = SSBadgeButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
     NewArrival()
     cartButton.frame = CGRect(x: 0, y: 0, width: 44, height: 40)
                         cartButton.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
                         cartButton.badgeEdgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 10)
                         cartButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
                         cartButton.badge = "4"
                            let backButton  = UIImage(named: "back")!
              
              //        let editButton   = UIBarButtonItem(image: cartimage,  style: .plain, target: self, action: #selector(didTapEditButton))
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
           @objc func didTapSearchButton(sender: UIBarButtonItem){
              
               self.navigationController?.backToViewController(viewController: ProductListViewController.self)
              

          }
    
    @objc func didTapEditButton(sender: AnyObject){

                 let Controller = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
    
                    self.navigationController?.pushViewController(Controller, animated: false)

    }

    
       func NewArrival()
               {
                
                      let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.label.text = "Please wait..."
                        
            
                       let url = "api/public/categories/get"
                       
                         let param = ["url": url]
                               print(param)
                        
                        APIManager.defaultManager.newArrival(apiRouter: .newArrival(param)) { (responseDict) in
                               print(param)
                            if let responseDict = responseDict {
                              
                 
                                if let status = responseDict["status"] as? String {
                                   MBProgressHUD.hide(for: self.view, animated: true)
                                   
                                   if status == "success" {
                                  
                                    self.productwithparentid     =  (responseDict["product_details"] as? [[String : Any]])!
//                                    self.collectionViewCell.reloadData()
 

                                    
                                   }

                                    else   {
                             
        //                                let alertController = UIAlertController(title: status, message: message , preferredStyle: .alert)
        //                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        //                                alertController.addAction(defaultAction)
        //                                self.present(alertController, animated: true, completion: nil)

                                    }
//                                    self.collectionViewCell.reloadData()
                                }
                            }
                            
                            
                        }
                
                
            }


}
extension NewArrivalViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        var count : Int = 0
//    let value = productwithparentid
     
        
   
              let value = productwithparentid
        count = value.count
                
                
                if (count == 0) {
                  collectionView.setEmptyMessage("Products Comming Soon.")
           
                }
                else {
                     collectionView.setEmptyMessage("")
                }

               return count

              

        
        
        
     
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
   
            
      
         
            return CGSize.init(width: floor((collectionView.frame.width - 1 ) / 2), height: collectionView.frame.height / 3)

      
      }
      
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          
          if collectionView.frame.width.truncatingRemainder(dividingBy: 2) == 0 {
              return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
              
          } else {
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0.0)
          }
      }
      
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
   
 
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewArrivalCollectionViewCell", for: indexPath) as! NewArrivalCollectionViewCell
//            let product = (productList?[indexPath.row])!
//                                   cell.configure(productDict: product)
             return cell
  
  

    }
    
    
        
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        

         

        
   let Controller = self.storyboard?.instantiateViewController(withIdentifier: "buyProductViewController") as! buyProductViewController
         //   buyProductViewController.productDetailsID =  (productList?[indexPath.row]["id"]  as? Int)!
     
                self.navigationController?.pushViewController(Controller, animated: false)

        }

  
}
