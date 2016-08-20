//
//  FotoDownloader.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation
import UIKit

typealias ImageCallbackCompletionBlock =  (() throws -> UIImage?) -> Void

class FotoDownloader {
    
    var session: NSURLSession!
    
    init() {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfig.timeoutIntervalForRequest = 15
        session = NSURLSession(configuration: sessionConfig)
    }
    
    func fetchImage(url: NSURL, completion:ImageCallbackCompletionBlock) {
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) in
            
            if error == nil {
                completion({
                    return UIImage(data: data!)
                })
                
            } else {
                completion({ throw error!})
            }
            
        }
        task.resume()
    }

    
}