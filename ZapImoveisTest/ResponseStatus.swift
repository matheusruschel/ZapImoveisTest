//
//  ResponseStatus.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

struct ResponseStatus {
    
    var msg: String?
}
extension ResponseStatus : Wrappable {
    
    init?(data: AnyObject) {
        
        if let msg = data["Message"] as? String {
            self.init(msg:msg)
        } else {
            return nil
        }
    }
}