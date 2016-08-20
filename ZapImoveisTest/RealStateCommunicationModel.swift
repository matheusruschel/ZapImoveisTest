//
//  RealStateCommunicationModel.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

enum CallBackStatus {
    case ResponseObject(status:ResponseStatus, imoveis:[Imovel])
}

typealias RealStateCompletionBlock = (() throws -> CallBackStatus) -> Void

class RealStateCommunicationModel {
    
    let api = CommunicationModel()
    
    func fetchImoveis(completion:RealStateCompletionBlock) {
        
        if let url = NSURL(string: URLJSON) {
            
            api.fetchDataOnline(url, completion: {
            
                data in
                completion({
                    
                let imoveisData = try data()
                    
                    if let responseObject = ResponseObject(data: imoveisData) {
                        
                        return .ResponseObject(
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
    

}