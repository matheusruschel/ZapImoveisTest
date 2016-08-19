//
//  RealStateCommunicationModel.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

typealias RealStateCompletionBlock = (() throws -> Imoveis) -> Void

class RealStateCommunicationModel {
    
    let api = CommunicationModel()
    
    func fetchImoveis(completion:RealStateCompletionBlock) {
        
        if let url = NSURL(string: URLJSON) {
            
            api.fetchDataOnline(url, completion: {
            
                data in
                completion({
                    
                let imoveisData = try data()
                    
                let imoveisJson = imoveisData["Imoveis"]
                    
                    if let imoveis = Imoveis(data:imoveisJson!!) {
                        return imoveis
                    } else {
                        throw Error.ErrorWithMsg(msg: "Error parsing Json file")
                    }
                    
                })
            
            
            })
            
        } else {
            fatalError("Invalid URL provided")
        }
        
        
    }
    

}