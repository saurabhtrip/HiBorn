//
//  APIRouter.swift
//  HiBorn
//
//  Created by localadmin on 11/5/19.
//  Copyright © 2019 localadmin. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
  static let baseURLString = "https://admin.antaresclothings.com"   //production
    


    static let baseURLStringForResource = "https://admin.antaresclothings.com"
  
    
       case logIn([String: Any])
    
        case categories([String: Any])
  
    case categoriesList([String: Any])
       case productsDetails([String: Any])
 
    case  newArrival([String : Any])
    case  orderNow([String : Any])
     
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            
            switch self {
            case .categories :
             return .get
         
            case .categoriesList :
               return .get
            case   .productsDetails :
                return .get
                
            case   .newArrival:
                             return .get
                             
         case .orderNow:
       return .post
                
                
            default:
            
                             return .post
               
                
            }
        }
       
        let params: ([String: Any]?) = {
            
            switch self {
                
            case .logIn(let parameters):
                   return parameters

            case .categories(let parameters):
                             return parameters
                
              case .categoriesList(let parameters):
                                         return parameters
           
            case .productsDetails(let parameters):
                return parameters
                
                
                case .newArrival(let parameters):
                           return parameters
                           
                case .orderNow(let parameters):
                    return parameters
                
            default:
                return [:]
                
            }
        }()
        
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            
            switch self {
    
            case .logIn(_):
                relativePath = "/api/auth/login"
                
                case .categories(_):
                relativePath = "/api/public/categories/get"
                
                case .categoriesList(_):
                             relativePath = "/api/public/products/category/\(    ProductDetailsViewController.produuctDetailId)"
               
            case .productsDetails(_):
                relativePath = "/api/public/products/detail/\(buyProductViewController.productDetailsID)"
          
            case .newArrival(_):
           relativePath = "/api/public/products/category/new_arrival"
                
                case .orderNow(_):
                             relativePath = "/api/public/orders/add"

            }
            
//        ProductListViewController.produuctid =  productwithparentid[indexPath.row]["id"]
            var url = URL(string: APIRouter.baseURLString)!
            
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            
            return url
        }()
        
        let encoding: ParameterEncoding = {
            
            switch method {
                
            case .post:
                return URLEncoding.httpBody
            default:
                return URLEncoding.default
            }
        }()
        
        
        
        
        
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            
            return try encoding.encode(urlRequest, with: params)
            
    }
}
