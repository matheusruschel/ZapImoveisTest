//
//  RealState.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

struct Imovel {
    
    var codImovel:      Int?
    var tipoImovel:     String?
    var endereco:       Endereco?
    var precoVenda:     Int?
    var precoLocacao:   Int?
    var fotos:          [Foto]?
    var subTipoImovel:  String?
    var zapId:          String?
    var numeroQuartos:  Int?
    var numeroGaragens: Int?
    var metrosQuadrados:Int?
    var banheiros:      Int?
    
    func getPreferredPhoto() -> Foto? {
        
        if let fotos = fotos {
            for foto in fotos {
                if foto.principal! {
                    return foto
                }
            }
        }
        
        return nil
    }
    
}

extension Imovel : Wrappable {
    
    init?(data: AnyObject) {
        
        guard
            let codImovel   = data["CodImovel"] as? Int,
            let tipoImovel = data["TipoImovel"] as? String,
            let enderecoJson = data["Endereco"],
            let precoVenda = data["PrecoVenda"],
            let precoLocacao = data["PrecoLocacao"],
            let fotosJSon = data["Fotos"] as? [AnyObject],
            let subTipoImovel = data["SubtipoImovel"] as? String,
            let zapId = data["ZapID"] as? String,
            let numeroQuartos = data["Dormitorios"],
            let banheiros = data["Suites"],
            let numeroGaragens = data["Vagas"],
            let metrosQuadrados = data["AreaTotal"] else {
                return nil
        }
        
        var fotos = [Foto]()
        
        for fotoJSon in fotosJSon {
            
            if let foto = Foto(data: fotoJSon) {
                fotos.append(foto)
            } else  {
                return nil
            }
        }
        
        guard let endereco = Endereco(data: enderecoJson!) else {
            return nil
        }
        
        
        
        self.init(codImovel:codImovel,
                  tipoImovel:tipoImovel,
                  endereco:endereco ,
                  precoVenda:precoVenda as? Int,
                  precoLocacao:precoLocacao as? Int,
                  fotos:fotos,
                  subTipoImovel:subTipoImovel,
                  zapId:zapId,
                  numeroQuartos: numeroQuartos as? Int,
                  numeroGaragens: numeroGaragens as? Int,
                  metrosQuadrados: metrosQuadrados as? Int,
                  banheiros:banheiros as? Int)

        
    }
    
    
}


