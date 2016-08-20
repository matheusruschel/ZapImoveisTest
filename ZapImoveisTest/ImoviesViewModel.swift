//
//  ImoviesViewModel.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

protocol ImoveisViewModelDelegate {
    func didFinishLoadingImoveis(imoveisViewModel:ImoveisViewModel, sucess:Bool, errorMsg:String?)
}

class ImoveisViewModel {
    
    var delegate: ImoveisViewModelDelegate?
    private let imoveisAPI = RealStateCommunicationModel()
    var numberOfRowsInSection: Int {
    
        if let imoveis = imoveis {
            return imoveis.count
        } else {
            return 0
        }
    
    }
    private var imoveis:[Imovel]?
    var numberOfAnunciosText: String {
        
        if numberOfRowsInSection != 0 {
            return "\(numberOfRowsInSection) anúncios ativos"
        } else {
            return ""
        }
    }
    let justUpdatedText = "Atualizado a instantes"
    
    func fetchImoveis() {
        
        imoveisAPI.fetchImoveis({
        
            imoveisResponse in
        
            do {
                let callBackStatus = try imoveisResponse()
                
                switch callBackStatus {
                case .ResponseObject(_, let imoveis): self.imoveis = imoveis
                }
                
                self.delegate?.didFinishLoadingImoveis(self, sucess: true, errorMsg: nil)
                
            }catch Error.ErrorWithMsg(let msg) {
                self.delegate?.didFinishLoadingImoveis(self, sucess: false, errorMsg: msg)
            } catch {
                self.delegate?.didFinishLoadingImoveis(self, sucess: false, errorMsg: "Erro ao buscar imoveis")
            }
            
        })
        
    }
    
    func objectForIndexPath(indexPath:NSIndexPath) -> Imovel? {
        
        if indexPath.row < numberOfRowsInSection {
            return imoveis![indexPath.row]
        } else {
            return nil
        }
    }
    
}