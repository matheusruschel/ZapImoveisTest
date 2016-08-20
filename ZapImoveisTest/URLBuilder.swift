//
//  URLBuilder.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/20/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation


class URLBuilder {
    
    static func buildURLForImovelId(imovelId:Int) -> NSURL? {
        
        let stringUrlFinal = "\(URLJSONBase)\(imovelId).json"
        
        return NSURL(string: stringUrlFinal)
        
    }
    
}