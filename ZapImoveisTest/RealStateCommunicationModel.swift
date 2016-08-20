//
//  RealStateCommunicationModel.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

enum CallBackStatusImoveis {
    case ResponseObjectImoveis(status:ResponseStatus, imoveis:[Imovel])
}

enum CallBackStatusImovel {
    case ResponseObjectImovel(imovel:Imovel)
}



typealias ImoveisCompletionBlock = (() throws -> CallBackStatusImoveis) -> Void
typealias ImovelCompletionBlock = (() throws -> CallBackStatusImovel) -> Void

class RealStateCommunicationModel {
    
    let api = CommunicationModel()
    
    func fetchImoveis(completion:ImoveisCompletionBlock) {
        
        if let url = NSURL(string: URLJSON) {
            
            api.fetchDataOnline(url, completion: {
            
                data in
                completion({
                    
                let imoveisData = try data()
                    
                    if let responseObject = ResponseObject(data: imoveisData) {
                        
                        return .ResponseObjectImoveis(
                            status: responseObject.responseStatus!,
                            imoveis:responseObject.imoveis!.imoveis!)
                        
                        
                    } else {
                        throw Error.ErrorWithMsg(msg: "Error parsing Json file")
                    }
                    
                })
            
            
            })
            
        } else {
            fatalError("Invalid URL provided")
        }
        
        
    }
    
    func fetchImovel(forId imovelID:Int, completion:ImovelCompletionBlock) {
        
        if let url = URLBuilder.buildURLForImovelId(imovelID) {
            
            api.fetchDataOnline(url, completion: {
                
                data in
                completion({
                    
                    let imoveisData = try data()
                    let imovelData = imoveisData["Imovel"] as! [String:AnyObject]

                    if let imovel = Imovel(data:imovelData) {
                        return .ResponseObjectImovel(imovel: imovel)
                        
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