//
//  Router.swift
//
//  Created by Mike Kavouras on 5/10/16.
//

import Foundation
import Alamofire

struct Server {
    static let HOST = "https://website.com"
    static let PORT = ""
}

enum ResultType<T> {
    case Success(T)
    case Error(String)
}

typealias JSON = [String:AnyObject]

enum Router: URLRequestConvertible {

    /**
     * example: get access token with email and password
    */
    
    case GetAccessToken(String, String)
    
    private var APP_ID: String {
        let path = NSBundle.mainBundle().pathForResource("Env", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile: path)!
        let appId = plist["APP_ID"] as! String
        return appId
    }
    
    private var BASE_URL: String {
        var url = "\(Server.HOST)"
        if !Server.PORT.empty {
            url += ":\(Server.PORT)"
        }
        return url
    }
    
    private var method: Alamofire.Method {
        switch self {
        
        case .GetAccessToken:
            return .POST
            
        default: break
        }
    }
    
    private var path: String {
        switch self {
            
        case .GetAccessToken:
            return "some/url/route"
        
        default: break
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        let url = NSURL(string: "\(BASE_URL)")!
        let mutableURLRequest = NSMutableURLRequest(URL: url.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        switch self {
            
        case .GetAccessToken(let email, let password):
            let parameters = [ "email" : email, "password" : password, "app_id" : APP_ID ]
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
            
        default: break
        }
    }
}