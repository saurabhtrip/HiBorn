//
//  ProductListViewController.swift
//  HiBorn
//
//  Created by localadmin on 11/5/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
 import MBProgressHUD

class ProductListViewController: UIViewController {

    
    @IBOutlet weak var NewArrivalButton: UIButton!
    //    static var produuctid : Int = 0
    var productList: [[String: Any]]? {
        
        didSet {
            
            collectionViewCell.reloadData()

        }
    }
    
    var productwithparentid  = [[String: Any]]()

         let defaults = UserDefaults.standard
      let    moreoptionarrayattop = ["Log Out"]
            let cartButton = SSBadgeButton()
    override func viewDidLoad() {
        super.viewDidLoad()
       let refreshControl = UIRefreshControl()
          refreshControl.addTarget(self, action: #selector(refreshControlDidFire), for: .valueChanged)
             collectionViewCell?.refreshControl = refreshControl
         self.navigationController?.navigationBar.isHidden = false
        
        productListfetch()
        
        
        if var  decodedColorsData = UserDefaults.standard.data(forKey: "items"),
                                 let colorsArray = NSKeyedUnarchiver.unarchiveObject(with: decodedColorsData) as? [DataModel] {
                               
               let                   count    = colorsArray.count
            
            
            
            cartButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                     cartButton.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
                     cartButton.badgeEdgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 10)
                     cartButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
                    
                                     cartButton.badge  =   "\(count)"
                             } else {
                                 buyProductViewController.buyDetails = []
                             }
        
        
        

//         let cartimage    = UIImage(named: "cart")!
         let logout  = UIImage(named: "verticalmenu")!

        
         
        
        
//        let editButton   = UIBarButtonItem(image: cartimage,  style: .plain, target: self, action: #selector(didTapEditButton))
        let searchButton = UIBarButtonItem(image: logout,  style: .plain, target: self, action: #selector(didTapSearchButton))

        navigationItem.rightBarButtonItems = [searchButton,UIBarButtonItem(customView: cartButton)]


        self.navigationItem.leftBarButtonItem = nil

        let button = UIButton(type: .custom)
        button.setImage(UIImage (named: "navigation"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 60, height: 60)
        //button.addTarget(target, action: nil, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
         self.navigationItem.leftBarButtonItems =  [barButtonItem]
    }
    @IBOutlet weak var leftMenu: UIBarButtonItem!
    
    @IBOutlet weak var collectionViewCell: UICollectionView!
    @objc func refreshControlDidFire() {
     
       collectionViewCell?.reloadData()
       collectionViewCell?.refreshControl?.endRefreshing()
     }
    
    
    @IBAction func NewArrival(_ sender: UIButton) {

    }
    
    @objc func didTapEditButton(sender: AnyObject){

                 let Controller = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
    
                    self.navigationController?.pushViewController(Controller, animated: false)

    }

    @objc func didTapSearchButton(sender: UIBarButtonItem){
        print("logout")
        
        
        let popOverViewController = PopOverViewController(nibName: "PopOverViewController", bundle: nil)
  

                popOverViewController.preferredContentSize =  CGSize(width: 130, height: 50)

            popOverViewController.delegate = self
//            popOverViewController.customBackgroundColor = UIColor.extraDarkGray
            popOverViewController.customTextColor = UIColor.black
            popOverViewController.dataArray = moreoptionarrayattop
            popOverViewController.permittedArrowDirections = .right
            //        popOverViewController.preferredContentSize =  CGSize(width: 200, height: 150)
            
            
            popOverViewController.presentPopoverFromBarButton(sender, fromController: self)
            
 
    }
    
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProductListViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        var count : Int = 0
        let value = productwithparentid
           
            
   
        
        return value.count
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
          return CGSize.init(width: floor((collectionView.frame.width - 20) / 2), height: collectionView.frame.height / 3)
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          
          if collectionView.frame.width.truncatingRemainder(dividingBy: 2) == 0 {
              return UIEdgeInsets.init(top: 0, left: -1, bottom: 0, right: 0)
              
          } else {
              return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
          }
      }
      
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
          
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as! ProductListCollectionViewCell
         let product = productwithparentid[indexPath.row]
            ProductDetailsViewController.produuctDetailId =  productwithparentid[indexPath.row]["id"] as! Int
           cell.configure(productDict: product)

          return cell
      }
    
   
    
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       

           ProductDetailsViewController.produuctDetailId =  productwithparentid[indexPath.row]["id"] as! Int
         let Controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
             Controller.productcategoryList =  self.productList!
            self.navigationController?.pushViewController(Controller, animated: false)
 
  }
  
  
}
extension ProductListViewController: PopOverViewControllerDelegate {
    
    func selectedValue(_ value: String, index: Int, popOverViewController: PopOverViewController) {
        
        
        
        if index == 0 {
            let controller =  LoginViewController ()
            
                   controller.showlogin   = false
                                               
                                                UserDefaults.standard.set(controller.showlogin, forKey: "mySwitch")
                       self.defaults.removeObject(forKey:"username")
                       self.defaults.removeObject(forKey:"password")
                          controller.resetViewForLogoutScreen()
                      self.navigationController?.popToRootViewController(animated: true)
    
            
        }
 
    }
}

extension ProductListViewController  {
    func productListfetch()
       {
        
              let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.label.text = "Please wait..."
                
    
               let url = "api/public/categories/get"
               
                 let param = ["url": url]
                       print(param)
                
                APIManager.defaultManager.categories(apiRouter: .categories(param)) { (responseDict) in
                       print(param)
                    if let responseDict = responseDict {
                      
         
                        if let status = responseDict["status"] as? String {
                           MBProgressHUD.hide(for: self.view, animated: true)
                           
                           if status == "success" {
                          
                            self.productList     =  responseDict["category_lists"] as! [[String : Any]]
           
                            for i in   self.productList! {
                                 if i["parent_id"] as? Int  ==  0 {
                                    self.productwithparentid.append(i)
                                }
                            }
                            
                            
                           }

                            else   {
                     
//                                let alertController = UIAlertController(title: status, message: message , preferredStyle: .alert)
//                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                                alertController.addAction(defaultAction)
//                                self.present(alertController, animated: true, completion: nil)

                            }
                            
                        }
                    }
                }
        
        
    }
    
    
    
     
    
    
}
