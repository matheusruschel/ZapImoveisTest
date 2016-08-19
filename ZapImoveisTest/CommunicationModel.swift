//
//  CommunicationModel.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

typealias DataCallbackCompletionBlock =  (() throws -> AnyObject) -> Void

class CommunicationModel {
    
    var session: NSURLSession!
    
    init() {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfig.timeoutIntervalForRequest = 15
        session = NSURLSession(configuration: sessionConfig)
    }
    
    func fetchDataOnline(url: NSURL, completion:DataCallbackCompletionBlock) {
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) in
            
            if error == nil {
                completion({
//                    let ndJsonText = String(data: data!, encoding: NSUTF8StringEncoding)
//                    let jsonData = ndJsonText!.dataUsingEncoding(NSUTF8StringEncoding)
                    return try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:AnyObject]
                })
                
            } else {
                completion({ throw error!})
            }
            
        }
        task.resume()
    }

    
    
}