//
//  ResponseObject.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation


struct ResponseObject {
    
    var imoveis: Imoveis?
    var responseStatus: ResponseStatus?
}

extension ResponseObject : Wrappable {
    
    init?(data: AnyObject) {
        
        guard let imoveisJson = data["Imoveis"] as? [String: AnyObject],
            let responseStatusJson = data["ResponseStatus"] as? [String: AnyObject] else {
                return nil
        }
        
        guard let imoveis = Imoveis(data: imoveisJson),
            let responseStatus = ResponseStatus(data: responseStatusJson) else {
                return nil
        }
        
        self.init(imoveis: imoveis,responseStatus:responseStatus)
        
    }
    
}