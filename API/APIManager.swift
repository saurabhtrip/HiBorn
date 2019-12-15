//
//  APIManager.swift
//  HiBorn
//
//  Created by localadmin on 11/5/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import Foundation
import Alamofire


class APIManager {
    
    static let defaultManager = APIManager()
    

    
    
    func logIn(apiRouter: APIRouter, completionHandler: @escaping ([String: Any]?) -> Void) {
        
        Alamofire.request(apiRouter).validate().responseJSON { (response) in
            
            print("response...\(response)")
            
            switch response.result {
            
            case .success:
                
                if let json = response.result.value as? [String: Any] {
                    print(HTTPCookieStorage.shared.cookies!)
                    
                    
                    
                    if let fields = response.response?.allHeaderFields as? [String : String]{
                        let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.request?.url!)!)
                        HTTPCookieStorage.shared.setCookies(cookies, for: (response.request?.url!)!, mainDocumentURL: nil)
                    }
                    
                    
                    completionHandler(json)
                }
                
                
            case .failure(let error):
                
                completionHandler(nil)
                
                print(error)
            }
        }
    }

    
    func categories(apiRouter: APIRouter, completionHandler: @escaping ([String: Any]?) -> Void) {
           
           Alamofire.request(apiRouter).validate().responseJSON { (response) in
               
               print("response...\(response)")
               
               switch response.result {
               
               case .success:
                   
                   if let json = response.result.value as? [String: Any] {
                       print(HTTPCookieStorage.shared.cookies!)
                       
                       
                       
                       if let fields = response.response?.allHeaderFields as? [String : String]{
                           let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.request?.url!)!)
                           HTTPCookieStorage.shared.setCookies(cookies, for: (response.request?.url!)!, mainDocumentURL: nil)
                       }
                       
                       
                       completionHandler(json)
                   }
                   
                   
               case .failure(let error):
                   
                   completionHandler(nil)
                   
                   print(error)
               }
           }
       }

    
    func categoriesList(apiRouter: APIRouter, completionHandler: @escaping ([String: Any]?) -> Void) {
           
           Alamofire.request(apiRouter).validate().responseJSON { (response) in
               
               print("response...\(response)")
               
               switch response.result {
               
               case .success:
                   
                   if let json = response.result.value as? [String: Any] {
                       print(HTTPCookieStorage.shared.cookies!)
                       
                       
                       
                       if let fields = response.response?.allHeaderFields as? [String : String]{
                           let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.request?.url!)!)
                           HTTPCookieStorage.shared.setCookies(cookies, for: (response.request?.url!)!, mainDocumentURL: nil)
                       }
                       
                       
                       completionHandler(json)
                   }
                   
                   
               case .failure(let error):
                   
                   completionHandler(nil)
                   
                   print(error)
               }
           }
       }
    
    
    
    func newArrival(apiRouter: APIRouter, completionHandler: @escaping ([String: Any]?) -> Void) {
              
              Alamofire.request(apiRouter).validate().responseJSON { (response) in
                  
                  print("response...\(response)")
                  
                  switch response.result {
                  
                  case .success:
                      
                      if let json = response.result.value as? [String: Any] {
                          print(HTTPCookieStorage.shared.cookies!)
                          
                          
                          
                          if let fields = response.response?.allHeaderFields as? [String : String]{
                              let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.request?.url!)!)
                              HTTPCookieStorage.shared.setCookies(cookies, for: (response.request?.url!)!, mainDocumentURL: nil)
                          }
                          
                          
                          completionHandler(json)
                      }
                      
                      
                  case .failure(let error):
                      
                      completionHandler(nil)
                      
                      print(error)
                  }
              }
          }
    
    
    
    func productsDetails(apiRouter: APIRouter, completionHandler: @escaping ([String: Any]?) -> Void) {
              
              Alamofire.request(apiRouter).validate().responseJSON { (response) in
                  
                  print("response...\(response)")
                  
                  switch response.result {
                  
                  case .success:
                      
                      if let json = response.result.value as? [String: Any] {
                          print(HTTPCookieStorage.shared.cookies!)
                          
                          
                          
                          if let fields = response.response?.allHeaderFields as? [String : String]{
                              let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.request?.url!)!)
                              HTTPCookieStorage.shared.setCookies(cookies, for: (response.request?.url!)!, mainDocumentURL: nil)
                          }
                          
                          
                          completionHandler(json)
                      }
                      
                      
                  case .failure(let error):
                      
                      completionHandler(nil)
                      
                      print(error)
                  }
              }
          }
       
    
    
    func requestJSON(apiRouter: APIRouter, completionHandler: @escaping ([String: Any]?) -> Void) {
        
        Alamofire.request(apiRouter).validate().responseJSON { (response) in
            
            
            
            switch response.result {
                
            case .success:
                
                if let json = response.result.value as? [String: Any] {
                    
                    completionHandler(json)
                }
                
                
            case .failure(let error):
                
                completionHandler(nil)
                
                
            }
        }
    }
    

    
    func orderNow(apiRouter: APIRouter, completionHandler: @escaping ([String: Any]?) -> Void) {
              
              Alamofire.request(apiRouter).validate().responseJSON { (response) in
                  
                  print("response...\(response)")
                  
                  switch response.result {
                  
                  case .success:
                      
                      if let json = response.result.value as? [String: Any] {
                          print(HTTPCookieStorage.shared.cookies!)
                          
                          
                          
                          if let fields = response.response?.allHeaderFields as? [String : String]{
                              let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: (response.request?.url!)!)
                              HTTPCookieStorage.shared.setCookies(cookies, for: (response.request?.url!)!, mainDocumentURL: nil)
                          }
                          
                          
                          completionHandler(json)
                      }
                      
                      
                  case .failure(let error):
                      
                      completionHandler(nil)
                      
                      print(error)
                  }
              }
          }

    
    

    
    

    
    
    
    
    
    
    //    func setCookies(cookies: HTTPCookie){
    //        Alamofire.Manager.sharedInstance.session.configuration.HTTPCookieStorage?.setCookies(cookies, forURL: URLResponse.URL!, mainDocumentURL: nil)
    //    }
    
    // getCookies
    
    
    //
    //
    //    func subscribeProduct(parameters: [String: Any], completionHandler: @escaping ([String: Any]?) -> Void) {
    //
    //        Alamofire.request(APIRouter.subscribeProduct(parameters)).validate().responseJSON { (response) in
    //
    //            print("Request...\(String(describing: response.request))")
    //            print("Request...\(String(describing: response.request?.httpBody))")
    //
    //            switch response.result {
    //
    //            case .success:
    //
    //                print("response...\(response)")
    //
    //                if let json = response.result.value as? [String: Any] {
    //
    //                    completionHandler(json)
    //                }
    //
    //
    //            case .failure(let error):
    //
    //                completionHandler(nil)
    //
    //                print(error)
    //            }
    //        }
    //    }
    
    
    //    func unsubscribeProduct(parameters: [String: String], completionHandler: @escaping ([String: Any]?) -> Void) {
    //
    //        Alamofire.request(APIRouter.unsubscribe(parameters)).validate().responseJSON { (response) in
    //
    //            print("Request...\(String(describing: response.request))")
    //            print("Request...\(String(describing: response.request?.httpBody))")
    //
    //            switch response.result {
    //
    //            case .success:
    //
    //                print("response...\(response)")
    //
    //                if let json = response.result.value as? [String: Any] {
    //
    //                    completionHandler(json)
    //                }
    //
    //
    //            case .failure(let error):
    //
    //                completionHandler(nil)
    //
    //                print(error)
    //            }
    //        }
    //    }
    //
    
    //    func changeQuantity(parameters: [String: String], completionHandler: @escaping ([String: Any]?) -> Void) {
    //
    //        Alamofire.request(APIRouter.changeQuantity(parameters)).validate().responseJSON { (response) in
    //
    //            print("Request...\(String(describing: response.request))")
    //            print("Request...\(String(describing: response.request?.httpBody))")
    //
    //            switch response.result {
    //
    //            case .success:
    //
    //                print("response...\(response)")
    //
    //                if let json = response.result.value as? [String: Any] {
    //
    //                    completionHandler(json)
    //                }
    //
    //
    //            case .failure(let error):
    //
    //                completionHandler(nil)
    //
    //                print(error)
    //            }
    //        }
    //    }
    //
    
    
    
    
    
    
    
    
    //    func getProductPrice(parameters: [String: Any], completionHandler: @escaping ([String: Any]?) -> Void) {
    //
    //        Alamofire.request(APIRouter.getProductPrice(parameters)).validate().responseJSON { (response) in
    //
    //            switch response.result {
    //
    //            case .success:
    //
    //                print("response...\(response)")
    //
    //                if let json = response.result.value as? [String: Any] {
    //
    //                    completionHandler(json)
    //                }
    //
    //
    //            case .failure(let error):
    //
    //                completionHandler(nil)
    //
    //                print(error)
    //            }
    //        }
    //    }
    
}
