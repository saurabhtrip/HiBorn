//
//  LoginViewController.swift
//  HiBorn
//
//  Created by localadmin on 11/5/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class LoginViewController: UIViewController ,UITextFieldDelegate{
    
    
    
    @IBOutlet var usernameTextField: UITextField!
      @IBOutlet var passwordTextField: UITextField!
      
      var showlogin : Bool = false
        let defaults = UserDefaults.standard
      @IBOutlet weak var passwordButton: UIButton!
//      @IBAction func btnPasswordVisiblityClicked(_ sender: Any) {
//          
//          (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
//          if (sender as! UIButton).isSelected {
//              passwordTextField.isSecureTextEntry = false
//          } else {
//              passwordTextField.isSecureTextEntry = true
//          }
//      }
    var deviceId: String {
         return (UIDevice.current.identifierForVendor?.uuidString)!
     }

    override func viewDidLoad() {
        super.viewDidLoad()
         
        let  showLoginValue : Bool = UserDefaults.standard.bool(forKey: "mySwitch")// this is how you retrieve the bool value
        
        guard let  token : String = UserDefaults.standard.string(forKey: "token")  else{ return }

     //    to see the value, just print those with conditions. you can use those for your things.
        if showLoginValue == true {
        checkuserlogin()
        }
        else {
            print("false")
        }
        
        
           self.navigationController?.navigationBar.isHidden = true
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetViewForLogoutScreen()
    }
    
    
    func resetViewForLogoutScreen() {
         
      
          self.usernameTextField?.text = ""
          self.passwordTextField?.text = ""

          
      }
    
    
  
    @IBAction func buttonAction(_ sender: Any) {
//        usernameTextField.resignFirstResponder()
        
        
//
            defaults.set("\(usernameTextField.text!)", forKey: "username")
        defaults.set("\(passwordTextField.text!)", forKey: "password")
//
    logIn()
//
        
        
    }
}



extension LoginViewController {
    
    
    fileprivate func logIn() {
         
//         view.isHidden = false
       
         
         let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
         hud.label.text = "Please wait..."

        
         let param = ["email": usernameTextField.text! , "password": passwordTextField.text! , "device_id" :  "\(deviceId)"]
 
           APIManager.defaultManager.logIn(apiRouter: .logIn(param)) { (responseDict) in
              if let responseDict = responseDict {
                  let message = responseDict["message"] as? String
  
                   if let status = responseDict["status"] as? String {
                     MBProgressHUD.hide(for: self.view, animated: true)
                    
                       if status == "success" {
                        self.showlogin   = true
                       
                        UserDefaults.standard.set(self.showlogin, forKey: "mySwitch")
                        
                        
                               let token = responseDict["token"] as? String
                                UserDefaults.standard.set(token, forKey: "token")
                        
                         let mainMenuController = self.storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
                           
                           self.navigationController?.pushViewController(mainMenuController, animated: false) 
    
                    }

                     else   {
                        self.showlogin   = false
                                             
                                              UserDefaults.standard.set(self.showlogin, forKey: "mySwitch")
                         let alertController = UIAlertController(title: status, message: message , preferredStyle: .alert)
                         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                         alertController.addAction(defaultAction)
                         self.present(alertController, animated: true, completion: nil)

                     }
                     
                 }
             }
         }
         
     }
    
    
    
}



extension LoginViewController {
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
              let userInfo = notification.userInfo ?? [:]
              let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
              
              UIView.animate(withDuration: duration, animations: {
                  self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -100)
              })
   
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        

           let userInfo = notification.userInfo ?? [:]
           let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
           
           UIView.animate(withDuration: duration, animations: {
               self.view.frame = self.view.frame.offsetBy(dx: 0, dy: 100)
           })
       }
}
extension LoginViewController {
    
    func checkuserlogin()
       {
           
           guard  let stringOne = defaults.string(forKey: "username") else {
               return
           }
           guard  let stringTwo = defaults.string(forKey: "password") else {
               return
           }
           
        
              let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.label.text = "Please wait..."
                
                
               
               
                let param = ["email":  stringOne , "password": stringTwo , "device_id" :  "\(deviceId)"]
        
                
                APIManager.defaultManager.logIn(apiRouter: .logIn(param)) { (responseDict) in
                    if let responseDict = responseDict {
                        let message = responseDict["message"] as? String
         
                        if let status = responseDict["status"] as? String {
                           MBProgressHUD.hide(for: self.view, animated: true)
                           
                           if status == "success" {
                               self.showlogin   = true
                              
                               UserDefaults.standard.set(self.showlogin, forKey: "mySwitch")

                            let token = responseDict["token"] as? String
                            UserDefaults.standard.set(token, forKey: "token")
                               
                              let mainMenuController = self.storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
                                  
                                 self.navigationController?.pushViewController(mainMenuController, animated: false)
           
                           }

                            else   {
                            self.showlogin   = false
                                                        
                                                         UserDefaults.standard.set(self.showlogin, forKey: "mySwitch")
                            
                                let alertController = UIAlertController(title: status, message: message , preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alertController.addAction(defaultAction)
                                self.present(alertController, animated: true, completion: nil)

                            }
                            
                        }
                    }
                }
        
        
    }
    
}
