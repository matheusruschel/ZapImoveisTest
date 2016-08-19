//
//  Foto.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

struct Foto {
    
    var urlImage:       String?
    var principal:      Bool?
    var descricao:      String?
    var origem:         String?
    var codImobiliaria: Int?
    
}
extension Foto: Wrappable {
    
    init?(data: AnyObject) {
        
        guard
            let urlImage   = data["UrlImagem"] as? String,
            let principal = data["Principal"] as? Bool,
            let descricao = data["Descricao"] as? String,
            let origem = data["Origem"] as? String,
            let codImobiliaria = data["CodImobiliaria"] as? Int else {
                return nil
        }
        
        self.init(urlImage:urlImage, principal:principal, descricao:descricao , origem:origem, codImobiliaria:codImobiliaria)
    }
}
