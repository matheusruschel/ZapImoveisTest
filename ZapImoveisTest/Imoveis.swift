//
//  Imoveis.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation


struct Imoveis {
    
    var quantidadeResultados:Int?
    var imoveis: [Imovel]?
}
extension Imoveis: Wrappable {
    
    init?(data: AnyObject) {
        
        guard let quantidadeResultados = data["QuantidadeResultados"] as? Int,
                  imoveisJson = data["Imoveis"] as? [AnyObject] else {
                return nil
        }
        
        var imoveis: [Imovel]?
        imoveis = imoveisJson.map({param in return Imovel(data:param)! })
        
        if imoveis == nil {
            return nil
        }
        self.init(quantidadeResultados:quantidadeResultados,imoveis:imoveis)
    }
}